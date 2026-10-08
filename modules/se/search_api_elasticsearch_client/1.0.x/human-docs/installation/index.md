# Installation

## Requirements

Search API Elasticsearch Client needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Search API** (`search_api`).
- **Geofield** (`geofield`) — a declared dependency, used for the backend's
  geo-data support.
- An **Elasticsearch cluster, version 8 or newer**, that Drupal can reach.
- The **official Elasticsearch PHP client**, installed via Composer at a version
  matching your cluster. The module deliberately does *not* bundle this, so you
  can choose the version yourself.

## Install with Composer

First, require the module:

```bash
composer require drupal/search_api_elasticsearch_client -W
```

Then install the Elasticsearch PHP client that matches your Elasticsearch
version — for example, for Elasticsearch 8.11:

```bash
composer require elasticsearch/elasticsearch ^8.11
```

Adjust the constraint (`^8.11`) to match the Elasticsearch version you run. The
`-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed. The module's Composer package name
(`drupal/search_api_elasticsearch_client`) matches its machine name
(`search_api_elasticsearch_client`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_elasticsearch_client -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_elasticsearch_client -y
```

This also enables the Search API and Geofield dependencies if they are not already
on.

## Verify it worked

Go to **Configuration → Search and metadata → Search API**, click **Add server**,
and confirm that **Elasticsearch** appears as an available backend. If it does not,
double-check that the `elasticsearch/elasticsearch` PHP client is installed at a
version compatible with your cluster.
