# Drush commands

Registered in `drush.services.yml` → `Drupal\digital_asset_inventory\Drush\Commands\DaiCommands`.

## `dai:scan` (alias `dai-scan`)
Runs a full site scan for digital assets (or resumes from a checkpoint).
- Option `--force` — clear stuck/stale scan locks and start fresh (ignores an existing recent scan
  and any checkpoint).
- Requires DB updates applied first (guards on the `digital_asset_item.display_title` column; run
  `drush updb` if it errors with "Database updates are pending").
- Acquires a persistent scan lock; if held, it either breaks a stale lock (past
  `scan_lock_stale_threshold_seconds`, or with `--force`) or exits "already in progress".
- Suspends cron during the run, then processes the scan as a batch
  (`ScanAssetsForm::buildBatch` + `drush_backend_batch_process()`); resumes from checkpoint phase
  when one exists and `--force` is not passed.
- Writes dblog audit entries with a session id; exit codes: success / locked / error.
```bash
drush dai:scan            # full scan or resume
drush dai:scan --force    # clear a stuck lock and start fresh
```

## `dai:status` (alias `dai-status`)
Shows inventory status and last-scan results.
- Option `--format=table|json|yaml` (default `table`).
- Reads state `digital_asset_inventory.last_scan` / `.scan_duration` and site name; reports "no
  scan yet" if never run.
```bash
drush dai:status
drush dai:status --format=json   # for scripted monitoring
```
