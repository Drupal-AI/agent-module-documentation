# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A site **hosted on the Ironstar platform** — this module is only meaningful there.
- The modules whose configuration Ironstar tunes — **Fastly**, **Memcache**, and
  **Monolog** — where you intend to use those recipes. Install them as your site
  needs.

Ironstar itself declares no hard module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/ironstar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ironstar -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ironstar -y
```

## Verify it worked

After enabling, the module's settings form should be reachable from the
configuration area (see [Configuration](../configuration/index.md)). Because this
module is a platform helper, the real confirmation that it is doing its job is that
your Fastly/Memcache/Monolog configuration behaves as Ironstar expects on the
hosted environment — follow the platform's own documentation to check that.
