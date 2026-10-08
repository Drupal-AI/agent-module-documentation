# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Moderation Sidebar** (`drupal/moderation_sidebar`) — a hard dependency.
- **Gin Toolbar** (`drupal/gin_toolbar`) — a hard dependency, and you should be using
  the **Gin** admin theme, since the styling only activates when Gin is the active
  admin theme.

Composer pulls in both dependencies automatically if they are not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/gin_moderation_sidebar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in Moderation Sidebar and Gin Toolbar.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gin_moderation_sidebar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gin_moderation_sidebar -y
```

This also enables Moderation Sidebar and Gin Toolbar if they are not already on. You
can alternatively enable everything from **Extend** (`/admin/modules`). Make sure
**Gin** is set as your admin theme (Appearance) so the styling takes effect.

## What happens next

With Gin active, the moderation tab immediately picks up the **Default** style. If you
want the alternative look, head to [Configuration](../configuration/index.md) to switch
it to **High contrast**.
