<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Sanitizer — the formatter

## Selecting it

On an entity bundle's *Manage display* (`entity_view_display`), for a `file`, `svg_icon`, or
`svg_image_field` field, choose the **SVG Sanitizer** formatter (id `svg_sanitizer`). There is no
site-wide setting — behavior is entirely per field/view-mode.

## Settings (`field.formatter.settings.svg_sanitizer`)

- `allowedtags` (string) — comma-separated extra tag names **added** to the library's default
  allow-list.
- `allowedattrs` (string) — comma-separated extra attribute names **added** to the default
  attribute allow-list.

Both default to `''`. The settings summary shows "Custom tags: …" / "Custom attributes: …".

## Pipeline (`SvgSanitizer::viewElements()` → `::sanitize()`)

For each field item with a referenced entity:
1. `getFileUri()` → `file_get_contents()` reads the raw SVG (skipped if the file is missing).
2. A new `enshrined\svgSanitize\Sanitizer` is built.
3. `SvgSanitizerTags::setTags($allowedtags)` then `setAllowedTags()` — `getTags()` returns
   `AllowedTags::getTags()` (library defaults) plus the trimmed custom tags.
4. `SvgSanitizerAttributes::setAttributes($allowedattrs)` then `setAllowedAttrs()` — same pattern
   over `AllowedAttributes::getAttributes()`.
5. `$sanitizer->sanitize($svg)` returns the cleaned XML, emitted as
   `['#type' => 'markup', '#markup' => Markup::create($clean)]` — i.e. **inline SVG**, trusted
   because it has been sanitized.

## Important behavior notes

- **Display-time only.** The module adds no `hook_file_validate` / upload hook. An SVG is sanitized
  only on the view modes where this formatter is chosen; a file-download link, image formatter, or
  any other renderer serves the original unsanitized bytes. Apply this formatter on **every** display
  that shows untrusted SVGs inline, and consider upload-side extension/scan controls separately.
- `Markup::create()` marks the sanitizer's output as safe, so it is not re-escaped — correctness
  depends entirely on the `enshrined/svg-sanitize` allow-lists. Widening `allowedtags`/`allowedattrs`
  (e.g. re-allowing `script` or `on*` handlers) re-introduces XSS; only add elements you trust.
- The helper classes use static state (`SvgSanitizerTags::$tags`) set per render, so custom
  allow-lists are scoped to each formatter instance's settings.
