<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, admin forms, tracking table & queue workers

## Config object `acquia_perz_push.settings`

```yaml
cis:
  queue_bulk_max_size: 20   # entities per bulk queue item
  endpoint_timeout: 2       # CIS request timeout in seconds
```

There is **no settings form** for these keys (no configure route in this submodule); set them via
drush or config import:

```bash
drush cget acquia_perz_push.settings
drush cset acquia_perz_push.settings cis.queue_bulk_max_size 50 -y
```

## Admin forms (permission `administer acquia perz push`)

- **Export** — route `acquia_perz_push.export_form`, path
  `/admin/config/services/acquia-perz/export` (`Form\ExportForm`). Enqueues a full content scan and
  runs it via batch/cron. Appears as a task tab under the Personalization settings.
- **Delete** — route `acquia_perz_push.acquia_delete_personalization_data_form`, path
  `/admin/config/services/acquia-perz/delete` (`Form\DeletePersonalizationDataForm`).

## Tracking table `acquia_perz_push_export_tracking`

Created in `acquia_perz_push.install` (`hook_schema`). Columns: `id` (serial),
`entity_type`, `entity_id`, `entity_uuid`, `langcode`, `status`, `modified`. Unique keys on
(`entity_type`,`entity_id`,`langcode`) and (`entity_uuid`,`langcode`). Managed by `ExportTracker`;
statuses are the constants `exported`, `export_timeout`, `deleted`, `delete_timeout`, `failed`.

## Queue workers (`src/Plugin/QueueWorker/`)

- `acquia_perz_push_content_export` (`ContentExportQueueWorker`) — single-entity export.
- `acquia_perz_push_content_export_bulk` (`ContentExportBulkQueueWorker`) — bulk export chunk.

Both run on Drupal cron (or when the Drush process/export commands drive the batch).
