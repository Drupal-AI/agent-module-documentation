# Installation

Installing MySQL 5.7 has two parts: getting the module onto the site the usual
way, and then pointing your database connection(s) at its driver in
`settings.php`. The second part is what actually switches Drupal to the relaxed
version check — enabling the module alone does nothing.

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **MySQL** module (`drupal:mysql`) — the shim subclasses it and inherits
  all its behavior. It is enabled as a dependency.
- A MySQL server of **5.7.8 or newer**, or a MariaDB server of **10.3.7 or
  newer**. The module still rejects anything older than those.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mysql57 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mysql57 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mysql57 -y
```

Or enable **MySQL 5.7** from **Extend** (`/admin/modules`). Enabling it registers
the driver but does not yet change which driver your connections use — do the
`settings.php` step below.

## Point settings.php at the driver

### Easiest: include the bundled snippet

The project ships a `settings.inc` file — an include that rewrites **every**
connection already in your `$databases` array (default, replicas, migrate
sources) to use the mysql57 driver, touching only connections whose `driver` is
`mysql`. Add this near the end of `settings.php`, *after* `$databases` is defined:

```php
require DRUPAL_ROOT . '/modules/contrib/mysql57/settings.inc';
```

The snippet assumes the module lives at `modules/contrib/mysql57` (it hardcodes
that autoload path). If your module path differs, use the manual method below
instead.

### Manual: set one connection by hand

For granular control, edit the connection directly. Keep `driver` as `mysql`, and
add the `namespace`, `autoload`, and `dependencies` keys:

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

### On a fresh install

When installing a brand‑new site, you don't need to edit `settings.php` first —
the driver appears on the installer's database‑selection screen labelled
**"MySQL 5.7 or MariaDB 10.3, 10.4, or 10.5"**. Select it there.

## Reverting later

Once the database server is upgraded to a core‑supported version (MySQL 8.0+ /
MariaDB 10.6+), remove the `require .../settings.inc` line (or the per‑connection
`namespace` / `autoload` / `dependencies` overrides) so connections fall back to
core's `mysql` driver, then uninstall the module.
