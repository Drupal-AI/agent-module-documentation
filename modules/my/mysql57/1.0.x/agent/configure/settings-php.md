<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pointing Drupal at the mysql57 driver

There is **no admin UI**. The module is activated entirely by editing the `$databases`
array in `settings.php` so each connection uses the mysql57 namespace instead of core's
`mysql`. The module still enables like a normal module (`drush en mysql57`) because it
declares a `drupal:mysql` dependency, but enabling it alone does nothing — the driver only
takes effect once a connection is repointed.

## What each connection needs

For a connection to use this driver, set:

- `namespace` → `Drupal\mysql57\Driver\Database\mysql`
- `autoload` → path to the driver source, `modules/contrib/mysql57/src/Driver/Database/mysql/`
- `dependencies` → declare core mysql as a dependency of the driver
- `driver` stays `mysql`

Example, single connection:

```php
$databases['default']['default'] = [
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'host' => 'localhost',
  'driver' => 'mysql',
  'namespace' => 'Drupal\\mysql57\\Driver\\Database\\mysql',
  'autoload' => 'modules/contrib/mysql57/src/Driver/Database/mysql/',
  'dependencies' => [
    'mysql' => [
      'namespace' => 'Drupal\\mysql',
      'autoload' => 'core/modules/mysql/src/',
    ],
  ],
];
```

## Easiest: include the bundled snippet

The project ships `settings.inc`, an IIFE that rewrites **every** connection/target already
in `$databases` (default, replicas, migrate sources) to the mysql57 namespace, only touching
connections whose `driver` is `mysql`. Add this near the end of `settings.php`, after your
`$databases` is defined:

```php
require DRUPAL_ROOT . '/modules/contrib/mysql57/settings.inc';
```

The snippet hardcodes the `autoload` path `modules/contrib/mysql57/src/Driver/Database/mysql/`
(there is a `@todo` in the source about making that dynamic), so it assumes the module lives
at `modules/contrib/mysql57`. If your module path differs, set `namespace`/`autoload` by hand
using the example above instead.

## Installer note

When installing a fresh site, the module's `Install\Tasks` subclass presents the driver on
the database-selection screen labeled **"MySQL 5.7 or MariaDB 10.3, 10.4, or 10.5"**. It
enforces its own minimums — `MYSQL_MINIMUM_VERSION = 5.7.8`, `MARIADB_MINIMUM_VERSION = 10.3.7`
— and still rejects any server older than those.

## Reverting

Once the database server is upgraded to a core-supported version (MySQL 8.0+ / MariaDB 10.6+),
remove the `require .../settings.inc` line (or the per-connection `namespace`/`autoload`/`dependencies`
overrides) so connections fall back to core's `mysql` driver, then uninstall the module.
