<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Config Cardinality — agent index

Overrides a field's **cardinality per instance (per bundle)** — a limit core only supports at the
shared field-storage level. State is one third-party setting on the instance's `FieldConfig`.
No configure route, permission, or Drush command.

- **Set/read the per-instance cardinality, where it is stored, the fieldset, empty-label options** →
  [configure/cardinality.md](configure/cardinality.md)
- **How the limit is enforced at render time: widget swaps, provided widgets, form alters** →
  [api/widgets.md](api/widgets.md)

Key facts:
- Setting: `field.field.<entity>.<bundle>.<field>` →
  `third_party_settings.field_config_cardinality.cardinality_config` (string: a positive number,
  or `-1` for unlimited). The instance limit must be **≤ the storage cardinality** (unlimited
  storage allows any).
- UI: **"Allowed number of values (Cardinality Instance)"** fieldset on the field instance edit
  form (`field_config_edit_form`), saved by `field_config_cardinality_form_builder`.
- Enforcement swaps `media_library_widget`, `image_image`, `entity_reference_autocomplete` and
  ships `cardinality_email_default`, `cardinality_options_select`, `cardinality_ief_simple`.
