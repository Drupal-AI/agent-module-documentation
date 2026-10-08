# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) enabled — Drupal enables it automatically as
  a dependency when you turn on Simple Menu Icons.

There are no third‑party Composer or PHP library requirements. Icons are served from
the public files directory, so your site must have a working public file system
(the default).

## Install with Composer

From the project root:

```bash
composer require drupal/simple_menu_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simple_menu_icons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_menu_icons -y
```

That's all — there's no configuration form and no permissions to grant. The **Icon
image** field appears immediately on custom menu links; see the
[main guide](../index.md#how-to-use-it) for how to add an icon.

This module ships no submodules.
