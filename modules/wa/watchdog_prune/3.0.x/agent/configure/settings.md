<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Watchdog Prune

Form: `\Drupal\watchdog_prune\Form\WatchdogPruneSettings` (a `ConfigFormBase`).
Route `watchdog_prune.watchdog_prune_settings` → `/admin/config/development/watchdog-prune`
(`_admin_route`), gated by permission **`administer watchdog prune`** (`restrict access: TRUE`).
Menu link under *Configuration → Development*.

## Config object: `watchdog_prune.settings`

No config schema and no `config/install` default ship with the module — the object is created the
first time you save the form.

| Key | Type | Meaning | Default (in code) |
|---|---|---|---|
| `watchdog_prune_age` | string | Global "delete entries older than" threshold. On the form it is a select limited to preset relative-date strings. Applied to all types **not** covered by a per-type rule. | `-18 MONTHS` |
| `watchdog_prune_age_type` | string (textarea) | Optional per-log-type rules, one per line, `type|age` (e.g. `php|-1 MONTH`). Blank = no per-type pruning. | `''` |

### Allowed `watchdog_prune_age` select values

`''` (None — do not prune by age), `-1 WEEK`, `-2 WEEKS`, `-3 WEEKS`, `-1 MONTH`, `-2 MONTHS`,
`-3 MONTHS`, `-6 MONTHS`, `-9 MONTHS`, `-12 MONTHS`, `-18 MONTHS`, `-24 MONTHS`, `-30 MONTHS`,
`-36 MONTHS`. (Any value works via config; the UI just restricts the choices.)

### `watchdog_prune_age_type` format

Newline-separated `watchdog_entry_type|age`, each age a PHP relative-date expression. Example:

```
php|-1 MONTH
system|-1 MONTH
cron|-1 WEEK
```

Form validation rejects a per-type age that is not older than today (`strtotime` of the age must be in
the past).

## How pruning happens (`watchdog_prune_cron()`)

On every cron run:
1. For each `type|age` line: `DELETE FROM {watchdog} WHERE type = <type> AND timestamp < strtotime(<age>)`
   and remember the type.
2. Then apply the global age: `DELETE FROM {watchdog} WHERE timestamp < strtotime(<watchdog_prune_age>)`
   with `AND type NOT IN (<types handled in step 1>)`.

So per-type rules take precedence; the global rule mops up everything else. There is **no Drush
command** — pruning only occurs through cron.

## Prerequisite

Core dblog's **"Database log messages to keep"** (`admin/config/development/logging`,
`dblog.settings:row_limit`) must be **All** (`0`); otherwise core trims the table by row count on its
own and this module's age-based pruning is undermined. dblog (Database Logging) must be enabled.

## Set it with Drush (example)

```php
// drush php:eval
\Drupal::configFactory()->getEditable('watchdog_prune.settings')
  ->set('watchdog_prune_age', '-3 MONTHS')
  ->set('watchdog_prune_age_type', "php|-1 MONTH\ncron|-1 WEEK")
  ->save();
```

Then pruning takes effect on the next `drush cron`.
