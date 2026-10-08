<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cevlogger — logger service & log report

## Install / enable
`drush en cevlogger -y`. The `cevlogger_logs` table is created by `hook_schema`
(`cevlogger_schema()` in `cevlogger.install`) on install — no `drush updb` is needed
for a fresh enable (updb only matters if the schema is added by a later update hook).
`cevlogger_uninstall()` drops the table. No configuration UI, no config objects.

## The service
Defined in `cevlogger.services.yml`:

```yaml
services:
  cevlogger.logger:
    class: Drupal\cevlogger\Service\CevLogger
    arguments: ['@database', '@datetime.time']
```

`Drupal\cevlogger\Service\CevLogger` (src/Service/CevLogger.php) has one public method:

```php
public function log(string $module_name, string $type, string $message): void
```

It runs a parameterized `$this->database->insert('cevlogger_logs')` writing
`module_name`, `log_type`, `log_message`, and `timestamp` (from
`TimeInterface::getCurrentTime()`). There is no return value, no batching, and no
validation of `$type` — any string is accepted (README convention: `error`,
`warning`, `info`).

### Usage
Preferred — inject `@cevlogger.logger` into your service and call:

```php
$this->cevLogger->log('my_module', 'error', 'API returned 503 for /endpoint');
```

From a hook / procedural code:

```php
\Drupal::service('cevlogger.logger')->log('my_module', 'warning', 'Unexpected value');
```

Quick test: `drush php:eval "\Drupal::service('cevlogger.logger')->log('test','info','hi');"`.
(README's "Test" line at the bottom mis-names the service `combe_logger.logger` — the
correct id is `cevlogger.logger`.)

## Table schema (`cevlogger_logs`)
`cevlogger_schema()` in `cevlogger.install`:

| Column | Type | Notes |
|--------|------|-------|
| `id` | serial, unsigned, not null | primary key |
| `module_name` | varchar(128), not null | indexed |
| `timestamp` | int, unsigned, not null | Unix time, indexed |
| `log_type` | varchar(64), not null | indexed |
| `log_message` | text (big), not null | message body |

## Admin report
Route `cevlogger.content` → `CevLoggerView::viewLogs` at `/admin/reports/cevlogger`
(menu link under Administration > Reports). Requires the
`administer site configuration` permission.

`viewLogs()` (src/Controller/CevLoggerView.php) selects `id, module_name, log_type,
log_message, timestamp` from `cevlogger_logs`, orders by `timestamp DESC`, and pages
50 rows via `PagerSelectExtender`. It renders a `#type => table` (headers ID / Module
/ Type / Message / Timestamp; `timestamp` formatted with the `date.formatter` `short`
format) plus a `#type => pager`. The query takes no request input. There is no
delete/purge/filter UI — prune the table manually (e.g. via SQL/cron in your own code)
if it grows.
