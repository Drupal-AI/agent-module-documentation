<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & report

## Report

- View at **`/admin/reports/events-track`** (config `views.view.event_log_track`, page display
  `page_1`). Columns: LID, Type, Operation, Ref Char/Numeric, Description, User, IP, Created;
  Type/Operation are exposed filters populated from the enabled handlers.
- Gated by the **`access event log track`** permission (`event_log_track.permissions.yml`).

## Settings form

Route `event_log_track.settings_form` → **`/admin/config/system/events-log-track`**
(`EventsTrackForm`, permission `administer site configuration`). Config object
**`event_log_track.settings`**:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable_log_deletion` | bool | `false` | Turn on cron-based pruning of old rows. |
| `timespan_limit` | int (min 1) | `30` | Max age in days to keep logs (used when deletion is on). |
| `batch_size` | int (min 1) | `50` | Batch size for the deletion cron job. |
| `disable_db_logs` | bool | `false` | Do not write to the DB table (best with syslog/stdout submodule). |
| `log_cli` | bool | `false` | Log events triggered from the CLI/Drush. **When false, `insert()` drops CLI events.** |
| `skip_patterns` | string | `''` | One glob pattern per line; a log whose `ref_char` matches any is skipped. `*` is the wildcard (e.g. `system.*`). |

Set via drush:

```bash
drush config:set event_log_track.settings enable_log_deletion true -y
drush config:set event_log_track.settings timespan_limit 7 -y
drush config:set event_log_track.settings skip_patterns 'system.*' -y
```

## Automatic deletion (cron)

`EventLogTrackHooks::cron()` runs when `enable_log_deletion` is on: it finds rows older than
`timespan_limit` days (`EventLogTrackApi::getOldRecords()`) and batch-deletes them in chunks of
`batch_size` (`deleteOldRecords()`).

## Uninstalling

`hook_uninstall()` drops the `event_log_track` table entirely.

For programmatic logging and the table schema, see [api/logging.md](../api/logging.md); to add your
own tracked event type, see [hooks/extend.md](../hooks/extend.md).
