# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies, and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_bulk_add_items -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_bulk_add_items -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_bulk_add_items -y
```

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`), open a menu, and confirm
the bulk-add option is available. Add a couple of links at once and save to
confirm they appear in the menu.
