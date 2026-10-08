<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Drush/Commands/AltTextValidationCommands.php` (Drush attribute style).

| Command | Alias | Does |
|---|---|---|
| `alt-text-validation:queue-audit` | `atv-queue` | Queues every content entity for auditing (`Auditor::queueAllImages()`). Requires cron to actually process the queue — possibly several runs. |
| `alt-text-validation:fill-audit-test` | `atv-fat` | Truncates and fills the `alt_text_validation_audit` table with a handful of hard-coded demo rows (`AuditStorage::generateTestData()`). Development only; the code marks it as slated for removal in favour of a unit test. |

## Typical audit run
```
drush alt-text-validation:queue-audit
drush cron        # repeat until the queue drains
drush queue:list  # watch atv_entity_instances shrink
```
The report at `/admin/reports/alt-text-report` shows start/finish times and status once the
queue completes. No other Drush commands are provided.
