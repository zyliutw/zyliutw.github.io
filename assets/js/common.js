// (formerly a separate file, no_defer.js - merged here to save a request)
// add bootstrap classes to tables
$(document).ready(function () {
  $("table").each(function () {
    if (document.documentElement.getAttribute("data-theme") == "dark") {
      $(this).addClass("table-dark");
    } else {
      $(this).removeClass("table-dark");
    }

    // only select tables that are not inside an element with "news" (about page) or "card" (cv page) class
    if ($(this).parents('[class*="news"]').length == 0 && $(this).parents('[class*="card"]').length == 0 && $(this).parents("code").length == 0) {
      // make table use bootstrap-table
      $(this).attr("data-toggle", "table");
      // add some classes to make the table look better
      // $(this).addClass('table-sm');
      $(this).addClass("table-hover");
    }
  });
});

$(document).ready(function () {
  // add toggle functionality to abstract and bibtex buttons
  $("a.abstract").click(function () {
    $(this).parent().parent().find(".abstract.hidden").toggleClass("open");
    $(this).parent().parent().find(".bibtex.hidden.open").toggleClass("open");
  });
  $("a.bibtex").click(function () {
    $(this).parent().parent().find(".bibtex.hidden").toggleClass("open");
    $(this).parent().parent().find(".abstract.hidden.open").toggleClass("open");
  });
  $("a").removeClass("waves-effect waves-light");

  // bootstrap-toc
  if ($("#toc-sidebar").length) {
    // remove related publications years from the TOC
    $(".publications h2").each(function () {
      $(this).attr("data-toc-skip", "");
    });
    var navSelector = "#toc-sidebar";
    var $myNav = $(navSelector);
    Toc.init($myNav);

    // Highlight the section being read. Bootstrap's scrollspy only looks at the top of the
    // viewport, so short sections near the end of a page are never highlighted. Instead, use a
    // probe line that moves from just below the navbar to the bottom of the viewport as the
    // page scrolls, so that every section is reached in order.
    var $tocLinks = $myNav.find("a.nav-link");
    var tocPinned = false;
    var setActiveTocLink = function (link) {
      $tocLinks.removeClass("active");
      if (link) {
        $(link).addClass("active");
      }
    };
    var updateToc = function () {
      if (tocPinned) {
        return;
      }
      var maxScroll = document.documentElement.scrollHeight - window.innerHeight;
      var progress = maxScroll > 0 ? Math.min(1, window.scrollY / maxScroll) : 0;
      var topOffset = ($("#navbar").outerHeight() || 56) + 20;
      var probe = window.scrollY + topOffset + progress * (window.innerHeight - topOffset);
      var current = null;
      $tocLinks.each(function () {
        var target = document.getElementById(decodeURIComponent(this.getAttribute("href").slice(1)));
        if (target && target.getBoundingClientRect().top + window.scrollY <= probe) {
          current = this;
        }
      });
      setActiveTocLink(current);
    };
    // after a click, keep the chosen entry highlighted until the reader scrolls again
    $tocLinks.on("click", function () {
      tocPinned = true;
      setActiveTocLink(this);
    });
    ["wheel", "touchmove", "keydown"].forEach(function (eventName) {
      window.addEventListener(
        eventName,
        function () {
          tocPinned = false;
        },
        { passive: true }
      );
    });
    $(window).on("scroll resize", updateToc);
    updateToc();
  }
});
