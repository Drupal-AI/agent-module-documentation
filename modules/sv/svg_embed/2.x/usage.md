SVG Embed provides a text-format filter that replaces references to uploaded SVG files with the actual inline SVG markup, translating any text strings in the graphic to the page's language along the way.

---

Inline SVG (as opposed to an `<img src>` reference) keeps the graphic's text as real, selectable, searchable text and lets it be styled with CSS and translated per language. SVG Embed lets an author drop an SVG into rich-text body content through one of several reference syntaxes — a `[svg:FILE_ID]` or `[svg:FILENAME]` token, a CKEditor file embed, or a `drupal-media` embed of an SVG media item — and the filter swaps that reference for the file's SVG source at render time. Before the SVG is placed into the page it is run through the `enshrined/svg-sanitize` library, and if the core `locale` module is enabled the filter walks the SVG's `<text>`/`<tspan>` nodes and substitutes translations stored under the `svg_embed` string context, so the same graphic renders in the correct language for each visitor. It only requires uploading the SVG as a managed file and enabling the filter on the desired text format(s); it adds no permissions, routes, or configuration form of its own.

---

- Embed an inline SVG logo in a node body with `[svg:123]` (file id).
- Embed an SVG by filename with `[svg:diagram.svg]` when you don't know the file id.
- Turn a CKEditor file embed of an `.svg` upload into inline SVG automatically.
- Turn a `drupal-media` embed of an SVG media item into inline SVG.
- Keep SVG text as real, selectable text for better SEO and searchability.
- Style embedded SVG (fills, strokes, sizes) with site or theme CSS.
- Show a language-specific version of a diagram on a multilingual site.
- Localise the labels of an infographic without maintaining one file per language.
- Reuse a single master SVG across all site languages.
- Display icons inline so they inherit `currentColor` from surrounding text.
- Embed a chart whose axis/legend labels translate with the interface language.
- Add an inline SVG banner or illustration inside long-form article content.
- Render org charts or process diagrams inline in body fields.
- Present an SVG map with translatable region labels.
- Enable the filter only on trusted, editor-facing text formats.
- Place the SVG Embed filter last in a format's filter order so nothing rewrites its output.
- Extract SVG strings for translation via the `svg_embed` locale string context.
- Import translated SVG strings through Drupal's interface-translation workflow.
- Serve the same embedded SVG in different languages per node translation.
- Embed vector illustrations that scale crisply on high-DPI screens.
- Combine with core Media so editors pick SVGs from the media library.
- Reference the same SVG multiple times in one body (each unique file resolved once).
