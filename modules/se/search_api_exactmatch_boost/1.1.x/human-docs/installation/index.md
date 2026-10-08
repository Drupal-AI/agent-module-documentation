# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11`).
- The **Search API** module (`search_api`) enabled, with at least one **index**
  attached to a **server** — this is the dependency, and Drupal enables it
  automatically as a dependency when you turn on this module.

There are no third-party Composer or PHP library requirements. The exact-match
"beyond the current page" behaviour is only available on the **Search API DB**
backend with `string` fields; other backends still work but only reorder the
current page.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_exactmatch_boost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/search_api_exactmatch_boost -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_exactmatch_boost -y
```

Enabling the module makes the **Exact match boosting** processor available on your
Search API indexes. It does nothing until you enable it on an index — see
[Configuration](../configuration/index.md).
