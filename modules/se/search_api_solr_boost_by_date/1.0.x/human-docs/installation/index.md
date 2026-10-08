# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core **Views** (`views`).
- **Search API** (`search_api`) and **Search API Solr** (`search_api_solr`), with a
  working Solr server and index.

There are no third-party PHP library requirements.

> **Consider the built-in feature first.** This module is deprecated: Search API
> Solr 4.1.12 and later can do date boosting on their own. Install this module only
> if you need different date boosting across multiple Views that share one index.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_solr_boost_by_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_solr_boost_by_date -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_solr_boost_by_date -y
```

## Verify it worked

Edit a View that is based on a Search API Solr index and open the list of filters
to add. The **Boost by Date** filter should be available. Add it to a View whose
sort is set to relevance (descending) to see recency-weighted ranking in action.
