<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush

Defined in `Drupal\entity_usage\Commands\EntityUsageCommands` (registered via
`drush.services.yml`, service `entity_usage.commands`). A legacy `entity_usage.drush.inc`
also ships for older Drush.

| Command | Aliases | Purpose |
|---|---|---|
| `entity-usage:recreate` | `eu-r`, `entity-usage-recreate` | Erase and regenerate entity usage statistics (runs the same batch as the UI batch-update form, then `drush_backend_batch_process()`). |

Options:

- `--keep-existing-records` — recreate without first deleting existing usage records.
- `--entity-types` — comma-separated list of entity type ids to rebuild (e.g. `node,media`);
  only those types' records are deleted and rebuilt. Omit to rebuild all tracked types. (New
  in 2.3.)

```
drush entity-usage:recreate
drush eu-r --keep-existing-records
drush eu-r --entity-types=node,media
```

Preferred over the [UI batch-update form](../configure/batch-update.md) on large sites. Run it
after changing tracked source/target types, enabling/disabling plugins, or bulk-importing
content. Calls `EntityUsageBatchManager::recreate($keep_existing, $entity_types)`.
