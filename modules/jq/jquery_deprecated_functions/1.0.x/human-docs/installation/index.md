# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **jQuery** asset library (`core/jquery`) — always present in Drupal, and the
  module depends on it automatically.

There are no third-party Composer or PHP library requirements. (The module is most
useful on Drupal 11, which ships jQuery 4, but it installs on 10.3 too.)

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_deprecated_functions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_deprecated_functions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_deprecated_functions -y
```

There are no submodules and nothing to configure. The moment the module is enabled,
the shim is loaded on every page — see [the overview](../index.md#how-to-use-it) to
confirm it is working. Remember to clear caches so the new asset library is picked up.
