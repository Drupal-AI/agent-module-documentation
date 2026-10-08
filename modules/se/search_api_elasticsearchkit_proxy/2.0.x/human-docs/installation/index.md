# Installation

## Requirements

Search API ElasticSearchKit Proxy needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Search API** (`search_api`) — the core search framework.
- **Elasticsearch Connector** (`elasticsearch_connector`), which provides the
  Search API backend for Elasticsearch using the official Elasticsearch PHP
  client. The module routes its queries through this connector.
- A reachable **Elasticsearch** server, configured as a Search API server.

There are no additional third-party Composer or PHP library requirements declared
by the module itself, though Elasticsearch Connector has its own client
requirements — follow that module's installation notes for the Elasticsearch PHP
client.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_elasticsearchkit_proxy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name
(`drupal/search_api_elasticsearchkit_proxy`) matches the module's machine name
(`search_api_elasticsearchkit_proxy`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_elasticsearchkit_proxy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_elasticsearchkit_proxy -y
```

This also enables the Search API and Elasticsearch Connector dependencies if they
are not already on.

## Verify it worked

Go to **Configuration → Search and metadata → Search API**, confirm your
Elasticsearch server is present, and then configure the proxy's settings form as
described in [How to use it](../index.md#how-to-use-it).
