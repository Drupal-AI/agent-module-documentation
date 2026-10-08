<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Provided by `src/Drush/Commands/AssetImportDrushCommands.php`. They act on the configured
`categories` / `asset_groups` (see [../configure/bulk-import.md](../configure/bulk-import.md))
and talk to the DAM, so they need a live authenticated connection to import real assets.

| Command | Aliases | Options | Purpose |
|---|---|---|---|
| `acquia-dam:queue-import-assets` | `ad:qia`, `ad-qia` | — | Enumerate all assets matching the saved configuration and enqueue them into the `acquia_dam_asset_import` queue. |
| `acquia-dam:process-import-queue` | `ad:piq`, `ad-piq` | `--batch-size` (default 10), `--limit` (default 0 = unlimited) | Process queued items, creating a media entity per asset. |
| `acquia-dam:import-assets` | `ad:ia`, `ad-ia` | `--batch-size`, `--limit` | Queue **and** process in one command (the recommended one-shot import). |

```bash
# recommended: queue + import everything, default batch size 10
drush acquia-dam:import-assets

# faster batches
drush acquia-dam:process-import-queue --batch-size=50

# smaller batches to reduce memory
drush acquia-dam:process-import-queue --batch-size=5

# only the first 100 queued items
drush acquia-dam:process-import-queue --limit=100

# two-phase
drush acquia-dam:queue-import-assets
drush acquia-dam:process-import-queue --limit=50 --batch-size=10
```

`--batch-size` = items processed per batch; `--limit` = max items to process (`0` =
unlimited). The queue is the core `acquia_dam_asset_import` queue, so you can also drain it
with `drush queue:run acquia_dam_asset_import`. Check progress via `drush queue:list`.
Post-import diagnostics: `drush watchdog:show --type=acquia_dam`.
