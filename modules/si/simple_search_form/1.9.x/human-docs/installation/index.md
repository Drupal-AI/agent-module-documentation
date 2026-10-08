# Installation

## Requirements

Simple Search Form is a lightweight search block. It needs:

- **Drupal 10.5 or 11.2+** (`core_version_requirement: ^10.5 || ^11.2`).
- Core's **Block** system, which is standard in any Drupal install — you place the
  search block through Block layout.

There are no required third‑party Composer or PHP library dependencies. Two
**optional** modules unlock extra features, and you only need them if you want
those features:

- **Search API** (`drupal/search_api`) — so the block's GET parameter can match a
  Search API fulltext filter on a results page.
- **Search API Autocomplete** (`drupal/search_api_autocomplete`) — to add
  autocomplete suggestions to the search input.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_search_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

To add the optional integrations, require them the same way, for example:

```bash
composer require drupal/search_api drupal/search_api_autocomplete -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_search_form -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_search_form -y
```

Once enabled, the **Simple search form** block becomes available in Block layout.
See [Configuration](../configuration/index.md) for placing and configuring it.
