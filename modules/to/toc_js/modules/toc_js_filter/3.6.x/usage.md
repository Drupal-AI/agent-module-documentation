<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toc.js Filter adds a text-format filter that replaces the `[toc]` token in body text with a rendered Toc.js table of contents, configured through the filter's own settings.

---

This submodule of Toc.js provides a single text filter plugin, `toc_js_filter` (title "TOC.js shortcode: [toc]", type `TYPE_TRANSFORM_IRREVERSIBLE`). Enable it on a text format and any `[toc]` occurrence in that field's text is replaced with a Toc.js table of contents. The filter's settings form mirrors the Toc.js block/node settings (built by `TocJsService::getTocForm()`), and the settings are stored in the format's filter config, validated by schema `filter_settings.toc_js_filter` (title, selectors, container, list type, smooth scrolling, back-to-top, sticky, collapsible, ajax, etc.). At processing time the filter renders a `toc_js` build with those settings (via `TocJsService::buildToc()`), captures the render metadata (attached libraries, cache tags for the route entity, `url.path` context), and injects the resulting markup where `[toc]` appeared. It requires the Toc.js module. Because the table of contents is still generated client-side by the toc.js library, the `[toc]` placeholder becomes an empty `.toc-js` container that the browser populates from the page's headings.

---

- Let editors drop a `[toc]` token into body text to place a table of contents inline.
- Add a TOC inside an article's WYSIWYG content without configuring the content type.
- Give writers control over exactly where the TOC appears within the prose.
- Configure per-format TOC settings (selectors, container, list type) for `[toc]`.
- Enable `[toc]` only on specific text formats (e.g. Full HTML) for trusted editors.
- Provide a TOC for pages not covered by the content-type extra field or block.
- Use different `[toc]` settings on different text formats.
- Insert multiple `[toc]` placeholders (each rendered) in long-form content.
- Keep TOC placement in the content itself, portable across displays.
- Combine `[toc]` with other filters in a format's processing pipeline.
- Render a client-side TOC from headings following the `[toc]` marker.
- Set smooth scrolling / highlight-on-scroll for inline `[toc]` tables.
- Add back-to-top links to an inline TOC via the filter settings.
- Support taxonomy or custom pages by using `[toc]` in their text fields.
- Let content teams add a TOC without site-builder access to display settings.
- Migrate content that used a shortcode-style TOC to Drupal.
- Provide a documentation format where `[toc]` always yields a TOC.
- Control the TOC title text for inline `[toc]` per format.
- Restrict `[toc]` heading collection to a container selector.
- Keep the TOC markup minimal (empty container) and let JS build it client-side.
