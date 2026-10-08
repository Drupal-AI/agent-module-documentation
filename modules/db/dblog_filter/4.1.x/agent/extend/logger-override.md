<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the logger override works

## Service swap

`Drupal\dblog_filter\DblogFilterServiceProvider::alter()` (a `ServiceProviderBase`) rewrites two
core service definitions in the container:

- `logger.dblog` → class `Drupal\dblog_filter\Logger\DBLogFilter`, args
  `@database`, `@logger.log_message_parser` (same as core `dblog\Logger\DbLog`).
- `logger.syslog` → class `Drupal\dblog_filter\Logger\SyslogFilter`, args
  `@config.factory`, `@logger.log_message_parser` (same as core `syslog\Logger\SysLog`).

Each guarded by `$container->has(...)`, so syslog is only swapped when the `syslog` module is
enabled. Because it is a service **provider** (not a subscriber), the swap happens at container
build; after enabling/disabling `dblog_filter` you must rebuild the container (`drush cr`).

## The filtering subclasses

Both are thin:

```php
class DBLogFilter extends \Drupal\dblog\Logger\DbLog {
  use LogFilterTrait;
  public function log($level, $message, array $context = []): void {
    if ($this->shouldLog('dblog', $level, $message, $context)) {
      parent::log($level, $message, $context);
    }
  }
}
```

`SyslogFilter` is identical but extends `syslog\Logger\SysLog` and passes `'syslog'`.

## `LogFilterTrait::shouldLog($type, $level, $message, $context)`

1. Reads `dblog_filter.settings`. Picks the `severity_levels` / `log_values` / `method` /
   `log_values_regex` keys for `dblog`, or the `syslog_*` keys for `syslog`.
2. Maps the numeric `$level` to its lowercase RFC name via `RfcLogLevel::getLevels()`.
3. Collects the checked severity levels. If the current level is among them, returns
   `method === 'include'` (include ⇒ log true, exclude ⇒ false) — short-circuit.
4. Otherwise loops `log_values`, calling `rowLogValueMatch()` on each
   `channel|levels` row against `$context['channel']`, the level, and (if present) the
   `log_values_regex[md5(row)]` pattern applied to the message text.
5. Returns `method === 'include' ? $match : !$match`.

## Consequences an agent should know

- The **only** persistent state is `dblog_filter.settings`; the classes are pure filters.
- Filtering happens at write time — already-stored log rows are unaffected.
- A row's regex is keyed by `md5(exact_row_string)`, so the regex entry must correspond
  1:1 with its `log_values` row text.
- Extending further: subclass `DBLogFilter`/`SyslogFilter` or reuse `LogFilterTrait` if you
  need custom logic, then re-point the service in your own `ServiceProvider`.
- Note: in the current code the syslog branch reads `syslog_log_regex` for its regex key (a
  minor inconsistency vs the `syslog_log_values_regex` it is stored under); dblog regex works
  via `log_values_regex`.
