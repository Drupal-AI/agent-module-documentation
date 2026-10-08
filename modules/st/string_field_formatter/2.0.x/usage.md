<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
String Field Formatter adds a "Plain string formatter" display formatter for plain `string` and `string_long` fields that can wrap the field's output in a chosen HTML tag (h1–h6, p, span, div, blockquote, code, …) with custom CSS classes.

---

The module contributes a single field formatter plugin, `plain_string_formatter` (class `PlainStringFormatter` extending core's `StringFormatter`), applicable to the `string` and `string_long` field types. On a bundle's *Manage display* page you select it as the field's format and get two extra settings on top of core's string formatter: **Wrapper tag** (`wrap_tag`, a select of common semantic HTML tags plus DIV/SPAN, defaulting to `_none` = no wrapper) and **Classes for wrapper tag** (`wrap_class`, a space/comma-separated list run through `Html::getClass()`). When a wrapper tag is chosen, `viewElements()` renders each field value inside an `html_tag` render element with those classes; when it is `_none` the output is identical to the core string formatter. It also inherits core's `link_to_entity` option. Settings are stored in the field component of the `entity_view_display` config entity (config schema `field.formatter.settings.plain_string_formatter` extends `field.formatter.settings.string`). The module has no settings form of its own, no configure route, no permissions, no Drush, and no services — it is purely a display-formatter plugin. This is handy for turning a plain-text field (e.g. a subtitle) into a real heading without a custom template or the overhead of a formatted-text field.

---

- Render a plain-text "Subtitle" string field as an `<h2>` heading.
- Wrap a short string field in a `<span>` with a utility CSS class.
- Output a tagline field inside a `<blockquote>`.
- Display a code/reference string field inside a `<code>` tag.
- Add BEM/utility classes to a field's wrapper for styling (`field-title is-large`).
- Turn a "Section title" string field into an `<h3>` without editing Twig.
- Present a string field as a `<p>` paragraph element.
- Show an author/attribution string inside a `<cite>` element.
- Emphasize a string value with `<strong>` or `<em>` wrappers.
- Give a string_long summary field a semantic `<div>` wrapper with classes.
- Mark up a date/label string with `<time>` or `<small>`.
- Keep a field's markup semantic for accessibility (proper heading levels).
- Standardize heading levels for a repeated field across view modes.
- Wrap a product SKU string in a `<span class="sku">` for CSS targeting.
- Provide an inline `<mark>` highlight around a string value.
- Add classes to a field wrapper so JS can hook onto it.
- Convert a plain string field into styled markup without a WYSIWYG/formatted field.
- Configure different wrapper tags per view mode (teaser vs full).
- Output an abbreviation string in an `<abbr>` element.
- Use `<kbd>`/`<samp>` wrappers for technical documentation string fields.
- Replace a custom preprocess/template just to wrap a field in a tag.
- Apply a consistent wrapper + class to a taxonomy or user string field on display.
- Render a call-to-action label string as a class-bearing `<div>` for theming.
