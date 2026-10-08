# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Facets** (`facets`) and **Facets Summary** (`facets_summary`).
- **Search API Solr** (`search_api_solr`) — which in turn requires Search API and
  a working Solr server. Advanced Search enhances a Solr-backed Search API index;
  it does not provide one, so this stack must be in place and indexing content
  first.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Facets, Facets Summary, and Search API Solr
if they are not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_search -y
```

Enabling it also enables its Facets, Facets Summary, and Search API Solr
dependencies if they are not already on. After that, place the **Advanced Search**
block under **Structure → Block layout** — see the
[overview](../index.md#how-to-use-it) for the full sequence, and make sure your
Solr-backed index and facets are configured first.
