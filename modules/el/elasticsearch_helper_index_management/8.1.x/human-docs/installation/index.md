# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Elasticsearch Helper** module (`elasticsearch_helper`) — the base layer that
  defines the index plugins and holds the Elasticsearch connection.
- A running **Elasticsearch cluster**, with Elasticsearch Helper's connection
  already configured.

There are no additional Composer libraries or PHP extensions required by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_helper_index_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Elasticsearch Helper — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_helper_index_management -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_helper -y
drush en elasticsearch_helper_index_management -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Elasticsearch Helper → Index**
(`/admin/config/search/elasticsearch_helper/index`). You should see the index
management list, with Setup / Reindex / Drop operations available for any index
plugins defined on your site. If you have no index plugins yet, define one in a
custom module or add
[Elasticsearch Helper Content](https://www.drupal.org/project/elasticsearch_helper_content)
to create indices from the UI.
