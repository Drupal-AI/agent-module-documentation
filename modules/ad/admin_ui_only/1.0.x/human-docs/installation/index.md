# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0** or newer.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_ui_only -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_ui_only -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_ui_only -y
```

> **Important:** review the [Configuration](../configuration/index.md) before you
> depend on the lockdown. If your allow-list is incomplete, a route that must stay
> public — including the API endpoints your front-end app calls, or the login
> page — can be blocked. Confirm the allow-list is complete and correct on a
> non-production environment first.
