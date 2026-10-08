<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph View Mode — agent index

Adds a per-paragraph-item **view mode select** so one paragraph type can render several ways.
No settings form, no `configure` route, no permissions, no Drush, no plugin *types* (it does
ship one field type + widget + formatter, all id `paragraph_view_mode`).

- **Turn the feature on/off for a paragraph bundle, widget settings, where it is stored** →
  [configure/enable-on-bundle.md](configure/enable-on-bundle.md)
- **Services & runtime mechanism (view-mode / form-mode swap, preview rule)** →
  [api/services.md](api/services.md)
- **The field type, widget and formatter plugins it registers** →
  [plugins/field-plugins.md](plugins/field-plugins.md)

Key facts:

- Enabled == the FieldConfig `paragraph.<bundle>.paragraph_view_mode` **exists**. The config
  schema declares `paragraphs.paragraphs_type.*.third_party.paragraph_view_mode.enabled`, but
  the module never writes it — do **not** look there.
- Field name / field type / widget / formatter id are all the literal string
  `paragraph_view_mode` (constants on `StorageManagerInterface`).
- Widget settings live in `core.entity_form_display.paragraph.<bundle>.default` →
  `content.paragraph_view_mode.settings`: `view_modes`, `default_view_mode`,
  `form_mode_bind`, `apply_to_preview`.
