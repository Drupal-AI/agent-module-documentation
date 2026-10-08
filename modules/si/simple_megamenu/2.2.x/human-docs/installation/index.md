# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third-party Composer or PHP library requirements, and no other contrib
  modules. It builds on core's Menu, Field UI, and entity systems.

To make full use of it you will want core's **Field UI** module enabled (to add
fields to your mega-menu types) and menu links created as **menu link content**
entities — the module attaches only to those, not to module-defined menu links.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_megamenu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simple_megamenu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_megamenu -y
```

## Optional: the example submodule

The project ships **Simple Mega Menu Example** (`simple_megamenu_example`), which
provides a ready-made `megamenu` bundle with example fields you can study or adapt.
Enable it to get a working starting point:

```bash
drush en simple_megamenu_example -y
```

## Verify it worked

Go to **Structure → Simple mega menu type**
(`/admin/structure/simple_mega_menu_type`) — the type listing should load. See
[Configuration](../configuration/index.md) to build your first mega menu.
