<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storage Entities — agent index

A bundleable content entity type **`storage`** with config-entity bundles **`storage_type`**,
for fielded data that has no front-end URL by default. Like content types, but not routable.
No single settings page (`configure` null); config lives in each `storage_type`.

- **Create/configure storage types, every storage_type property, name pattern, drush recipes** →
  [configure/storage-types.md](configure/storage-types.md)
- **The `storage` entity: base fields, creating entities, the string-representation hook, tokens, Views** →
  [api/entity.md](api/entity.md)
- **The per-bundle permission scheme** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entity type `storage` (base table `storage`/`storage_field_data`), bundle entity
  `storage_type` (config prefix `storage.storage_type.*`).
- Admin: storage types at `/admin/structure/storage_types`; data at `/admin/content/storage`;
  add at `/storage/add`.
- `storage_type` config keys: `label, description, help, new_revision, revision_expose,
  revision_log, name_pattern, status, has_canonical`.
- No canonical URL unless the type's `has_canonical` is TRUE.
- Submodule: **rh_storage** (Rabbit Hole for storage entities) — nested docs under
  `modules/rh_storage/`.
