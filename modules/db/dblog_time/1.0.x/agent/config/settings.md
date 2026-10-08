<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — `dblog_time.settings`

All configuration lives in the single config object `dblog_time.settings` and is edited through
core's logging settings form at **`/admin/config/development/logging`** (route
`system.logging_settings`, gated by the core `administer site configuration` permission). The module
adds no admin route of its own — it alters the existing core form.

## Keys

| Key | Type | Default | Purpose |
|-----|------|---------|---------|
| `limit_type` | string | `''` | Pruning policy. `row_limit` = core's count-based cron; `timespan` = age-based deletion by this module. Empty/anything other than `timespan` → core row-limit fallback. |
| `timespan` | string | `''` | Default retention window. Must be parseable by PHP `strtotime()`; intended as a relative, negative expression such as `-7 days` or `-30 minutes`. Rows with `timestamp` older than the resolved cutoff are deleted. |
| `timespan_per_type_override` | string | `''` | Optional per-type windows, one per line, format `type|-N unit` (e.g. `cron|-2 days`). Listed types are pruned at their own window and excluded from the default delete. |

Schema: `config/schema/dblog_time.schema.yml` (all three are simple `string` mappings).
Install defaults: `config/install/dblog_time.settings.yml` sets all three to empty strings, so a
fresh install behaves exactly like core dblog until an admin switches to **Timespan**.

## Form fields (labels on the settings page)

- **Determine how database log messages should be deleted** (`dblog_limit_type` radios) → `limit_type`.
  Only shown when core's `dblog_row_limit` field is present.
- **Timespan before which messages should be deleted** (`dblog_timespan` textfield) → `timespan`.
  Visible only when Timespan is selected.
- **Timespan per type before which messages should be deleted** (`dblog_timespan_per_type_override`
  textarea) → `timespan_per_type_override`. Visible only when Timespan is selected.

## Behaviour notes

- Pruning executes on **cron** only, via the `dblog_time.manager` service. There is no Drush command.
- If `limit_type` is not `timespan`, or `strtotime(timespan)` fails to parse, the module calls core
  `dblog_cron()` instead (row-limit behaviour). This fallback is silent — no validation error is
  raised on save for an unparseable string.
- Per-type parsing (`getPerTypeOverrides()`) ignores blank lines, lines without a `|`, lines with an
  empty type or timespan, and timespans that `strtotime()` cannot parse.
- Deletes are age-based, so between cron runs the `watchdog` table is unbounded in size; pair a long
  default window with short per-type overrides for noisy log types to control growth.

## Example values

```
limit_type: timespan
timespan: '-14 days'
timespan_per_type_override: |
  cron|-2 days
  php|-7 days
  user|-90 days
```

This keeps most logs 14 days, prunes `cron` and `php` faster, and retains `user` (login/security)
events for 90 days.
