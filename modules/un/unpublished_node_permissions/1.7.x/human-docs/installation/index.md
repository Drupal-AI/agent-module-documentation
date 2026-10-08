# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 ||
  ^11`).
- Core's **Node** module (`node`), which any content site already has.

There are no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/unpublished_node_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/unpublished_node_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unpublished_node_permissions -y
```

Enabling the module registers the new per-type permissions but does not grant
them to anyone — assign them on **People → Permissions** as described in the
module [overview](../index.md).

## Rebuild node access (required)

This module enforces visibility through Drupal's node access grant system, and
those grants are cached in the database. **After enabling the module — and again
whenever you change who holds these permissions — you must rebuild node access**
for the change to take full effect:

```bash
drush php:eval 'node_access_rebuild();'
```

You can also trigger a rebuild from the admin UI at **Reports → Status report**
when Drupal notes that node access permissions need rebuilding. If unpublished
nodes are not appearing as expected for a role, a forgotten rebuild is the most
likely cause.

This module has no submodules.
