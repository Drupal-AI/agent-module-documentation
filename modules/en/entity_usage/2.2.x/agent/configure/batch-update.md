# Rebuild the usage table (batch update)

The usage table is only populated as entities are saved. After enabling the module, changing
tracked source/target types or plugins, or importing content, regenerate everything.

- UI: `/admin/config/entity-usage/batch-update` (route `entity_usage.batch_update`, form
  `BatchUpdateForm`). Erases and recreates all tracking records via a batch.
- Gated by the `perform batch updates entity usage` permission
  ([../permissions/entity_usage.md](../permissions/entity_usage.md)).
- CLI equivalent (better for large sites): see [../drush/entity_usage.md](../drush/entity_usage.md)
  (`drush entity-usage:recreate`).
- Both paths run through `EntityUsageBatchManager::recreate()`, which optionally keeps existing
  records.
