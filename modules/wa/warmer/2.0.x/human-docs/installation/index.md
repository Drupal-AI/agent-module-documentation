# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 5.6 or newer** (`php: >=5.6.0`).
- **Drush 11.6, 12, or 13** (`drush/drush: ^11.6 || ^12 || ^13`) — Warmer provides
  Drush commands and a Drush dependency.
- The **`vipnytt/sitemapparser`** PHP library (`^1.0`), used by the CDN/Sitemap
  warmer to read XML sitemaps. Composer pulls it in automatically.

Warmer has no other module dependencies. On its own it warms nothing — you enable
one or both submodules (below) to get concrete warmers.

## Install with Composer

From the project root:

```bash
composer require drupal/warmer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `vipnytt/sitemapparser` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/warmer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en warmer -y
```

## Submodules — enable at least one warmer

The base module is just the framework. To actually warm something, enable one or
both of these:

| Submodule | Machine name | What it warms |
|-----------|--------------|---------------|
| **Entity warmer** | `warmer_entity` | The entity cache for selected entity types/bundles (with an optional "published only" filter). |
| **CDN warmer** | `warmer_cdn` | Edge/Varnish/page caches, by issuing HTTP GET requests to a list of URLs or to URLs read from XML sitemaps. |

Enable the ones you need:

```bash
drush en warmer_entity warmer_cdn -y
```

Each submodule requires the base Warmer module, which is already present once you
have installed it above. After enabling, configure the warmers as described in
[Configuration](../configuration/index.md).
