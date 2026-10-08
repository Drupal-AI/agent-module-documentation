# Installation

## Requirements

Site Guardian Server Benchmarks is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`mysqli` PHP extension** if you want the database benchmark to run — it is
  optional. Without it, the DB benchmark is skipped gracefully and a notice is
  shown; the PHP and file-I/O benchmarks still work.

There are no dependent modules and no third-party Composer packages. It pairs with
the rest of the *Site Guardian* framework but does not require it.

## Install with Composer

From the project root:

```bash
composer require drupal/sgd_server_benchmarks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sgd_server_benchmarks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sgd_server_benchmarks -y
```

There is no configuration to do. The module stores its results internally; there is
no settings form.

## Verify it worked

Log in as an administrator and go to **Reports → Server benchmarks**
(`/admin/reports/server-benchmarks`). Choose an iteration count and submit the
form — you should get back timed PHP, database, and file-I/O results. Afterward,
the last results also appear as summary lines on the **Status report**
(`/admin/reports/status`).
