<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Delete Tools (revision_delete_tools) — agent index

Queued, chunked bulk deletion of entity revisions. A Drush command *queues* work per
entity type / bundle / entity; a cron queue worker does the actual deleting, always
keeping the N most recent revisions (default 3). Memory-safe alternative to loading every
revision id at once.

- Core requirement: `^10.3 || ^11`. No module dependencies, no composer requirements.
- `configure` route: **none** — no settings form, no config object, no UI.
- Defines: 1 Drush command, 1 service, 1 QueueWorker plugin. No permissions, no config schema, no hooks, no routes.
- Installed release documented: **1.0.0-beta3** (no stable release exists on the 1.0.x branch yet).

## Solution docs

- **Bulk-delete/queue revisions from the CLI** → [drush/commands.md](drush/commands.md)
- **Queue or query revisions programmatically; how deletion actually runs on cron** → [api/services.md](api/services.md)

## Key facts

- Drush command: `rdt:remove-revisions` (no alias) — `Drupal\revision_delete_tools\Drush\Commands\RemoveRevisionsCommands::queueRemoveRevisions()`. Args `entityType` `bundle` `entityId` (all optional), option `--keep` (default 3).
- Service id: `revision_delete_tools.remove_revisions_service` → `Drupal\revision_delete_tools\Services\RemoveRevisionsService` (autowired). Methods: `queueRevisionsByType()`, `queueRevisionsByBundle()`, `queueRevisionsByEntityId()`, `getEntityIds()`, `getBundleNames()`, `getRevisionableEntityTypes()`.
- Queue worker plugin id: `remove_revisions` → `Drupal\revision_delete_tools\Plugin\QueueWorker\RemoveRevisions`, annotation `cron = {"time" = 60}` (runs on cron).
- Constants: `RemoveRevisions::REVISIONS_TO_KEEP = 3` (public default keep), `RemoveRevisions::REVISION_CHUNK_SIZE = 500` (private, deletion batch size).
- The command only enqueues; nothing is deleted until cron runs (or `drush queue:run remove_revisions`).
