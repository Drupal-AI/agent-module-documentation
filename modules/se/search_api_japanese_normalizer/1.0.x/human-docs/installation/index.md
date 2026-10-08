# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`) — this is the only dependency, and
  Drupal will enable it automatically as a dependency if it isn't already on.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_japanese_normalizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_japanese_normalizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_japanese_normalizer -y
```

## Verify it worked

Edit one of your search indexes and open its **Processors** tab. You should now
see a **Japanese Normalizer** entry in the list of available processors. Tick it,
save the form, and queue your content for re-indexing so the normalized text
takes effect.
