# Drush

Defined in `EntityUsageCommands` (registered via `drush.services.yml`).

| Command | Aliases | Purpose |
|---|---|---|
| `entity-usage:recreate` | `eu-r`, `entity-usage-recreate` | Erase and regenerate all entity usage statistics (runs the same batch as the UP batch-update form). |

Options:

- `--keep-existing-records` — recreate without first deleting existing usage records.

```
drush entity-usage:recreate
drush eu-r --keep-existing-records
```

Preferred over the [UI batch-update form](../configure/batch-update.md) on large sites. Run it after
changing tracked source/target types, enabling/disabling plugins, or bulk-importing content.
