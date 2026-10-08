# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A working **Apache Solr** backend, plus these contributed modules (all hard
  dependencies):
  - **Geofield** (`geofield`) — stores the geographic data.
  - **Search API Solr** (`search_api_solr`) — the Solr backend for Search API.
  - **Search API Location** (`search_api_location`) — location search for Search
    API.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jts_solr_queries -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Geofield, Search
API Solr, and Search API Location, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jts_solr_queries -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jts_solr_queries -y
```

Drupal enables the three dependency modules automatically if they are not on
already.

## Regenerate the Solr configuration

Because this module changes the Solr `schema.xml` and the RPT spatial data type,
you must **regenerate your Search API Solr configuration and redeploy it to the
Solr core**, then reindex. Follow Search API Solr's normal config-generation and
deployment workflow — without this step Solr will not be set up to index and query
polygon shapes.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep jts_solr_queries
```

Then, after redeploying the Solr config and reindexing, add the module's spatial
"contains point" filter to a View built on your Solr index and confirm it returns
the entities whose indexed polygons contain the test point.
