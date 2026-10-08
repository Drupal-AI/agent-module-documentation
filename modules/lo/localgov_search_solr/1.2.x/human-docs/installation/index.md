# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **LocalGov Search** (`localgov_search`) — the sitewide search framework this module
  provides a Solr backend for.
- **Search API Solr** (`search_api_solr`) — the Search API backend for Apache Solr.
- An **Apache Solr** server you run and can reach from Drupal, with a core/collection
  compatible with Search API Solr. This module ships the Solr **config‑set** to apply
  to that core.
- A **LocalGov Drupal** site.

Composer and Drupal pull the module dependencies in for you; the Solr server itself
is infrastructure you provide.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_search_solr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install LocalGov Search and
Search API Solr alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_search_solr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV can also
> provide a Solr service via an add‑on if you don't already run one.

## Enable the module

```bash
drush en localgov_search_solr -y
```

Enabling the module imports the Search API **Solr server**, the **index**, and the
field‑type/processor configuration.

## Connect it to Solr

1. Stand up a Solr core/collection and apply the Solr **config‑set** shipped under
   this module's `config/` directory, choosing the version that matches your Solr
   release.
2. In **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`), edit the imported **server** and enter your
   Solr **host, port and core**.
3. Check the connection on the Search API server report.
4. **Index** your content.

## Verify it worked

On the Search API server report the Solr connection should show as available, and the
imported index should report items indexed after you run indexing. A sitewide search
on the front end should then return Solr‑backed results.
