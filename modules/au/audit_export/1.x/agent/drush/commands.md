<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Provided by `audit_export_core` (`drush.services.yml` → `Drush\Commands\AuditExportCoreCommands`,
tagged `drush.command`). Group `Audit Export`.

| Command | Aliases | Args / options | Does |
|---|---|---|---|
| `audit-export:list` | `aexl` | — | Table of every audit plugin: label, id, group, description, provider module, dependencies, last-processed date. |
| `audit-export:run` | `aexp`, `audit-export:process` | `[audit_id]`, `--all` | Run one audit (interactive chooser if omitted) or all. Clears the report, then loops `prepareData()` → `processData()` → `appendReportData()` with a progress bar → `updateReportDate()`. |
| `audit-export:export` | `aexe` | `audit_id`, `--destination=PATH` | Write a processed report to CSV. Default destination is `sys_get_temp_dir()/audit_export_{id}_{timestamp}.csv`. Requires the report to have been run first. |
| `audit-export:queue` | `aexq` | `[audit_id]`, `--all` | Enqueue an audit (or all via `audit_export_core.cron::queueAudits()`) onto the `audit_export_processor` queue for later cron processing. |
| `audit-export:env` | `aexenv` | — | Print environment info (PHP version, Drupal root/version, module version, server IP, themes, site path). |

Examples:

```bash
drush audit-export:list
drush audit-export:run enabled_modules
drush audit-export:run --all
drush audit-export:export enabled_modules --destination=/tmp/modules.csv
drush audit-export:queue --all      # then process with: drush queue:run audit_export_processor
```

Notes: `audit-export:run` and the UI "process" both feed the same `audit_export_report` table, so a
report exported/downloaded afterwards reflects the last run. `--destination` for `audit-export:export`
writes wherever the CLI user points it (a raw filesystem path, not a Drupal stream wrapper).
