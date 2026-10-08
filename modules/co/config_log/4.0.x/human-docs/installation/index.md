# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 ||
  ^11`).

There are no other module dependencies and no third-party libraries. The email
destination uses Drupal's standard mail system, so no extra setup is needed for it
beyond a working site mailer.

## Install with Composer

From the project root:

```bash
composer require drupal/config_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_log -y
```

By default the module logs to its own database table only. To change which
destinations are active and how the log behaves, see
[Configuration](../configuration/index.md).

## Submodule — the Views report

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Config Log Views | `config_log_views` | Exposes the `config_log` table to Views, adds a diff field, and ships a ready-made report at **Reports → Configuration log** (`/admin/reports/config-log`). |

Enable it if you want a browsable report of the database log:

```bash
drush en config_log_views -y
```

The report is most useful when the **database table** destination is active
(the default), since that is where it reads from.
