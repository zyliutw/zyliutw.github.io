# Numbers the publications in the bibliography by category, oldest first:
#   J1, J2, ... journal articles      (@article)
#   C1, C2, ... conference papers     (@inproceedings)
#   E1, E2, ... preprints             (@article whose journal is arXiv/CoRR or the IACR ePrint archive)
# Other entry types are not numbered.
# The labels are exposed to templates as site.data.publication_labels[<bib key>]
# and shown in front of each title by _layouts/bib.liquid.
#
# Ordering: by year; within the same year the bib file is assumed to list newer
# papers first, so an entry placed higher in the file gets the larger number.

require 'bibtex'

module PublicationLabels
  PREPRINT_VENUES = /corr|arxiv|eprint/i.freeze

  def self.prefix_for(entry)
    case entry.type
    when :article then entry[:journal].to_s =~ PREPRINT_VENUES ? 'E' : 'J'
    when :inproceedings then 'C'
    end
  end

  def self.build(site)
    scholar = site.config['scholar'] || {}
    source = (scholar['source'] || '_bibliography').to_s.sub(%r{^/}, '')
    file = scholar['bibliography'] || 'references.bib'
    file += '.bib' if File.extname(file).empty?
    path = File.join(site.source, source, file)
    return {} unless File.exist?(path)

    entries = BibTeX.parse(File.read(path, encoding: 'UTF-8')).select { |e| e.respond_to?(:key) }
    labels = {}
    entries.each_with_index
           .group_by { |entry, _| prefix_for(entry) }
           .each do |prefix, group|
      next if prefix.nil?

      group.sort_by { |entry, position| [entry[:year].to_s.to_i, -position] }
           .each_with_index { |(entry, _), i| labels[entry.key.to_s] = "#{prefix}#{i + 1}" }
    end
    labels
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  site.data['publication_labels'] = PublicationLabels.build(site)
end
