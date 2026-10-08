<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Field Copy — agent index

A Display Suite (DS) add-on that lets a field be rendered more than once on an entity
display, each copy with its own formatter. No settings page, no permissions, no Drush.
Each copy is a DS dynamic field stored in a **simple config object** `ds.field.<id>`
(`type: display_field_copy`, `properties.field_id: <entity_type>[.<bundle>].<field>`).
Requires `ds`.

- **Create/read a field copy, the `ds.field.*` config shape, and how to place it** →
  [configure/field-copy.md](configure/field-copy.md)
- **The DS field plugin `display_field_copy`, its deriver, and the render mechanism** →
  [plugins/ds-field.md](plugins/ds-field.md)

Key facts:
- Admin flow: *Structure → Display Suite → Fields* (`/admin/structure/ds/fields`) →
  "Create a copy of a field" (route `display_field_copy.add`, permission `admin fields`).
- The copy appears in the entity's *Manage display*; assign it any formatter for the
  source field's type.
- No config schema of its own; the `ds.field.<id>` object follows Display Suite's shape.
