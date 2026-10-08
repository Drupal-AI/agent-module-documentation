<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG Formatter adds an "SVG Formatter" field formatter that renders SVG files uploaded into a plain **file** field, either as an `<img>` tag or as sanitized inline `<svg>` markup.

---

Core's Image field rejects SVG because SVG has no raster dimensions, so the module's approach is to let you upload SVGs into an ordinary **File** field (with `svg` in the allowed extensions) and then render them properly. The single plugin `svg_formatter` applies to `file` and `image` fields — on `image` fields it is only offered when the `svg_image` contrib module is also enabled (`isApplicable()`). At render time it skips any item whose MIME type is not `image/svg+xml`, so a mixed file field degrades gracefully. Nine settings control the output: `inline`, `sanitize`, `apply_dimensions`, `width`, `height`, `enable_alt`, `alt_string`, `enable_title`, `title_string`. In non-inline mode it emits `<img src="…" width height alt title>`; alt/title default to a prettified filename (`.svg` stripped, `-`/`_` turned into spaces, ucfirst) but can be driven by tokens against the file and the parent entity when the Token module is installed. In inline mode the file's contents are read from disk, optionally passed through `enshrined\svgSanitize\Sanitizer` (bundled via Composer — the checkbox is disabled when the library is absent), then loaded into a `DOMDocument` where the configured width/height are set on the root `<svg>` element and, if a title is enabled, a `<title>` element with a unique id is inserted and referenced from `aria-labelledby`. Everything is printed by the `svg_formatter` theme hook and its `svg-formatter.html.twig` template, which is the single override point for custom markup. The module has no admin page, no permissions, no services and no Drush commands; its entire configuration lives in the formatter settings of an `entity_view_display`.

---

- Display an uploaded company logo SVG on a node without converting it to PNG.
- Show SVG icons stored in a File field at a fixed 32×32 size.
- Output SVG inline so CSS can recolour its paths on hover.
- Animate parts of an SVG with JavaScript by rendering it inline rather than in an `<img>`.
- Sanitize untrusted editor-uploaded SVGs before inlining them to avoid XSS.
- Add an accessible `<title>` and `aria-labelledby` to inline SVGs automatically.
- Derive the `alt` text from the file name when editors do not provide one.
- Drive `alt` from a token such as `[node:title]` so it follows the parent entity.
- Drive `title` from a media entity field via tokens.
- Render SVG maps or diagrams attached to an article.
- Serve vector icons for retina displays without image styles.
- Keep SVGs out of the Image field pipeline so no image toolkit is required.
- Mix SVG and non-SVG files in one field and only render the SVGs.
- Apply the formatter on a media entity's `field_media_file` for an "SVG" media type.
- Show client logos in a taxonomy term display as inline, themable SVGs.
- Give every rendered SVG the same width/height across a view mode.
- Skip dimension attributes entirely and let CSS size the SVG.
- Override `svg-formatter.html.twig` to wrap SVGs in a custom container.
- Add a `<use>`/sprite-friendly inline output for icon systems.
- Provide different sizes per view mode (small in teaser, large in full).
- Use SVG Formatter alongside `svg_image` so the formatter is also available on Image fields.
- Avoid a custom preprocess hook just to print an uploaded SVG file's contents.
- Render SVG illustrations in a Layout Builder field block.
- Ensure SVG output is XSS-safe on sites that let authenticated users upload files.
