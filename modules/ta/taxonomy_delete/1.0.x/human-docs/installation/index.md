# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (part of the standard install).

There are no other module dependencies and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_delete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_delete -y
```

Or enable **Taxonomy Delete** from **Extend** (`/admin/modules`).

There are no submodules. After enabling, grant the required permissions and use
the delete form or Drush command — see [Configuration](../configuration/index.md).

> **This is a destructive tool.** It permanently deletes taxonomy terms. Grant
> its permission only to trusted users, and make sure you have a backup before
> emptying a vocabulary you care about.
