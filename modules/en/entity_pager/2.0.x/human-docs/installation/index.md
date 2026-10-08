# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Views** module (`views`) — the only dependency, and it's part of Drupal
  core. You'll also want the Views UI module enabled if you plan to build the View
  through the admin interface.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_pager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_pager -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_pager -y
```

There is no configuration page. Once enabled, the **Entity Pager** format becomes
available in the Views UI. See the [overview](../index.md#how-to-use-it) for
building the pager View and placing its block.

## Optional demo View

The module ships a demo View, `entity_pager_example`, which is **disabled by
default**. Enable it (in the Views UI, or by importing its configuration) and place
its example block to see a working node pager you can copy from.
