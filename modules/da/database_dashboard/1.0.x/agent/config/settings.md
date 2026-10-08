<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configure and operate Database Dashboard

## Install & enable
```
composer require drupal/database_dashboard
drush en database_dashboard -y
```
Requires the core `mysql` module (declared as `drupal:mysql` in `database_dashboard.info.yml`).
Works on MySQL/MariaDB only (it queries `information_schema`).

## Required: the second `schema` database connection
The controller opens `Database::getConnection('default', 'schema')` — a connection keyed **`schema`**
that does NOT exist by default. You MUST add it to `settings.php` / `settings.local.php`, pointing at
the server's `information_schema` database with the same MySQL/MariaDB credentials your site uses:
```php
$databases['schema']['default'] = [
  'host' => 'db',                 // adapt to your DB host
  'database' => 'information_schema',
  'username' => 'drupal',         // adapt
  'password' => 'drupal',         // adapt
  'prefix' => '',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
];
```
Without this entry the page throws a connection error. The DB user needs read access to
`information_schema` (normal MySQL accounts already have it for their own schema).

## Access / permissions
- Route `database_dashboard.dashboard` requires `_permission: 'access database_dashboard'`.
- Note: `database_dashboard.permissions.yml` actually declares `access mysql_dashboard` and
  `administer mysql_dashboard configuration` (both `restrict access: true`). The route's permission
  string and the declared permission names differ, so the report is reachable only by roles that
  hold the exact string `access database_dashboard` (in practice only uid 1, which bypasses
  permission checks). Treat the page as admin-only regardless; the data (schema, table names, sizes)
  is operational and should stay behind a trusted admin role.

## Operate
Visit `/admin/reports/database` (or Reports › Database Dashboard). Five cards render:
1. **Database Size (GB)** — total size per schema.
2. **Tables size** — top 20 tables by `data_length + index_length` (MB/GB).
3. **Tables rows** — top 20 tables by `TABLE_ROWS`.
4. **Cache tables size (MB)** — same, filtered to `cache*` tables.
5. **Cache tables rows** — row counts for `cache*` tables.

The page is uncached (`#cache max-age => 0`), so reload it to see current values. Row counts for
InnoDB are engine estimates, not exact counts. There is no settings form, no export and no Drush
command; it is a pure read-only report.
