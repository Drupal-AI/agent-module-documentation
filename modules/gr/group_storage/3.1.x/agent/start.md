<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Storage (group_storage) — agent index

Bridges **Group** (3.x) and **Storage Entities** (1.2+): registers a Group **relation plugin** that
adds Storage entities to groups as group content, with access decided by the group's permissions.
Version **3.1.0**. Core `^11` — **Drupal 11 only**. Depends on `group:group` and `storage:storage`.

## What it actually is

- A **Group relation type** plugin `group_storage` (`src/Plugin/Group/Relation/GroupStorage.php`,
  attribute `#[GroupRelationType]`, `entity_type_id: 'storage'`, `entity_access: TRUE`), whose
  **deriver** `GroupStorageDeriver` emits one relation per `storage` bundle (Storage type). Entity
  cardinality is forced to **1** and the field is disabled in the config form.
- A **route subscriber** (`src/Routing/RouteSubscriber.php`) that clones Group's generic
  add/create-content routes into `group/{group}/storage/add` and `group/{group}/storage/create`,
  pinning `base_plugin_id = group_storage`. It copies each source route's access requirements — it
  does not weaken them.
- A **permission provider** decorator (`GroupStoragePermissionProvider`) that only remaps the legacy
  `view unpublished … any` permission name; everything else delegates to Group's default provider.
- One **group permission**: `access group_storage overview` (`group_storage.group.permissions.yml`).
- A **Views** overview (`config/optional/views.view.group_storages.yml`) at `group/%group/storages`,
  access plugin `group_permission` = `access group_storage overview`, scoped by a `group_id` argument
  whose `default_action` is `access denied`. Surfaced by `hook_entity_operation` as a "Storages"
  operation on each group.
- No config **schema**, no Drush commands, no services beyond the route subscriber and the handler.

## Read next

- `agent/relations/plugin.md` — the relation plugin, deriver, cardinality, routes and UI wiring.
- `agent/access/model.md` — how access is (and is not) enforced; the permission set and the overview.

## Key facts for reasoning

- Storage entities are **not files** — they are lightweight, bundleable content entities from the
  Storage Entities module for structured data not meant to be browsed directly.
- Access is the standard Group `entity_access` delegation: group permissions **grant** access to a
  group's storage. Group does **not** override access the Storage module's own site-wide permissions
  already grant (see `agent/access/model.md`).
- If **no Storage types exist**, the deriver produces **no** relations — nothing to add to groups.
