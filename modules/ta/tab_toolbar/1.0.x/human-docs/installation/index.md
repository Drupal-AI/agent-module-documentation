# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`) — the only dependency, enabled
  automatically when you turn on Tab Toolbar.

No third‑party Composer or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/tab_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tab_toolbar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tab_toolbar -y
```

That's it — the **Page Actions** toolbar tray is active immediately on any page
that has tabs. There is no required configuration; the one optional checkbox is
described on the [overview page](../index.md#how-to-use-it).
