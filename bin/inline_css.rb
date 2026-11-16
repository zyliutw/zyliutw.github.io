#!/usr/bin/env ruby
# frozen_string_literal: true

# Post-build step: put the site's own stylesheets directly into each HTML page.
#
# A browser cannot draw anything until every stylesheet in <head> has arrived, and fetching them
# costs an extra round trip to the server after the HTML. The purged stylesheets are small, so
# embedding them lets the first paint happen as soon as the HTML itself has been received.
#
# Usage: ruby bin/inline_css.rb _site     (run after PurgeCSS, on the built site)

site = ARGV[0] || '_site'
abort "#{site} is not a directory" unless File.directory?(site)

LINK = /<link\b[^>]*>/i.freeze
cache = {}
pages = 0
inlined = 0

Dir.glob(File.join(site, '**', '*.html')).sort.each do |page|
  html = File.read(page, encoding: 'UTF-8')
  changed = false

  html = html.gsub(LINK) do |tag|
    next tag unless tag =~ /\brel=["']?stylesheet["']?/i

    href = tag[/\bhref=(?:"([^"]*)"|'([^']*)'|([^\s>]+))/i] && ($1 || $2 || $3)
    # only stylesheets served by this site; anything external is left as a normal <link>
    next tag unless href && href.start_with?('/assets/css/')

    path = File.join(site, href.sub(/[?#].*\z/, ''))
    next tag unless File.file?(path)

    css = cache[path] ||= begin
      text = File.read(path, encoding: 'UTF-8')
      # a byte-order mark or @charset rule is only meaningful at the start of a .css file; inside
      # <style> the mark would become part of the first selector and silently break that rule
      text = text.delete("\uFEFF").gsub(/@charset\s+"[^"]*";/i, '')
      text = text.gsub(%r{/\*# sourceMappingURL=.*?\*/}m, '')
      # url(../fonts/x) is relative to /assets/css/; once inline it must be absolute
      text = text.gsub(%r{url\(\s*(["']?)\.\./}) { "url(#{Regexp.last_match(1)}/assets/" }
      text.strip
    end
    # never embed anything that could close the <style> element early
    next tag if css =~ %r{</style}i

    id = tag[/\bid=(?:"([^"]*)"|'([^']*)'|([^\s>]+))/i] && ($1 || $2 || $3)
    media = tag[/\bmedia=(?:"([^"]*)"|'([^']*)'|([^\s>]+))/i] && ($1 || $2 || $3)
    attrs = +''
    attrs << %( id="#{id}") if id && !id.empty?
    attrs << %( media="#{media}") if media && !media.empty?
    changed = true
    inlined += 1
    "<style#{attrs}>#{css}</style>"
  end

  next unless changed

  File.write(page, html)
  pages += 1
end

puts "inline_css: embedded #{inlined} stylesheet references in #{pages} pages"
