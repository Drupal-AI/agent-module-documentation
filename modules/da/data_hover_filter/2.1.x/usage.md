<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A text-format filter that copies each link's visible text into a `data-hover` attribute on the `<a>` tag.

---

Data hover Filter provides one core Filter plugin (`filter_attribute`, "Data hover Filter"). When the filter is enabled on a text format, it parses the rendered HTML, finds every `<a>` element, and sets a `data-hover` attribute equal to the anchor's trimmed text content. Links with empty text are left untouched. The purpose is purely presentational: themes and CSS can read the `data-hover` value (for example, echoing it in a `::before`/`::after` pseudo-element) to build animated hover states or tooltips without editors adding the attribute manually. It is a `TYPE_TRANSFORM_IRREVERSIBLE` filter, has no settings form, ships no config or permissions of its own, and works on Drupal 8 through 12.

---

- Automatically add a `data-hover` attribute to every link in filtered text.
- Mirror each link's visible label into its `data-hover` attribute.
- Drive CSS hover effects and tooltips from the link text.
- Build "fill/slide" animated link styles that duplicate the label via a pseudo-element.
- Enable the filter on a specific text format (Basic HTML, Full HTML, etc.).
- Apply the transformation only where the format is used (body fields, comments, etc.).
- Avoid asking content editors to hand-author `data-hover` attributes.
- Keep WYSIWYG source clean while still emitting the presentational attribute.
- Skip links that have no text content (e.g. image-only anchors).
- Combine with theme CSS to show the destination label on hover.
- Support marketing/landing pages with fancy animated menus of links.
- Add consistent hover metadata across all links in rich-text content.
- Order the filter after other filters that produce links so generated links are covered.
- Run on Drupal 8, 9, 10, 11, and 12 sites.
- Use as a lightweight, dependency-free enhancement (only core Filter required).
- Leave link `href`, classes, and other attributes unchanged.
- Provide a `tips()` description shown under the text-format editor.
