# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Search API** module (`search_api`) enabled — this is a hard dependency,
  and Drupal enables it for you if it is already present. Search API Stats only
  records queries that flow through a Search API index, so you need a working
  Search API server and index for the log to fill up.
- Core's **Views** module (part of Drupal core, enabled on most sites) to build
  the reports. If you want to expose the per-language filter, core's **Locale**
  module also needs to be on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_stats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_stats -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_stats -y
```

Recording starts immediately for every non-empty Search API query. There is no
configuration form to complete — head to [the main guide](../index.md) to build
your report Views.

## Optional submodule

Search API Stats ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Search API Stats Block** | `search_api_stats_block` | A block that displays the top search phrases for a chosen index — handy to place beside a search box as a "popular searches" widget. |

Enable it only if you want the block:

```bash
drush en search_api_stats_block -y
```
