<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom add another — agent index

Replaces the **"Add another item"** and **"Remove"** button labels on **unlimited-cardinality**
fields with custom text. No configure route (`configure: null`), no settings page, no permissions,
no Drush, no plugins. Depends on core `field`. Its only persistent state is **two third-party
settings on a `FieldConfig`** entity.

- **Set / read the custom button labels, where they're stored, and the conditions** →
  [configure/buttons.md](configure/buttons.md)

Key facts:
- Options appear on the field-instance edit form **only when cardinality = Unlimited** and the
  field storage is not locked.
- Stored on `field.field.<entity_type>.<bundle>.<field_name>` →
  `third_party_settings.custom_add_another.custom_add_another` (add-another label) and
  `.custom_remove` (remove label).
- Empty value → the third-party setting is unset and the core default label is used.
- Also relabels the upload/remove buttons on multiple `managed_file` (file/image) widgets.
