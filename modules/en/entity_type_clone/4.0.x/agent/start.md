<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Type Clone — agent index

Two admin forms that duplicate a **bundle** (with fields + displays) or a **user role**
(with permissions). No config entities, no schema, no services, no Drush, no plugin types.
`configure` route: `entity_type_clone.type` → `/admin/config/entity-type-clone`.

- **The two forms, routes, which entity types are clonable, what a clone copies** →
  [configure/clone-a-bundle.md](configure/clone-a-bundle.md)
- **The single permission and the operation links it gates** →
  [permissions/access.md](permissions/access.md)
- **The batch callbacks — call them / replicate them from code** →
  [api/clone-programmatically.md](api/clone-programmatically.md)

Key facts:
- Permission: **`access entity type clone`** (gates both routes and the "Clone *X*" operation).
- Routes: `entity_type_clone.type` (`/admin/config/entity-type-clone`),
  `entity_type_clone.role` (`/admin/config/role-clone`).
- Always clonable: `block_content`, `node`, `taxonomy_term`. Also `paragraph`, `profile`,
  `storage` when those modules are enabled.
- A clone copies: the bundle entity, every bundle-level `FieldConfig`, every **enabled** form-mode
  and view-mode display, third-party view-display settings, and extra-field visibility.
- It does **not** copy content, and taxonomy clones are created fresh (not duplicated), so
  vocabulary-level settings are not carried over.
