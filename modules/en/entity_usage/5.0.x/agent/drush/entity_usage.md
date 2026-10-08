<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush

One command, defined as a Symfony console `Command` in
`src/Drush/Commands/RecreateEntityUsageCommand.php` (uses `AutowireTrait`; requires
Drush `^13.7 || ^14.0` per `composer.json`).

## `entity-usage:recreate`
Aliases: `eu-r`, `entity-usage-recreate`.

Deletes existing usage records and re-generates them by running all active tracking
plugins over every tracked source entity (delegates to
`EntityUsageBatchManager::recreate()` and runs it as a Drush backend batch). This is
the CLI equivalent of the [batch-update form](../configure/batch-update.md).

Options:
- `--keep-existing-records` — do **not** delete existing records before rebuilding
  (add to what is already tracked instead of a clean rebuild).
- `--entity-types=node,media` — comma-separated entity type IDs to scope the rebuild;
  only these types' records are deleted and rebuilt. Omit to process all tracked types.

```bash
drush entity-usage:recreate
drush eu-r --entity-types=node,media
drush entity-usage:recreate --keep-existing-records
```

Run this after importing content, or after changing tracked types/plugins on the
[settings page](../configure/settings.md).
