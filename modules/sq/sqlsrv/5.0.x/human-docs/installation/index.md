# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **`pdo_sqlsrv`** PHP extension (version 5.12.0 or newer). This is the
  Microsoft PDO driver for SQL Server and must be installed and enabled in PHP.
- A **Microsoft SQL Server 2016 (13.0) or newer**, or **Azure SQL Database**,
  that Drupal can reach.
- No other Drupal modules are required.

## Install with Composer

Install the module **before** running the Drupal installer, so the driver is on
disk when Drupal first connects:

```bash
composer require drupal/sqlsrv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (Unlike older Drupal versions, the driver no longer needs
to be copied into a `/drivers` directory — remove any old copy if you have one.)

> **Using DDEV?** Prefix Composer with `ddev` when you run from your host
> machine — `ddev composer require drupal/sqlsrv -W`. Inside the container
> (`ddev ssh`) run it without the prefix. Note that DDEV's default database is
> MariaDB; running Drupal on SQL Server requires an external or separately
> provisioned SQL Server instance.

## Enable the module

A database driver doesn't need to be "enabled" the way a normal module does — it
takes effect through your `settings.php` connection, not the modules page.
Enabling it (for example so its Views date plugin is available) is still fine:

```bash
drush en sqlsrv -y
```

The important step is pointing Drupal's database connection at the driver — see
[Configuration](../configuration/index.md).
