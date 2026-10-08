# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Elasticsearch Connector** module
  (`elasticsearch_connector`) — the required dependency.
- **Search API** (`search_api`) — needed in practice, since you apply the NGram
  field type on a Search API index.
- A working Elasticsearch cluster that Elasticsearch Connector is already connected
  to.

There are no additional Composer libraries or PHP extensions required by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_connector_ngram_analyzer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_connector_ngram_analyzer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_connector_ngram_analyzer -y
```

Make sure Elasticsearch Connector (and Search API) are enabled too:

```bash
drush en elasticsearch_connector search_api -y
```

## Verify it worked

Edit a Search API index, open its **Fields** tab, and confirm that **NGram** now
appears as a selectable type for your text fields. If it does, the analyzer is
available — apply it to the fields you want and reindex, as described in the
[overview](../index.md#how-to-use-it).
