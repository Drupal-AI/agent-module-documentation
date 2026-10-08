<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fileslog — configure

Fileslog has **one setting**: `max_items`, the number of log files to keep before cron prunes the
oldest.

## Where
It is added to core's logging-settings form (`configure` route `system.logging_settings`,
`/admin/config/development/logging`) by `Hook\FormAlter::alterSystemLoggingSettingsForm()`, as a
required number field "Maximum logs" (`#min => 1`). Saving stores it to `fileslog.settings:max_items`.

## Config object
- `fileslog.settings` → `max_items` (integer). Ships as **1000** (`config/install/fileslog.settings.yml`).
- Schema: `config/schema/fileslog.schema.yml` (`config_object`, one integer mapping).

Read/write from code or drush:

```
drush config:get fileslog.settings max_items
drush config:set fileslog.settings max_items 5000
```

## How it is enforced
`Hook\Cron::cron()` reads `max_items` (falling back to 1000 when unset or `< 1`), lists every log
file newest-first via `FilesLogManager::getLogFiles([], 0)`, and `unlink()`s everything past the
limit. Pruning happens **on cron only**, not on write, so the on-disk count can exceed `max_items`
between runs.

## Install-time requirements (`fileslog_requirements`)
Both are `REQUIREMENT_ERROR`:
- `dblog` must **not** be enabled (the two are incompatible).
- `file_private_path` (the private filesystem) must be configured.

There are **no** module-specific permissions; the report routes reuse core's `access site reports`.
On uninstall, `hook_uninstall()` deletes `private://logs` (warns if it cannot).
