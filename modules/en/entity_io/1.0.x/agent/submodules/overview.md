<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO — submodules overview

The project ships four optional submodules under `modules/`. Each has its own full doc tree at
`modules/en/entity_io/modules/<submodule>/1.0.x/`.

- **entity_io_queue** — background export/import via two core queues
  (`entity_io_queue_export`, `entity_io_queue_import`) with cron workers, an admin list/execute/
  process-all UI, and an authenticated `POST /entity-io/queue/import/add-item` endpoint. Deps:
  `system`, `entity_io`. → [queue index](../../modules/entity_io_queue/1.0.x/agent/start.md)
- **entity_io_webhooks** — on entity create/update/delete (and moderation transitions) sends the
  JSON export to configured HTTP URLs (Guzzle), an email attachment (SMTP), or FTP, configured
  globally and per bundle. Deps: `system`, `entity_io`, `smtp`. `configure`:
  `entity_io_webhooks.settings`. → [webhooks index](../../modules/entity_io_webhooks/1.0.x/agent/start.md)
- **entity_io_push** — a "Deploy" tab that pushes an entity + related content as JSON to another
  Drupal site over Basic Auth, plus a receiver endpoint (`POST /entity-io/push/importer`) that
  imports pushed JSON. Deps: `basic_auth`, `entity_io`. Ships permissions. `configure`:
  `entity_io_push.settings`. → [push index](../../modules/entity_io_push/1.0.x/agent/start.md)
- **entity_io_purge** — deletes files from the export storage directory, manually (admin UI) or
  automatically on cron at a configurable frequency. Deps: `system`, `entity_io`. `configure`:
  `entity_io_purge.settings`. → [purge index](../../modules/entity_io_purge/1.0.x/agent/start.md)

All four reuse the parent module's export/import services (`entity_io.export`, `entity_io.exporter`,
`entity_io.entity_importer`) and its `ExportDirectory` helper.
