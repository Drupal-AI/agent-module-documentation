<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rebuild the usage table (batch update)

The usage table is only populated as entities are saved. After enabling the module, changing
tracked source/target types or plugins, or importing content, regenerate everything.

- UI: `/admin/config/entity-usage/batch-update` (route `entity_usage.batch_update`, form
  `BatchUpdateForm`). One submit button ("Recreate all entity usage statistics") that erases
  and recreates all tracking records via a batch. As a `FormBase`, it carries Drupal's
  automatic form CSRF token.
- Gated by the `perform batch updates entity usage` permission
  ([../permissions/entity_usage.md](../permissions/entity_usage.md), a `restrict access` perm).
- CLI equivalent (better for large sites): see [../drush/entity_usage.md](../drush/entity_usage.md)
  (`drush entity-usage:recreate`, alias `eu-r`).
- Both paths run through `EntityUsageBatchManager::recreate($keep_existing_records = FALSE,
  $entity_types = NULL)`. Passing entity type ids limits the delete+rebuild to those types
  (the Drush `--entity-types` option); passing `$keep_existing_records = TRUE` skips the
  initial delete. Internally the rebuild uses a bulk-insert staging table
  (`EntityUsageBatchManager::BULK_TABLE_NAME` = `entity_usage_bulk`) via
  `EntityUsage::enableBulkInsert()` / `bulkInsert()` for speed.

![Entity Usage batch update form](../../../../../../../screenshots/entity_usage/2.3.x/batch-update.png)
