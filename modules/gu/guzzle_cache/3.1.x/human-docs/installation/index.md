# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal module dependencies. The Kevinrob/guzzle-cache-middleware
  library it works with comes in through Composer.

There are no additional PHP library requirements to add by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/guzzle_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
guzzle-cache-middleware library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/guzzle_cache -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en guzzle_cache -y
```

## Submodules

- **`guzzle_cache_middleware`** — an optional submodule shipped with the project.
  Enable it if you want the packaged middleware integration rather than wiring the
  middleware yourself:

  ```bash
  drush en guzzle_cache_middleware -y
  ```

## Verify it worked

There's nothing to see in the admin UI — this module is a developer building
block. Confirm it's active with `drush pm:list --status=enabled | grep guzzle`,
then use it from your own module's code as shown in the
[main guide](../index.md#how-to-use-it). The proof it's working is that repeated
requests to a cacheable endpoint stop hitting the network and start being served
from your configured cache bin.
