<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PHPExcel (phpexcel) — agent index

A thin Drupal service over **PhpSpreadsheet** for reading and writing spreadsheets
(`xls` / `xlsx` / `csv` / `ods`). No module dependencies; the library is pulled by Composer
(`phpoffice/phpspreadsheet ^1 || ^2`). The module is API-only — it adds no user-facing feature, just
the `phpexcel` service other modules call.

> Name caveat: the project keeps the historical *PHPExcel* name but wraps **PhpSpreadsheet**; the
> original PHPExcel library is abandoned.

- Settings page: `configure: phpexcel.admin` → `/admin/config/development/phpexcel` (cache options only),
  permission `administer phpexcel`.
- Provides: 1 service, 1 permission, 2 alter hooks it invokes. No drush commands, no plugin types.

What you'd do:
- **Read/write a spreadsheet from code (export, exportDbResult, import)** → [api/service.md](api/service.md)
- **Alter cells/sheets during export or import from your module** → [hooks/alter-hooks.md](hooks/alter-hooks.md)
- **Change the cell-caching settings** → [configure/cache.md](configure/cache.md)
- **See the one permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Service **`phpexcel`** → `Drupal\phpexcel\PHPExcel`; args
  `logger.channel.phpexcel`, `event_dispatcher`, `module_handler`, `config.factory`, `string_translation`.
  Dedicated log channel `phpexcel` (`logger.channel.phpexcel`).
- Main methods: `export($headers, $data, $path, $options)`,
  `exportDbResult(StatementInterface $result, $path, $options)`,
  `import($path, $keyed_by_headers = TRUE, $keyed_by_worksheet = FALSE, $custom_calls = [])`.
- Export/`exportDbResult` return an int status; success is the class constant `PHPEXCEL_SUCCESS` (10).
- Config object `phpexcel.settings` (keys `cache_mechanism`, `phptemp_limit`, `apc_cachetime`,
  `memcache_host`, `memcache_port`, `memcache_cachetime`).
- Route `phpexcel.admin`; permission `administer phpexcel`; menu link under `system.admin_config_development`.
- Alter hooks invoked: `hook_phpexcel_export()` and `hook_phpexcel_import()`.

```php
$phpexcel = \Drupal::service('phpexcel');
$phpexcel->export(
  ['Title', 'Author', 'Created'],
  [['Page one', 'admin', '2026-01-01']],
  'public://report.xlsx',
);
$rows = $phpexcel->import('public://uploaded.xlsx'); // rows keyed by header labels
```
