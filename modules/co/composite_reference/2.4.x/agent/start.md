<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Composite Reference — agent index

Mark an `entity_reference` / `entity_reference_revisions` field as **composite** so its referenced
entities are deleted when the host entity is deleted (unless still referenced elsewhere). No admin
page (`configure` null), no permissions, no Drush. Ships a config schema for the third-party
settings. Works with configurable (bundle) fields and base fields.

- **Turn on composite for a field — UI checkbox, base-field code setting, the third-party settings
  keys, and the "include past revisions" option** → [configure/mark-composite.md](configure/mark-composite.md)
- **Deletion behavior & the field-manager service (`getReferencingEntities`, `entityDelete`)** →
  [api/field-manager.md](api/field-manager.md)

Key facts:
- Settings are third-party settings on the field: `composite_reference.composite` (bool) and
  `composite_reference.composite_revisions` (bool). `composite_revisions` is forced FALSE unless
  `composite` is TRUE, and only meaningful for `entity_reference_revisions`.
- `hook_entity_predelete()` → `CompositeReferenceFieldManager::entityDelete()` deletes each referenced
  entity that no other entity references (checked across all reference fields + all revisions,
  `accessCheck(FALSE)`).
