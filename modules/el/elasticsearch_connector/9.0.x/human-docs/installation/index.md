# Installation

## Requirements

- **Drupal 10.5+ or 11** (`core_version_requirement: ^10.5 || ^11`).
- **PHP 8.1.34 or newer**.
- The **Search API** module 1.40+ (`drupal/search_api:^1.40.0`) — the framework this
  backend plugs into. Composer installs it for you.
- Two PHP libraries, pulled in automatically by Composer:
  - `elasticsearch/elasticsearch:^9.0.0` — the official Elasticsearch PHP client.
  - `makinacorpus/php-lucene:^1.1` — for parsing advanced Lucene-syntax queries.
- **A reachable Elasticsearch 8 or 9 cluster** — self-hosted or Elastic Cloud. This
  module contains no search engine; without a live cluster it cannot connect, index,
  or query.

### Optional but useful companions

The module *suggests* (does not require) several modules you may want:

- **Key** (`drupal/key`) — to store an Elastic Cloud API key securely instead of in
  plain configuration. Needed if you use either Elastic Cloud connector.
- **Facets**, **Search API Autocomplete**, **Search API Location**, and **Search API
  Spellcheck** — for faceted search, autocomplete, geo search, and "did you mean?"
  suggestions on top of your Elasticsearch index.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Search API, the
Elasticsearch and Lucene libraries, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_connector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_connector -y
```

Drush enables the Search API dependency automatically. If you plan to use Elastic
Cloud, also enable Key:

```bash
drush en key -y
```

There are no submodules meant for production (the module ships a test-only submodule
used for its own automated tests, which you should not enable on a real site).

## Verify it worked

Go to **Configuration → Search and metadata → Search API → Add server**
(`/admin/config/search/search-api/add-server`) and open the **Backend** selector —
you should see **ElasticSearch** listed. See
[Configuration](../configuration/index.md) to finish setting up the server.
