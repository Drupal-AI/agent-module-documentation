# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no third‑party PHP or JavaScript libraries — it needs
  only Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_pager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_pager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_pager -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm a **Menu
Pager** block is available for your menu. Place it in a region, then visit a page
that matches a link in that menu — you should see previous/next navigation based on
the menu's order.
