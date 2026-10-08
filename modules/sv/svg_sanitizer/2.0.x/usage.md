<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG Sanitizer provides a field formatter that renders an uploaded SVG file inline after passing it through the `enshrined/svg-sanitize` library, stripping scripts and other dangerous markup so SVGs can be embedded safely.

---

The module is a thin Drupal wrapper around the [enshrined/svg-sanitize](https://github.com/darylldoyle/svg-sanitizer)
PHP library. It ships a single field formatter, `svg_sanitizer`, usable on `file`, `svg_icon`, and
`svg_image_field` field types. When output, the formatter reads each referenced file's contents, runs
`Sanitizer::sanitize()` over the SVG XML (removing `<script>`, event handlers, external references and
anything not on the library's allow-lists), and prints the cleaned SVG **inline** via
`Markup::create()` so it renders as vector markup rather than an `<img>`. Two per-formatter settings —
*Allowed Tags* and *Allowed Attributes* (comma-separated) — are appended to the library's default
allow-lists through the module's `SvgSanitizerTags`/`SvgSanitizerAttributes` helper classes, letting you
permit extra elements/attributes the defaults strip. There is **no global config page, no permissions,
and no upload-time hook**: sanitization happens only where this formatter is selected on a *Manage
display* view mode. Any other formatter (e.g. a plain file link or a different SVG renderer) bypasses it,
so choose this formatter on every display where untrusted SVGs are shown inline. Settings are stored in
the `entity_view_display` component (schema `field.formatter.settings.svg_sanitizer`).

---

- Render an uploaded SVG inline while stripping embedded `<script>` and JS event handlers.
- Safely display user-uploaded SVG logos or icons without a stored-XSS risk from the markup.
- Sanitize SVGs referenced by a core `file` field on display.
- Sanitize SVGs stored in an `svg_image_field` field.
- Sanitize SVGs stored in an `svg_icon` field.
- Output SVG as inline vector markup (stylable/animatable) instead of an `<img>` tag.
- Allow an extra SVG tag the library strips by default (e.g. a filter/animation element) per display.
- Allow an extra SVG attribute the library strips by default, per display.
- Provide different allow-lists per view mode (teaser vs full) for the same field.
- Clean up SVGs authored in tools that inject editor-specific metadata or scripts.
- Serve third-party / editor-supplied SVGs inline with a defense-in-depth sanitize step.
- Reuse the well-maintained enshrined/svg-sanitize allow-lists inside Drupal.
- Add inline-SVG rendering to a media/DAM workflow with sanitization built in.
- Display decorative vector icons that must inherit `currentColor` from CSS.
- Harden an existing SVG upload feature by switching its display to the sanitizing formatter.
- Combine with a file-extension/upload validation module for both upload- and display-time safety.
