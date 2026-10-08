# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Menu UI** module (`menu_ui`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_child_item -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_child_item -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_child_item -y
```

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`) and click **Edit menu** on
any menu. Each menu item should now show an **add child** link. Click it, confirm
you land on a new child link's edit form, set a title and link, and save.
