<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Meta Entity (meta_entity) — agent index

Stores metadata *about* an entity in a separate content entity (`meta_entity`) instead of as a
field on the host, so operational/editorial data (view counts, ratings, sync state, notes) can be
attached to any entity — including entity types you don't control — without re-saving the host.
Each `meta_entity` points at exactly one host through a **`dynamic_entity_reference`** `target`
field. Meta entity *types* are bundle config entities (`meta_entity_type`) that declare which host
entity-type/bundles they may attach to.

- Depends on `dynamic_entity_reference` (`^2 || ^3 || ^4`); core `^10 || ^11`.
- No module settings form. Admin surface: type list at `/admin/structure/meta-entity`
  (route `meta_entity.type.admin`), meta entity content list at `/admin/content/meta-entity`.
- Defines per-type permissions at runtime (permission callback), no drush, no plugin types it
  exposes to others (ships two internal validation constraints).

Solution docs:
- **Define a metadata type + bind it to host bundles (mapping, reverse field, auto-create)** → [configure/meta-entity-type.md](configure/meta-entity-type.md)
- **Create/load a meta entity, read it back from the host, use the repository service** → [api/repository.md](api/repository.md)
- **Grant who can create/view/update/delete each metadata type** → [permissions/permissions.md](permissions/permissions.md)
- **Lifecycle behaviors it triggers on host save/delete (auto-create, cascade delete, label, cache)** → [hooks/behaviors.md](hooks/behaviors.md)
- **The `meta_entity` base fields and the computed reverse-reference field** → [fields/fields.md](fields/fields.md)

Key facts:
- Content entity: `meta_entity` (base table `meta_entity`, data table `meta_entity_field_data`, translatable). Bundle/config entity: `meta_entity_type` (config prefix `meta_entity.type.*`).
- Base fields: `label`, `target` (dynamic_entity_reference, required, cardinality 1), `created`, `changed`.
- Config keys per type: `id`, `label`, `description`, `mapping[<entity_type>][<bundle>] = {field_name, auto_create}`.
- Service: `meta_entity.repository` (one per meta entity type, tagged `meta_entity.repository`). Container param `meta_entity.repositories` maps meta-type-id → service-id.
- Static permission: `administer meta entity` (`restrict access: true`). Runtime per-type permissions: `create|view|update|delete <type_id> meta-entity` (from `MetaEntityPermissionProvider::getPermissions`).
- API: `MetaEntity::loadOrCreate($bundle, $target)`, `MetaEntity::getTargetEntity()`; repository `getMetaEntityForEntity()`, `getMetaEntitiesForEntity()`, `getReverseReferenceFieldNames()`, `getTypesWithAutoCreation()`.
- Validation constraints on `target`: `UniquePerMetaTypeAndTarget` (one meta of a type per host), `MappedTargetEntity` (host must be in the type's mapping).
