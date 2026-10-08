<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Embed (svg_embed) — agent index

A single **text-format filter** that replaces references to uploaded **SVG files** with the
file's **inline SVG markup**, optionally translating the graphic's text strings to the render
language. Package `Media`. Core `^10 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. Version
dir `2.x` (installed 2.1.3).

- **The filter, its reference syntaxes, sanitize + translate pipeline, and how to enable it** →
  [plugins/filter.md](plugins/filter.md)

## What it actually is

- One filter plugin: `SvgEmbed` (id **`svg_embed`**, type `TYPE_TRANSFORM_IRREVERSIBLE`), in
  `src/Plugin/Filter/SvgEmbed.php`, extending core `FilterBase`. Enabled per text format at
  `admin/config/content/formats`.
- One service: **`svg_embed.process`** → `SvgEmbedProcess` (`src/SvgEmbedProcess.php`,
  interface `SvgEmbedProcessInterface`), which loads the SVG, sanitizes it, translates its
  strings, and returns the inline `<svg>` string.
- **No routes, no permissions, no config schema, no install file, no submodules, no Drush.**
  Composer requires the **`enshrined/svg-sanitize`** library plus `ext-dom` / `ext-simplexml`.
  Uses core `filter` (implicit) and, when present, core `locale` for translation.

## Mechanism (from source)

- `SvgEmbed::process()` handles three reference forms and rewrites each to an internal
  `<svgembed>UUID</svgembed>` placeholder, then substitutes the produced SVG:
  1. **CKEditor file embeds** — `//*[@data-entity-type="file" and @data-entity-uuid]` nodes whose
     `tagName === 'svg'`.
  2. **Media embeds** — `//*[@data-entity-type="media" ...]` `drupal-media` nodes; loads the
     media, resolves its source field's file, and only proceeds when the file's `filemime`
     contains `svg`.
  3. **Text tokens** — `[svg:ID]` (numeric → `File::load`) or `[svg:FILENAME]`
     (`loadByProperties(['filename' => …])`); unknown ⇒ literal "SVG not found".
  Each unique file UUID is processed once per pass.
- `SvgEmbedProcess::translate()` calls `loadFile()` which `file_get_contents()`s the managed
  file's URI and runs it through `enshrined\svgSanitize\Sanitizer::sanitize()` before parsing to
  `SimpleXMLElement`. If `locale` is enabled, `embedTranslate()` recurses the DOM and swaps
  `<text>`/`<tspan>` strings for translations from `locales_source`/`locales_target` filtered by
  the **`svg_embed`** string context. Returns the serialized markup from the first `<svg` tag.

## Notes

- The filter only fires when the input contains `data-entity-type="file"`/`"media"` or a `[svg:`
  token, so it is cheap on text without SVG references.
- Reads only **managed-file** URIs (by file entity / UUID) — no request- or config-supplied
  path is fetched, so no path-traversal or SSRF surface.
- Queries use parameterized `->condition()` (no string-concatenated SQL).
