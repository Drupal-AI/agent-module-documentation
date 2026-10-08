# Installation

## Requirements

Menu Delete is deliberately minimal. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`).
- Core's menu functionality (the **Menu UI** you already use to edit menus).
  The module lists no explicit dependencies.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_delete -y
```

There is nothing to configure. Go to **Structure → Menus**, edit any menu, and
you'll see the new **Delete** checkboxes and the **Delete selected** button — see
[How to use it](../index.md#how-to-use-it).

## Permission

Menu Delete adds no permission of its own. It reuses core's **Administer menus
and menu links** (`administer menu`) permission, which administrators already
have. Anyone who can edit a menu can bulk-delete its content links.

This module ships no submodules.
