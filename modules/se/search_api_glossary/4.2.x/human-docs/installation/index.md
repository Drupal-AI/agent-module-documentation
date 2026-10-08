# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- The **Search API** module (`search_api`) — the module builds on its processor
  and field system.
- The **Facets** module (`facets`) — the module builds on its widget and facet
  processor system.

Both are contributed modules and are pulled in automatically as dependencies when
you install with Composer. You will also need a working Search API **server and
index** (a database-backed server is fine; Solr and Elasticsearch also work). No
third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_glossary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and
Facets and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_glossary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_glossary -y
```

This enables Search API and Facets too if they are not already on. Once enabled,
follow the steps in [How to use it](../index.md#how-to-use-it) to add the Glossary
processor to your index and build the A–Z facet.
