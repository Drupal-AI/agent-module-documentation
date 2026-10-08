# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Content that uses **entity-reference fields** between nodes (with `field_`-prefixed
  machine names) — that is the relationship CacheRefs keeps fresh.
- No other modules, third-party Composer packages, or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/cacherefs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cacherefs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cacherefs -y
```

That is all there is to it. There is no configuration — the cache-tag invalidation on
node insert, update, and delete happens automatically from the moment the module is
enabled.
