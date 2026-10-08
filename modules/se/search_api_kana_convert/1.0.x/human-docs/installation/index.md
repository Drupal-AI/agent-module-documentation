# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Search API** module (`search_api`) — the only dependency, enabled
  automatically as a dependency if it isn't already on.
- PHP's `mbstring` extension, which provides the `mb_convert_kana` function the
  processor wraps. This ships with virtually every Drupal-capable PHP build.

There are no third-party Composer packages to add.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_kana_convert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_kana_convert -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_kana_convert -y
```

## Verify it worked

Edit one of your search indexes and open its **Processors** tab. You should see a
Kana Convert entry in the list of available processors. Tick it, save, and queue
your content for re-indexing so the normalized text takes effect.
