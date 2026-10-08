# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4||^10||^11`).
- The **Elasticsearch Helper** module (`elasticsearch_helper`) — the base layer that
  holds the Elasticsearch connection and index plugins.
- Core's **Views** module (part of Drupal core), which this module integrates with.
- A running **Elasticsearch cluster**, with Elasticsearch Helper's connection
  already configured and at least one index defined.
- Some custom code to make a working View: an `ElasticsearchQueryBuilder` plugin,
  and — for exposed filters — custom Views filter plugins (see the
  [overview](../index.md#how-to-use-it)).

There are no additional Composer libraries or PHP extensions required by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_helper_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Elasticsearch Helper — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_helper_views -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_helper -y
drush en elasticsearch_helper_views -y
```

## Verify it worked

Go to **Structure → Views** (`/admin/structure/views`) and start creating a new
View. In the "Show" / data-type selection you should now be able to choose
**Elasticsearch result** as the View's data type. If it's available, the integration
is in place — continue with the setup steps in the
[overview](../index.md#how-to-use-it).
