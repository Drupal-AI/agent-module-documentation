<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure field inheritance

## Setup
1. Create a field that marks an entity's parent — typically an `entity_reference` field, e.g. `field_entity_inherit_parent`, on the bundles that should inherit.
2. Go to `/admin/config/entity_inherit` (`EntityInheritAdminForm`, permission `access administration pages`) and register that field name as a parent field. Stored in `entity_inherit.general.settings` (`fields: []`).
3. Ensure parent and child share the **same field name** for any field to inherit.

## Behaviour (on every save, via `hook_entity_presave`)
- **Parent changes:** if a parent field changes and a child previously held the parent's old value, the child is updated to the new value.
- **New parent link:** if an entity gains a parent reference, its *empty* fields that exist on the parent are filled from the parent.
- Large propagation sets are processed through `EntityInheritQueue` (batch or no-batch processor).
- Values are recomputed on save, so the module can be uninstalled without data loss.

## Extending
Implement an `EntityInheritPlugin` (annotation `@EntityInheritPluginAnnotation`). Bundled examples:
`EntityInheritAlterFieldsLegacyFormat`, `EntityInheritProcessQueue`, `EntityInheritRemoveSystemFields`.

## Cautions
- **No loop protection across saves:** avoid circular parent graphs (A→B→A) — the module only guards a single save.
