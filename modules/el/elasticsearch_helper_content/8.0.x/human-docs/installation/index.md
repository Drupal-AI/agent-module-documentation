# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Elasticsearch Helper** module (`elasticsearch_helper`) — the base layer that
  holds the Elasticsearch connection.
- The **Elasticsearch Helper Index Management** module
  (`elasticsearch_helper_index_management`) — provides the index list where you set
  up, reindex, and drop indices.
- A running **Elasticsearch cluster**, with Elasticsearch Helper's connection
  already configured.

There are no additional Composer libraries or PHP extensions required by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_helper_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Elasticsearch Helper and Index Management — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_helper_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The recommended order, following the module's own installation steps, is:

```bash
drush en elasticsearch_helper -y
drush en elasticsearch_helper_index_management -y
drush en elasticsearch_helper_content -y
```

(Enabling `elasticsearch_helper_content` will pull in its dependencies
automatically, but make sure the base Elasticsearch Helper connection is configured
first — see the [Elasticsearch Helper](../../../elasticsearch_helper/8.2.x/human-docs/configuration/index.md)
configuration guide.)

## Verify it worked

Go to **Configuration → Search and metadata → Elasticsearch Helper → Index**
(`/admin/config/search/elasticsearch_helper/index`) and confirm the **Add content
index** button appears. If it does, you're ready to define an index — see
[Configuration](../configuration/index.md).
