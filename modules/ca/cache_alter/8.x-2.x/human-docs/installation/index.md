# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

CacheAlter has no other module dependencies and no third-party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_alter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_alter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_alter -y
```

Once enabled, `utm_*` parameters are stripped from the page cache key and the
cookie cache context becomes available. Review the caveats in the
[overview](../index.md#how-to-use-it) — confirm UTM parameters do not affect your
output, and use only a low-cardinality cookie for the cookie context.
