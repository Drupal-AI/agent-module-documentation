<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure log filtering

- Route: `dblog_filter.settings` → `/admin/reports/dblog-filter` (form
  `Drupal\dblog_filter\Form\DBLogFilterSettingsForm`). Access: core permission
  `access site reports`.
- Config object: `dblog_filter.settings` (schema `dblog_filter.schema.yml`).

## Config structure

Two parallel groups — **dblog** and **syslog** — with identical shape:

| dblog key | syslog key | type | meaning |
|---|---|---|---|
| `severity_levels` | `syslog_severity_levels` | mapping of 8 RFC levels → bool | which levels the rule set targets |
| `log_values` | `syslog_log_values` | sequence of `channel\|level,level` | per-channel/level rules |
| `log_values_regex` | `syslog_log_values_regex` | sequence keyed by `md5(row)` | optional message regex per rule |
| `method` | `syslog_method` | `include` \| `exclude` | how a match is interpreted |

`severity_levels` keys (all default `false`): `emergency, alert, critical, error, warning,
notice, info, debug`.

## How `method` works

- **`exclude`** (default): a message that **matches** a rule is **dropped**; everything else logs.
- **`include`**: only messages that **match** a rule are logged; everything else is dropped.

## Decision order (per message)

1. If the message's severity is one of the **checked** `severity_levels`, the decision is made
   immediately: `include` ⇒ log, `exclude` ⇒ drop. (Channel rules are not consulted.)
2. Otherwise each `log_values` row `channel|lvl1,lvl2` is tested against the message's
   **channel** and **level**; if a `log_values_regex[md5(row)]` pattern exists it must also
   match the message text. If any row matches ⇒ `match`.
3. Final: `method == include ? match : !match`.

So with the defaults (no level checked, empty `log_values`) nothing matches ⇒ `exclude` keeps
`!match == true` ⇒ **all messages log**.

## `log_values` row format

One rule per array item: `channel|level1,level2,...` — e.g. `php|notice,error,alert` or
`mymodule|notice,warning`. The channel is the logger channel (the string passed to
`\Drupal::logger('channel')`). Levels are lowercase RFC names.

## Examples (drush / config)

Log **only** `error` and worse to the database log:

```php
\Drupal::configFactory()->getEditable('dblog_filter.settings')
  ->set('method', 'include')
  ->set('severity_levels', [
    'emergency'=>true,'alert'=>true,'critical'=>true,'error'=>true,
    'warning'=>false,'notice'=>false,'info'=>false,'debug'=>false,
  ])->save();
```

**Exclude** a chatty channel from dblog (keep everything else):

```php
\Drupal::configFactory()->getEditable('dblog_filter.settings')
  ->set('method', 'exclude')
  ->set('log_values', ['cron|info,notice,debug'])
  ->save();
```

Read current settings: `drush cget dblog_filter.settings`.

## Restore "log everything"

Set `method` back to `exclude`, uncheck all `severity_levels`, and empty `log_values` /
`log_values_regex` (and the `syslog_*` equivalents). That is the shipped
`config/install/dblog_filter.settings.yml` baseline.
