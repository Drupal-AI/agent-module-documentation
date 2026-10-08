<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revision Delete Tools trims entity revision history in bulk: a Drush command queues revisions for deletion — for every revisionable entity type, one type, one bundle or a single entity — and a cron queue worker deletes them in chunks, always keeping a configurable number of the most recent.

---

Revision tables are the usual reason a mature Drupal database is far bigger than its content warrants, and deleting revisions one node at a time is not practical. This module makes it a queued, batched operation. `rdt:remove-revisions` takes optional `entityType`, `bundle` and `entityId` arguments plus a `--keep` option (default **3**, from `RemoveRevisions::REVISIONS_TO_KEEP`), validates that the entity type is actually revisionable, and pushes work onto a queue rather than deleting inline — so a huge backlog cannot time out a CLI run. `RemoveRevisionsService` provides the corresponding API: `queueRevisionsByType()`, `queueRevisionsByBundle()`, `queueRevisionsByEntityId()`, plus helpers `getEntityIds()`, `getBundleNames()` and `getRevisionableEntityTypes()`. The `RemoveRevisions` queue worker (`cron = {"time" = 60}`) drains the queue on cron, processing revisions in chunks of 500 (`REVISION_CHUNK_SIZE`). The command refuses `--keep` below 1, since at minimum the default revision must survive. There is no UI, no permissions and no configuration — it is a CLI/cron maintenance tool, and the operation is irreversible.

---

- Shrink a database bloated by years of node revisions.
- Keep only the last three revisions of every node.
- Trim revisions for one content type without touching others.
- Clean up revisions for a single problem entity.
- Keep more revisions for editorial content than for imported content.
- Queue a large cleanup and let cron work through it.
- Avoid CLI timeouts on a huge revision backlog.
- Reduce backup size and restore time.
- Speed up entity queries that join revision tables.
- Clean up after a migration that created a revision per row.
- Apply a retention policy to media revisions.
- Process deletions in chunks to limit memory use.
- Run cleanup as part of a scheduled maintenance job.
- Discover which entity types on a site are revisionable.
- List bundles for an entity type before targeting one.
- Trim revisions created by automated content updates.
- Keep the default revision safe by construction.
- Script retention across several entity types.
- Reduce storage costs on a large site.
- Prepare a database for cloning to a development environment.
