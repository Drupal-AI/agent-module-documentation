<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rebuild the usage table (batch update)

The `entity_usage` table is maintained incrementally as entities are saved/deleted.
After changing which types/plugins are tracked, or after a bulk content import that
bypassed the normal save hooks, rebuild it from scratch.

## UI form
- Route `entity_usage.batch_update` — `/admin/config/entity-usage/batch-update`
  (also the "Batch Update" tab under the settings page, `entity_usage.links.task.yml`).
- Form `Form\BatchUpdateForm` (form id `entity_update_batch_update_form`), single
  "Recreate all entity usage statistics" submit button.
- Permission `perform batch updates entity usage` (marked `restrict access: TRUE`).
![Batch Update form](../../../../../../../screenshots/entity_usage/5.0.x/batch-update.png)

- Submitting calls `EntityUsageBatchManager::recreate()` which deletes existing
  records and re-runs all active tracking plugins over every tracked source entity
  as a Batch API process.

## Prefer Drush for large sites
See [drush/entity_usage.md](../drush/entity_usage.md) —
`drush entity-usage:recreate`, with `--keep-existing-records` and
`--entity-types=node,media` to scope the rebuild.

The batch manager (`EntityUsageBatchManager`) is also the service other code should
call to programmatically trigger a rebuild: `recreate(bool $keep_existing = FALSE,
?array $entity_types = NULL)`.
