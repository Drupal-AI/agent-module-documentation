# Installation

## Requirements

- **Drupal core 11.3+ or 12** (`core_version_requirement: ^11.3 || ^12.0`). This
  4.0.x branch targets the newest core; note the higher requirement before you
  install.
- The **Search API** module, version 1.40 or newer (`drupal/search_api ^1.40`).
- Drupal core's **Field** module (part of a standard install).
- To use the bundled Solr handler, a Solr‑backed Search API server
  (`search_api_solr` or `acquia_search`) running **Apache Solr 4.7+**, which is
  what provides the `elevateIds` / `excludeIds` support the handler relies on.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_best_bets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies, including Search API, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_best_bets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_best_bets -y
```

Enabling the module gives you the best‑bets field type, widget, formatter, and
the index processor. Nothing affects search until you add the field and enable
the processor — see [Configuration](../configuration/index.md).
