<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO Queue (entity_io_queue) — agent index

Submodule of **Entity IO**. Background export/import via two core queues. Depends on `system` and
`entity_io`. Core `^9 || ^10 || ^11`. No permissions.yml, no config, no new plugin type.

## Mechanism (from source)

- **Queues** (`entity_io_queue.module` `hook_cron_queue_info`): `entity_io_queue_export` and
  `entity_io_queue_import`, each with a matching QueueWorker plugin and 60s cron time.
- **QueueWorkers** (`src/Plugin/QueueWorker/`): `EntityIoExportQueueWorker` (id
  `entity_io_queue_export`) loads the entity and calls the Entity IO exporter;
  `EntityIoQueueImportWorker` (id `entity_io_queue_import`) feeds the payload to
  `entity_io.entity_importer`.
- **`EntityIoQueueService`** (`src/Service/EntityIoQueueService.php`, service
  `entity_io_queue.*`): `addToExportQueue(EntityInterface, array $options)` creates an export item
  `{entity_type, entity_id, depth, max_depth(=3), selected_fields, langcode, is_revision}`.
- **`EntityIoQueueController`** (`src/Controller/EntityIoQueueController.php`): admin list/execute/
  process-all actions; queue rows are read with `unserialize(..., ['allowed_classes' => FALSE])`.
  `addItem(Request)` decodes the POST JSON and enqueues `data['data']` onto
  `entity_io_queue_import`.

## Routes (`entity_io_queue.routing.yml`)

| Route | Path | Permission / auth |
|---|---|---|
| `entity_io_queue.items` | `/admin/config/entity-io/queue/import/items` | `administer site configuration` |
| `entity_io_queue.items_export` | `/admin/config/entity-io/queue/export/items` | `administer site configuration` |
| `entity_io_queue.execute_item` | `/admin/config/entity-io/queue/execute/{item_id}` | `administer site configuration` |
| `entity_io_queue.execute_import_item` | `/admin/config/entity-io/queue/execute-import/{item_id}` | `administer site configuration` |
| `entity_io_queue.process_all_export` | `/admin/config/entity-io/queue/export/process-all` | `administer site configuration` |
| `entity_io_queue.process_all_import` | `/admin/config/entity-io/queue/import/process-all` | `administer site configuration` |
| `entity_io_queue.add_item` | `POST /entity-io/queue/import/add-item` | `access content` + `_user_is_logged_in` + `_auth: [basic_auth]` |

Processing an import item ultimately runs `EntityImporter::import()` (see the parent module's
[import doc](../../../../1.0.x/agent/api/import.md)).
