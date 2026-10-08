<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Webform (drowl_paragraphs_bs_type_webform) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `webform` Paragraph type.

- **Field**: `field_webform` (field type `webform`, required, label 'Webformular').
- Displayed with **`webform_entity_reference_entity_view`** (`source_entity: true`, label hidden) — the
  Webform module renders the form and owns submission/access handling.
- Shared `field_settings` (hidden). Layout Builder disabled.
- No routes/permissions/services/schema of its own. Depends on `webform`.

See [paragraphs/webform.md](paragraphs/webform.md).
