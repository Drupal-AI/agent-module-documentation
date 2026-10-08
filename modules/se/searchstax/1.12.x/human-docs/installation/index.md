# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Search API** (`drupal/search_api`, `^1`) — a required dependency.
- The **libxml** PHP extension (`ext-libxml`), which is standard on most PHP
  installs.
- A **SearchStax subscription** and network access to SearchStax for live
  indexing, analytics, and the version check.

### Optional companions the module suggests

Add these depending on which features you want:

| Module | Enables |
|--------|---------|
| **Search API Solr** (`drupal/search_api_solr`) | Using a SearchStax Solr server as a Search API backend. **Required for indexing** — without it you get tracking/analytics only. |
| **Search API Autocomplete** (`drupal/search_api_autocomplete`) | SearchStudio auto-suggest / typeahead. |
| **Search API Attachments** (`drupal/search_api_attachments`) | The SearchStax Tika extractor for indexing PDF/office-document text. |
| **EU Cookie Compliance** (`drupal/eu_cookie_compliance`) | Gating SearchStudio analytics behind cookie consent. |
| **Key** (`drupal/key`) | Storing SearchStax credentials as Key entities instead of plain config. |

## Install with Composer

From the project root:

```bash
composer require drupal/searchstax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add the companion modules you need the same way, for
example `composer require drupal/search_api_solr`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/searchstax -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en searchstax -y
```

## Submodule

The module ships one optional submodule, **Solr to SearchStax migration**
(`solr_to_searchstax_ss_migration`) — a one-off UI and Drush workflow that
migrates an existing generic Solr server's configuration into SearchStax. Enable
it only when you're performing that migration:

```bash
drush en solr_to_searchstax_ss_migration -y
```

## Verify it worked

Go to **Configuration → Search and metadata → SearchStax**
(`/admin/config/search/searchstax`). If the settings form loads, the module is
active. To confirm indexing works, set up a Search API Solr server with the
**SearchStax Cloud with Token Auth** connector — see
[Configuration](../configuration/index.md).
