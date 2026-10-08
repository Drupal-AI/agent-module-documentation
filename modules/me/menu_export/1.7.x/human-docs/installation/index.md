# Installation

## Requirements

Menu Export is a self‑contained deployment helper. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Menu UI** / menu link content system (part of a standard Drupal install)
  — the content menu links you create in the admin UI are what this module exports.

There are no third‑party Composer packages, no PHP library requirements, and no
other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_export -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_export -y
```

## Grant the permission

Everything Menu Export does is gated by a single permission, **Export and import
menu links**. At **People → Permissions** (`/admin/people/permissions`), grant it to
the roles that manage deployments (typically administrators). Without it, the Menu
Export tabs are not reachable.

## Verify it worked

Go to **Structure → Menu Export** (`/admin/config/development/menu_export`). You
should see the **Menu List**, **Export**, and **Import** tabs. Continue to
[Configuration](../configuration/index.md) to select menus and run your first
export.
