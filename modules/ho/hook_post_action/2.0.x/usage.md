<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hook Post Action introduces eight new Drupal hooks (`hook_entity_post{save,insert,update,delete}` and `hook_node_post{save,insert,update,delete}`, plus the generic `hook_ENTITY_TYPE_post*` form) that fire *after* an entity write has actually been committed, letting modules react to a completed save/insert/update/delete rather than during it.

---

Core's `hook_entity_insert/update/delete` run inside the save flow, before the request finishes and (for some storage) before everything is fully persisted, so acting on a "definitely saved" entity is awkward. This module fills that gap. It implements core `hook_entity_insert/update/delete` and, for each, registers a shutdown function (`drupal_register_shutdown_function('_hook_post_action_post_save', $entity, $op)`). At shutdown the callback confirms the write really happened — for delete it re-loads the entity and only proceeds if it is gone (treating a missing entity type as "done") — then dispatches four `moduleHandler()->invokeAll()` calls: `hook_ENTITY_TYPE_post{op}`, `hook_ENTITY_TYPE_postsave`, `hook_entity_post{op}`, and `hook_entity_postsave`. So every write triggers both an operation-specific hook and a generic `postsave` hook, and both an entity-type-specific variant (e.g. `hook_node_postinsert`) and an entity-generic variant (e.g. `hook_entity_postinsert`). The `*save` hooks receive `($entity, $op)` where `$op` is `insert`/`update`/`delete`; the operation-specific hooks receive just `($entity)`. The module itself has no configuration, permissions, services, or Drush; it ships a submodule `hook_post_action_example` that logs on each event as a working reference. You consume it by implementing the new hooks in your own module (see `hook_post_action.api.php`).

---

- Send a notification or webhook only *after* a node has been fully saved to the database.
- Sync an entity to an external system (CRM, search index, cache) once its insert is committed.
- Run post-processing that must not interfere with the in-flight save transaction.
- React to a node deletion after it is confirmed gone (not merely scheduled) via `hook_node_postdelete`.
- Distinguish insert vs update vs delete in one handler using `hook_entity_postsave($entity, $op)`.
- Implement `hook_ENTITY_TYPE_postinsert` (e.g. `hook_commerce_order_postinsert`) for type-specific side effects.
- Enqueue a background job after an entity write completes.
- Invalidate a decoupled/front-end cache once the entity is definitely persisted.
- Recalculate aggregate/rollup data after a related entity is saved.
- Trigger analytics events keyed to a completed content change.
- Post to Slack/email when specific content types are created or updated.
- Update a materialized view or report table after an entity save is finalized.
- Avoid the "entity not fully saved yet" pitfalls of acting inside core `hook_entity_insert`.
- Fire integration logic only for successful deletes, using the module's re-load safety check.
- Handle both a generic (`hook_entity_postupdate`) and node-specific (`hook_node_postupdate`) reaction.
- Log an audit trail entry after each committed entity operation (as `hook_post_action_example` does).
- Push content to a static-site build/revalidation endpoint after save.
- Kick off translation or media-derivative generation once an entity exists.
- Keep external ID mappings in sync on insert and remove them on delete.
- Provide a single place for "after write" business rules across many entity types.
- Use the bundled `hook_post_action_example` submodule as a copy-paste starting point.
