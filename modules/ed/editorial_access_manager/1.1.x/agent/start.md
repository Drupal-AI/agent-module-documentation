<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editorial access manager (editorial_access_manager) — agent index

Assigns specific users the right to **edit or translate a specific content entity, per language**.
Editors need no core create/edit/translate permission — only an `edit assigned …` permission plus a
per-entity assignment. Works for any bundled content entity type (node, taxonomy term, media, comment,
contrib) once enabled. Nodes are enforced through the **node access grants** system; other types through
`hook_entity_access`.

- Dependencies: core `node`, `content_translation`. `core_version_requirement: ^8 || ^9 || ^10 || ^11`.
- Configure route: `editorial_access_manager.settings` → `/admin/config/content/editorial-access-manager`.
- Provides permissions (static + dynamic per entity type). No Drush commands. No plugin *types* defined
  (ships one EntityReferenceSelection plugin). Config schema provided.

## Solutions

- **Enable entity types / bundles and assign editors** → [configure/settings.md](configure/settings.md)
- **Permissions: who can assign vs who can edit assigned content** → [permissions/permissions.md](permissions/permissions.md)
- **Manager service, access mechanism (node grants + entity_access + translation), storage tables, routes, plugin** → [api/service.md](api/service.md)

## Key facts

- Service: `editorial_access_manager.manager` (`Drupal\editorial_access_manager\EditorialAccessManager`).
- Config: `editorial_access_manager.settings`, key `entity_types` (`entity_type_id => bool`).
- Per-bundle third-party settings (namespace `editorial_access_manager`): `enabled` (bool),
  `entity_references_enabled` (list of entity type ids).
- Node grant realm: `editorial_access_manager_assignees` (gid = assignee uid; `grant_view`+`grant_update`).
- Tables: `editorial_access` (entity_type, entity_id, langcode, uid, date),
  `editorial_access_references` (entity_type, entity_id, parent_entity_type, parent_entity_id, uid).
- Assignment route: `/editorial-access-manager/editorial-assignment/{entity_type_id}/{entity_id}/{langcode}`
  (langcode in the path → a translation is assigned independently of its source).
- Reassign UI: `/admin/content/reassign` (permission `reassign assigned entities`).
- Assigned-content page: `/admin/content/assigned`.
- Static permissions: `assign entity edition`, `assign entity translation`, `edit assigned entity`,
  `reassign assigned entities`; dynamic per type: `assign <type> edition`, `assign <type> translation`,
  `edit assigned <type>`.
- EntityReferenceSelection plugin id: `editorial_access_manager_assignable_user`.
