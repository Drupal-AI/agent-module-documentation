# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, PHP extensions, or third-party libraries are required — Theme
  Selector uses only core's theme-negotiation system.

## Install with Composer

From the project root:

```bash
composer require drupal/theme_selector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/theme_selector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en theme_selector -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → User interface → Theme
Selector** (`/admin/config/user-interface/theme-selector`). You should see the
(initially empty) list of Theme Selector entities, ready for you to add your first
selectable theme — see [Configuration](../configuration/index.md).
