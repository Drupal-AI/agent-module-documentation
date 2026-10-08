# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`).
- The **Gin Toolbar** module (`drupal/gin_toolbar:^2 || ^3`) and the **Gin** admin
  theme (`drupal/gin:^4 || ^5`). Gin must be set as your administration theme for the
  Gin toolbar (and therefore this module) to take effect.

Composer pulls in Gin Toolbar and Gin as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/gin_toolbar_custom_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Gin Toolbar and Gin
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gin_toolbar_custom_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gin_toolbar_custom_menu -y
```

Also make sure the **Gin** theme is enabled and set as the administration theme
(**Appearance**), since the module extends Gin's toolbar.

## Verify it worked

Go to **Configuration → System → Gin Toolbar Custom Menu**
(`/admin/config/system/gin-toolbar-custom-menu`). If the settings form loads, the
module is active. Continue to [Configuration](../configuration/index.md) to build your
first rule.
