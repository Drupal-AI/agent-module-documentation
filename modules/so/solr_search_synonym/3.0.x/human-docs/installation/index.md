# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core **System**, **Options** and **Views** modules (enabled by default on most
  sites).
- The **Search API** module (`search_api`) and the **Search API Solr** module
  (`search_api_solr`) — these are required dependencies. You also need a working
  Apache Solr backend server and index configured for your site.

There are no additional PHP library requirements, but note the module is **not
covered** by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/solr_search_synonym -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and
Search API Solr and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/solr_search_synonym -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en solr_search_synonym -y
```

## Configure the Solr backend

This module builds on Search API Solr, so you need your Solr server and index set
up first at **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`). For synonyms to be applied directly in Solr,
the module's documentation notes that the relevant field type in your Solr
schema's `schema_extra_types.xml` must use the *managed* synonym filter
(`ManagedSynonymGraphFilterFactory` in place of `SynonymGraphFilterFactory`), or
you can use the POST method the export supports; restart Solr after changing the
schema. Exact steps vary by Solr version and field type — see the project's
README for details.

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata → SOLR
Search Synonyms** (`/admin/config/search/solr-search-synonyms`). If the synonym
management page loads, the module is ready. See
[Configuration](../configuration/index.md) for how to add synonyms and export
them.
