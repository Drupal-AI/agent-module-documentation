<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webform` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_webform -y`.

## What it installs (config/install)
- `paragraphs.paragraphs_type.webform` — the bundle.
- `field.storage.paragraph.field_webform` (`webform` field type) +
  `field.field.paragraph.webform.field_webform` (required, label 'Webformular'; description links to
  `admin/structure/webform` to create webforms if the editor is authorized).
- `field.field.paragraph.webform.field_settings` — shared settings field.
- View display: `field_webform` rendered by **`webform_entity_reference_entity_view`** with
  `source_entity: true` (label hidden, fences div); settings + preview placeholder hidden; Layout Builder
  disabled.

## Access / submission
All form rendering, access control, validation, submission storage and confirmation are handled by the
Webform module and the referenced webform's own settings/handlers. This bundle only selects which webform
to display and where.
