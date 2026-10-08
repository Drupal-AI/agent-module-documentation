<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Responsive Slideshow installs a dedicated "Responsive Slideshow" content type and a block that renders the most recent published slides as a Bootstrap 5 carousel, for sites whose theme already ships Bootstrap 5.

---

The mechanism is content-driven, not a field formatter. Installing the module creates a locked `responsive_slideshow` content type (fields: a required slide **image**, a plain-text **teaser**, a rich-text **body**, a **link**, and a **hide-detail-page** boolean), an image style `responsive_slideshow_style` that scale-and-crops to 1320x347, and default settings. You author slides as nodes of that type, then place the module's **Responsive Slideshow** block (plugin id `responsive_slideshow`, category "Blocks") in a region — typically the front page. On render the block runs `responsive_slideshow_homepage()`, which queries published `responsive_slideshow` nodes joined to the image field, in the current or unspecified language, ordered by `changed` DESC and limited to the configured slide count (node-access tagged). For each slide it builds the image URL through the image style, HTML-escapes the alt/title, truncates the node title to 90 characters and the description (teaser, or body run through the `restricted_html` format) to a configurable length, and resolves the link — either the node's own detail page, or the value of the Link field when "hide detail page" is set. It renders the `slideshow_data` theme hook (`templates/slideshow-data.html.twig`) as ordinary Bootstrap 5 carousel markup (`data-bs-ride`, indicators, prev/next controls). Crucially the module ships **only** a CSS library and **no slider JavaScript**: the carousel is driven by Bootstrap's own JS, which must come from the site's Bootstrap 5 theme, so on a non-Bootstrap site the slideshow will not animate. The value is entirely in that qualifier — on a Bootstrap theme it adds no library and no weight; anywhere else it is the wrong choice, which is the first thing to establish. A settings form at `/admin/config/user-interface/responsive_slideshow` (permission `administer responsive slideshow`) controls slide count, description length, and auto-advance interval in milliseconds; the block output is uncached (`max-age 0`). Note also the general carousel caveats: Bootstrap's carousel has acknowledged accessibility limitations (auto-advance without an accessible pause control, un-announced slide transitions), and content past the first slide is largely unseen — build one on the merits, not because the template had one.

---

- Add a homepage hero slideshow to a Bootstrap 5 Drupal site.
- Render rotating featured content as a Bootstrap carousel.
- Manage slides as editable nodes rather than a widget config blob.
- Show the N most recently updated slides automatically.
- Place a slideshow block in the front-page content region.
- Author a slide with an image, title, teaser, and link.
- Link a slide to its node detail page.
- Link a slide to an external URL instead of a detail page.
- Set how many slides the carousel shows.
- Set the auto-advance interval between slides.
- Truncate slide descriptions to a fixed character length.
- Reuse the site's Bootstrap theme without adding a second slider library.
- Crop all slide images to a consistent 1320x347 through an image style.
- Adjust slide image dimensions by editing the `responsive_slideshow_style` image style.
- Show a promotional or campaign banner rotation.
- Show partner or product logos in rotation.
- Give editors a simple content type for banner management.
- Restrict who can configure the slideshow via a dedicated permission.
- Keep front-page page weight low on a Bootstrap theme.
- Provide a multilingual slideshow that falls back to the default language.
- Decide whether a carousel is warranted before building one.
- Disable auto-advance and verify keyboard operation for accessibility conformance.
