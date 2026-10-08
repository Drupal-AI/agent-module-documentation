# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — the only dependency, and you'll need at
  least one vocabulary with terms to build a menu from.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hierarchical_taxonomy_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hierarchical_taxonomy_menu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hierarchical_taxonomy_menu -y
```

This enables core's Taxonomy module too, if it isn't already on.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. Search for **Hierarchical Taxonomy Menu** — if it appears in
the block list, the module is active. Continue to
[Configuration](../configuration/index.md) to place and configure it.
