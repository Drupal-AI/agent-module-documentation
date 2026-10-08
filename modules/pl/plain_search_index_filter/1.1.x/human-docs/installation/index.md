# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party Composer or PHP libraries.
- **Search API** (`search_api`) is recommended, not required — the module is most
  useful when you are building custom search pages and indexes, which Search API
  provides. Install it separately if you want that.

## Install with Composer

From the project root:

```bash
composer require drupal/plain_search_index_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plain_search_index_filter -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plain_search_index_filter -y
```

## Verify it worked

Two quick checks: first, the **Configuration → System → Plain Search Index Filter
settings** page should load (see [Configuration](../configuration/index.md)). Second,
the `strip_tags_safe` Twig filter should be available — add it to an index-related
template as shown in [How to use it](../index.md#how-to-use-it), clear the cache
(`drush cr`), and confirm the rendered output comes through as clean, well-spaced plain
text.
