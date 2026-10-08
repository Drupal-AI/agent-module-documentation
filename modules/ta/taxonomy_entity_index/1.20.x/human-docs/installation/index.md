# Installation

## Requirements

Taxonomy Entity Index is light on dependencies. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — Drupal enables it
  automatically as a dependency when you turn on Taxonomy Entity Index.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_entity_index -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_entity_index -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_entity_index -y
```

Enabling the module creates the `taxonomy_entity_index` database table but does
not index anything yet — nothing is indexed until you choose at least one entity
type on the settings form and run a rebuild. See
[Configuration](../configuration/index.md) for those two steps.

This module ships no submodules.
