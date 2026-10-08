<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Collector

Provides an "entity collection" content entity plus front-end actions so users can gather entities into named collections (think curated lists / bookmarks) and switch an active collection.

- Defines the `entity_collection` entity type with full permission set.
- Adds AJAX and no-JS endpoints to add/remove items and set the active collection.
- Provides a refreshable collection block.
- Supports participants who can be removed from a collection.

---

# Installing & configuring

- Enable the module and its `entity_collector` submodule (`drush en entity_collector`).
- Grant the collection permissions (view/add/edit/delete published/unpublished, revisions).
- Administer collections via the admin overview permission.
- Place the entity collection block where users manage their active list.
- Config schema for the entity type is provided under `config/`.

---

# Usage & behaviour

- Item add/remove routes: `/nojs|/ajax/entity-collector/add|remove/{collectionId}/{entityId}`.
- Those routes use `_custom_access: EntityCollectionActionController::checkUpdateAccess`.
- `checkUpdateAccess` calls `$entityCollection->access('update', $account)`.
- The active-collection get/set routes use `checkViewAccess` → `access('view')`.
- `get-collections` requires `view published entity collection entities`.
- The block refresh route requires `edit entity collection entities`.
- `removeCurrentUserFromCollection` lets a participant remove themselves.
- All action controllers acquire a lock keyed by collection ID to avoid races.
- Add/remove return an AjaxResponse for XHR or a redirect to the referer otherwise.
- Collection-level access is enforced before any mutation.
- Permissions include revision view/revert/delete grants.
- `administer entity collection entities` is marked restricted.
- The entity type supports published/unpublished states.
- No unauthenticated mutation endpoint bypasses `access()` checks.
- Uninstalling removes collection entities and their config.
- Templates and JS are provided for the collection UI.
