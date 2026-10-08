# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Create Menus
  Permission.

There are no third-party PHP or JavaScript library requirements. **Workbench Menu
Access** is a natural companion but is **not** required.

## Install with Composer

From the project root:

```bash
composer require drupal/create_menus_permission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/create_menus_permission -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en create_menus_permission -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) and confirm a new
menu-creation permission (provided by Create Menus Permission) appears in the list.
Grant it to a non-administrator test role, log in as that role, and confirm the user
can create a new menu **without** holding core's `administer menu` permission. See the
[overview](../index.md) for the permission model and the two cautions to check.
