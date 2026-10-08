# Installation

## Requirements

Search API Sorts builds on the Search API framework:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Search API** module (`search_api`), enabled, with at least one index and a
  display (a Views page/block on the index, or a Search API Pages page).
- Recommended: core's **BigPipe** module (`big_pipe`). The sort block can't be cached,
  so BigPipe lets it render after the main results instead of blocking the page.
- **PHP 8.4** is supported as of the 8.x-1.3 release.

There are no third‑party Composer packages or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_sorts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_sorts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_sorts -y
```

Or enable **Search API Sorts** from **Extend** (`/admin/modules`). If you don't already
have BigPipe on, enable it too:

```bash
drush en big_pipe -y
```

There are no submodules.

## Next steps

Nothing is sortable until you enable sort fields for a display and place the sort block.
Continue to [Configuration](../configuration/index.md).
