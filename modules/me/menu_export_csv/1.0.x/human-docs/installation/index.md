# Installation

## Requirements

- **Drupal 10.3+ or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements. The module sits in
the Custom package.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_export_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_export_csv -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_export_csv -y
```

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`), open any menu, and confirm
a **Download CSV** link now appears at the bottom of the menu management page.
Click it and check that a CSV file downloads with the menu's links.
