# Configuring which databases/tables Views can see

## 1. Define the extra database in settings.php

VDC only sees connections Drupal already knows about. Add them the normal way in
`sites/default/settings.php`:

```php
$databases['legacy']['default'] = [
  'driver'   => 'mysql',
  'database' => 'legacy_db',
  'username' => '...',
  'password' => '...',
  'host'     => '...',
  'prefix'   => '',
];
```

Supported drivers (per `add_table_to_database_list()`): `mysql`, `sqlite`, `pgsql`,
`sqlsrv`/`odbc`. Any other driver returns no tables.

## 2. Enable the connection for VDC

Route `views_database_connector.settings` →
`/admin/config/development/views_database_connector` (permission
**administer site configuration**). The form (`ViewsDatabaseConnectorConfigForm`) lists a
checkbox per connection from `Database::getAllConnectionInfo()` and stores
`<connection_key>.enabled` (0/1) in config object `views_database_connector.settings`.

**Default exposure matters** (`views_database_connector_get_database_schemas()`):
- `default` (the Drupal DB) is exposed **only if** its `enabled` flag is truthy (opt-in).
- Any **non-default** connection is exposed **when no flag is set yet** (opt-out) — i.e.
  a freshly added secondary DB is visible to Views until you uncheck it and save.

After changing DB config, the README advises `drush cr` and toggling the module
disabled→enabled so Views data rebuilds.

## 3. (Optional) Restrict to specific tables

Add an allow-list in `settings.php`. When set for a connection, VDC exposes **only** the
listed tables of that connection:

```php
$settings['vdc_allow']['legacy'] = ['orders', 'customers'];
// For the Drupal DB use the key "default".
$settings['vdc_allow']['default'] = ['watchdog'];
```

Read in `views_database_connector_views_data()`; a connection absent from `vdc_allow`
is unrestricted (all its tables exposed).

## How tables/columns become Views data

`hook_views_data()` registers each table as a base table with title `[VDC] <db>:  <table>`
(both `<db>` and `<table>` run through `Html::escape`). The first column becomes the base
`field`. Each column's SQL data type is bucketed by
`views_database_connector_get_data_types()`:

| Bucket | Example SQL types | Views handlers (field / sort / filter / argument) |
|---|---|---|
| `numeric` | int, tinyint, bigint, decimal, float, bit, money | numeric / standard / numeric / numeric |
| `date` | date, datetime, time, year | standard / date / date / — |
| `string` | char, varchar, text, blob, enum, set | **standard_vdc** / standard / string / string |
| `boolean` | boolean, bool | boolean / standard / boolean / boolean |
| `broken` | anything unmatched | broken handlers (field shows as broken) |

Tables already registered by another module's `hook_views_data()` are skipped
(`find_existing_views_data_tables()`), and table-name collisions across databases must be
resolved manually (a Views/`hook_views_data()` limitation noted in the README).

## Using it in Views

Add a new View; in the **Show** select the entry prefixed `[VDC]`. The first column is
added as the first field; add the rest via **Add**. Filters/sorts/arguments are available
per the bucket table above.
