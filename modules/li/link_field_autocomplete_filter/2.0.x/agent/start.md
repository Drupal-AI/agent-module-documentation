<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Field Autocomplete Filter — agent index

Restricts which **content types** a Link field's internal-link autocomplete suggests, per field
instance, and validates the saved value. No configure route, no permission, no plugin — the
state is per-field third-party settings on the `FieldConfig` entity.

- **The per-field settings, where they are stored, include vs exclude, drush read/write** →
  [configure/filter.md](configure/filter.md)
- **How the widget/autocomplete is actually filtered and validated (target_bundles)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Settings live on `field.field.<entity>.<bundle>.<field>` →
  `third_party_settings.link_field_autocomplete_filter`, keys `negate` (bool) and
  `allowed_content_types` (list of node-type ids).
- The **"Autocomplete Filter"** fieldset appears on a **Link** field's instance edit form
  (`field_config_edit_form`) only.
- Empty selection ⇒ all content types allowed (core default).
