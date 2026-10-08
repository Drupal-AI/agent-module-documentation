# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Seeds Pollination declares no contrib module dependencies and no PHP or
third-party library requirements. It is intended for sites built on the Seeds
distribution, whose other modules it enhances.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_pollination -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seeds_pollination -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_pollination -y
```

Its enhancements apply automatically once enabled. There is no configuration to
do.

## Verify it worked

Confirm the module is listed as enabled on **Extend** (`/admin/modules`). Because
Seeds Pollination is glue for the Seeds distribution, its effects are felt in how
the other Seeds modules behave rather than in any screen of its own.
