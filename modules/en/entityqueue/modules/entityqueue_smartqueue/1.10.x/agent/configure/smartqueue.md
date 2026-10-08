# Configure a smart queue

Enable `entityqueue_smartqueue`, then create/edit a queue at `/admin/structure/entityqueue` and
choose the **Smart queue** handler (`smartqueue`, defined in
`src/Plugin/EntityQueueHandler/SmartQueue.php`).

Handler settings (schema
`entityqueue.entity_queue.plugin.entityqueue_smartqueue`):

| Key | Type | Meaning |
|---|---|---|
| `entity_type` | string | The entity type whose instances each get an automated subqueue. |
| `bundles` | sequence<string> | Optional bundle restriction (empty = all bundles). |

Behavior:
- On queue save, `onQueuePostSave()` batch-creates a subqueue per existing target entity
  (subqueue id `<queue_id>__<entity_id>`).
- `hook_entity_insert` / `hook_entity_update` / `hook_entity_delete` keep subqueues in sync as
  target entities are added/removed.
- `hook_entity_field_storage_info` / `hook_entity_bundle_field_info` add a base field linking
  each target entity to its subqueue.
- Views: use the `EntityQueueSmartQueueArgument` contextual argument to load the subqueue for
  the current entity (e.g. show the current term's queued items).

Items in each subqueue are still ordered/edited the normal Entityqueue way — see the main
module's `api/subqueues.md`.
