# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — the only dependency. Drupal enables
  it automatically if it is not already on.

There are no third‑party Composer or PHP library requirements, no permissions of
its own, and no Drush commands.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_max_depth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_max_depth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_max_depth -y
```

There are no submodules. The module adds no settings page — instead it adds a
**Maximum ancestor depth** field to each vocabulary's edit form. See
[Configuration](../configuration/index.md).
