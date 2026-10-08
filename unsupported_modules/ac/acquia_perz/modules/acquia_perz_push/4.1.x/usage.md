<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Personalization (Perz) Push is the export engine for acquia_perz: it renders opted-in entity view modes and pushes them to Acquia's Content Index Engine (CIS), tracking what has been exported and offering Drush commands and admin forms to (re)export or purge content.

---

Enabling this submodule switches acquia_perz from its lightweight "decision webhook" to real content export. It implements entity insert/update/delete hooks that, for eligible published entities, call `ExportContent::exportEntity()` / `deleteEntity()` — building an entity variation payload per configured view mode and sending it to CIS through `acquia_perz.client_factory`. A queue (`ExportQueue`) plus two queue workers (`acquia_perz_push_content_export`, `acquia_perz_push_content_export_bulk`) handle bulk (re)scans and background export; `queue_bulk_max_size` (default 20) and `endpoint_timeout` (default 2s) are tunable in config object `acquia_perz_push.settings`. Every export is recorded in the `acquia_perz_push_export_tracking` database table (`ExportTracker`, statuses: exported / export_timeout / deleted / delete_timeout / failed), keyed by entity type/id/uuid/langcode. Two admin forms are added under the Personalization menu: an **Export** form (`admin/config/services/acquia-perz/export`) that enqueues/runs a full content scan via cron/batch, and a **Delete** form (`admin/config/services/acquia-perz/delete`) — both gated by the `administer acquia perz push` permission. A `QueueCommands` Drush class exposes enqueue/process/purge/count and site- or all-sites content deletion. It has no configure route of its own (the parent module's settings form covers global config).

---

- Turn on real content export from Drupal to Acquia Personalization (CIS).
- Automatically export a node/term/block when it is published, and delete it from the service when unpublished or deleted.
- Bulk (re)scan and enqueue all personalization-eligible content with `drush acquia:perz-enqueue-content`.
- Process the export queue and push queued content with `drush acquia:perz-process-queue`.
- Check how many items are waiting in the export queue with `drush acquia:perz-queue-items`.
- Purge the local export queue without sending anything with `drush acquia:perz-purge-queue`.
- Delete this site's content from the Personalization service with `drush acquia:perz-purge-current`.
- Delete all sites' content from the Personalization service with `drush acquia:perz-purge-all`.
- Re-export content in bulk from the admin Export form after changing view-mode opt-ins.
- Tune the bulk queue chunk size (`queue_bulk_max_size`) for large content sets.
- Tune the CIS endpoint timeout (`endpoint_timeout`) for slow networks.
- Track which entities/translations have been exported via the `acquia_perz_push_export_tracking` table.
- Export multiple view-mode variations of the same entity as separate CIS variations.
- Handle translated entities, exporting per-language variations.
- Export custom block content (block_content) and paragraphs-based content to Personalization.
- Remove an entity from the service automatically when it stops being eligible (e.g. an "only export" boolean turns off).
- Run background export through Drupal cron using the registered queue workers.
- Recover from partial exports by re-running the queue (tracking records timeouts/failures).
- Give editors an admin Delete form to clear a site's personalization content safely.
- Satisfy acquia_perz's status-report requirement (which errors when this Push module is not installed).
- Script scheduled re-exports in CI/deploy pipelines using the Drush commands.
