# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Search API Solr Autocomplete** submodule
  (`search_api_solr:search_api_solr_autocomplete`) — this module layers on top of it,
  so you need Search API, Search API Solr, and a working Solr-backed autocomplete
  search already in place.
- No third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_autocomplete_improved -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_autocomplete_improved -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_autocomplete_improved -y
```

## Verify it worked

Because the module is zero-configuration, it starts improving your existing Solr
autocomplete immediately. Try an autocomplete search that previously showed wrong or
duplicated suggestions: counts should now be accurate, duplicates removed, and
invalid suggestions filtered out. If you change or re-index content, the module
invalidates its cached counts automatically (and a normal `drush cr` cache rebuild
also refreshes them).
