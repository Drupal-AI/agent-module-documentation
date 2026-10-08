# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer.**
- A **MySQL or MariaDB** database — this module supports MySQL/MariaDB only.
- The **`mysqldump`** command must be available in the environment where Drupal
  runs, since the export shells out to it.
- Core's **System** module (`system`), which Drupal provides by default.

## Install with Composer

From the project root:

```bash
composer require drupal/db_export_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/db_export_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV's web
> container includes `mysqldump`, so exports work out of the box there.

## Enable the module

```bash
drush en db_export_ui -y
```

## Verify it worked

Grant yourself the **`administer db exports`** permission (see
[Configuration](../configuration/index.md)), then navigate to
`/admin/config/development/db-export`. You should see the database export page with
its export button and sanitization option.
