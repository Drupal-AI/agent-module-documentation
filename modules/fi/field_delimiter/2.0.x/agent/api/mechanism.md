<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works

Three hook implementations in `field_delimiter.module`, no classes or services.

- **`hook_field_formatter_third_party_settings_form()`** — for a field whose
  `getFieldStorageDefinition()->isMultiple()` is TRUE, adds a `textfield` named `delimiter`
  (size 5) to the formatter's settings form, defaulting to the current
  `field_delimiter.delimiter` third-party setting (XSS-filtered).
- **`hook_field_formatter_settings_summary_alter()`** — appends *"Delimited by: @delimiter"* to
  the formatter summary when a delimiter is set on a multi-value field.
- **`hook_preprocess_field()`** — the render side. Bails if fewer than 2 items. Otherwise loads
  the render display (`EntityViewDisplay::collectRenderDisplay`), reads
  `third_party_settings.field_delimiter.delimiter`, XSS-filters it (allowing `br, hr, span, img,
  wbr`), and sets `$item['content']['#suffix'] = $safe_delimiter` on every item **except the
  last**. The result is an inline, delimiter-separated list.

Net effect: display-only, per view-mode, no change to stored field values; single-value fields
are never affected.
