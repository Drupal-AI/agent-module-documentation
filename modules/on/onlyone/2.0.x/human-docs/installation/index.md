# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Admin Toolbar** (`drupal/admin_toolbar` `^3`) — a hard dependency, pulled in
  automatically by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/onlyone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Admin Toolbar.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/onlyone -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en onlyone -y
```

Nothing is restricted until you pick content types on the configuration page —
see [Configuration](../configuration/index.md).

## Optional submodule

**Only One Admin Toolbar** (`onlyone_admin_toolbar`) keeps the Admin Toolbar
Tools *Add content* menu in sync with your restricted types, so configured types
are labelled to show they lead to an edit rather than a new node. Enable it only
if you want that integration:

```bash
drush en onlyone_admin_toolbar -y
```

## A note on Drush commands

The module ships an `onlyone.drush.inc` file with commands
(`onlyone-list/enable/disable/new-menu-entry`), but these use the legacy Drush
8/9 command API that modern Drush (12/13) does not load. They are **not**
available on this site — use the admin UI to configure the module.
