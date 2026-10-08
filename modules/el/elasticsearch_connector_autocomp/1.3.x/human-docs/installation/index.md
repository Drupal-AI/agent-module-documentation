# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **[Search API](https://www.drupal.org/project/search_api)** (`search_api`).
- **[Elasticsearch Connector](https://www.drupal.org/project/elasticsearch_connector)**
  version `^8.0@alpha` (`elasticsearch_connector`) — a hard dependency, pulled in
  by Composer.
- Core's **System** module (always present).
- A working **Elasticsearch** server, connected as a Search API server through
  Elasticsearch Connector, with at least one index.

Note that Elasticsearch Connector `8.x` is an **alpha** release, so your project's
minimum‑stability settings must allow alpha packages for Composer to install it.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_connector_autocomp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Elasticsearch Connector and Search API — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/elasticsearch_connector_autocomp -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_connector_autocomp -y
```

This also enables Search API and Elasticsearch Connector if they are not already
on. There is no configuration form to visit — the module adds its options directly
to your Search API index. Continue to [Configuration](../configuration/index.md).

## Verify it worked

Edit an existing Elasticsearch‑backed Search API index at **Configuration → Search
and metadata → Search API → *(your index)* → Edit**. If you see an **Elasticsearch
specific index options** section with an *Enable ngram analyzer* checkbox, the
module is installed correctly.
