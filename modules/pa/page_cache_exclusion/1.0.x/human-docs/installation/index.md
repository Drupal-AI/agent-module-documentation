# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Internal Page Cache** module (`page_cache`) — a required dependency,
  enabled automatically. (If your site has page cache disabled entirely, this
  module has nothing to act on.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_cache_exclusion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/page_cache_exclusion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_cache_exclusion -y
```

The module ships no submodules. Until you add exclusion rules it changes
nothing — head to [Configuration](../configuration/index.md) to set them.
