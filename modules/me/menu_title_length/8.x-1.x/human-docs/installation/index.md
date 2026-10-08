# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8.0 || ^9 || ^10`).
- No other modules are required, and there are no third‑party PHP libraries to
  install.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_title_length -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_title_length -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_title_length -y
```

The module ships with a default limit of **20 characters**, so the constraint is
active immediately after enabling. If you want a different limit, see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Structure → Menus**, edit any menu, and add or edit a menu link. The
**Menu link title** field should now stop accepting input past the configured limit
(20 characters by default). You can change that limit at **Configuration → System →
Menu Title Length settings**.
