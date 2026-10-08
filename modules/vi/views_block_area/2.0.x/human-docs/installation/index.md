# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — enabled on every standard Drupal site and
  pulled in automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_block_area -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_block_area -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_block_area -y
```

There are no submodules, no permissions of its own, and no settings form. Once
enabled, the two new Views handlers — **Global: Block area** and **Content block:
Block field** — appear when you edit a view. See the [main page](../index.md) for
how to add them.
