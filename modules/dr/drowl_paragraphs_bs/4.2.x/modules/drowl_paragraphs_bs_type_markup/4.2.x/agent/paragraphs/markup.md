<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `markup` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_markup -y` (pulls in the base module).

## What it installs (config/install)
- `paragraphs.paragraphs_type.markup` — the bundle.
- `field.storage.paragraph.field_markup` + `field.field.paragraph.markup.field_markup` — a `text_long`
  field, label 'Markup (HTML)', `required: false`, translatable, `allowed_formats: {}`.
- `field.field.paragraph.markup.field_settings` — the shared settings field.
- Form display: `field_markup` uses `text_textarea` (5 rows); `field_settings` uses the DROWL settings widget.
- View display (`core.entity_view_display.paragraph.markup.default`): `field_markup` uses **`text_default`**
  (label hidden); `field_settings` and the preview placeholder are hidden.

## Rendering / filtering
The `text_default` formatter emits `#type => 'processed_text'`, i.e. it runs the stored value through
`check_markup()` with the **text format saved on that value**. So what HTML survives is entirely
determined by that format's filters, and which formats an editor can choose is governed by core's
`use text format <id>` permissions. A site that only grants restricted formats to editors gets filtered
output; granting an unfiltered/raw format (a trusted permission) allows literal HTML/scripts — which is
the intended "for experts" behavior of this bundle. The shipped field default value carries format
`html_raw_token` (a DROWL-ecosystem format).

## `.module`
`drowl_paragraphs_bs_type_markup_preprocess_paragraph__markup()` appends
`<span class="empty-check-workaround element-hidden">&nbsp;</span>` to the field's `#suffix` so that
markup with no visible output is not suppressed by empty-region checks.
