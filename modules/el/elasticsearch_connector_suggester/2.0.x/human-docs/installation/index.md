# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Elasticsearch Connector** module (`elasticsearch_connector`).
- The **Search API Autocomplete** module (`search_api_autocomplete`).
- **Search API** (`search_api`) — required by Search API Autocomplete and where
  your index lives.
- A working Elasticsearch cluster that Elasticsearch Connector is connected to.

There are no additional Composer libraries or PHP extensions required by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_connector_suggester -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Elasticsearch Connector and Search API Autocomplete — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_connector_suggester -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_connector_suggester -y
```

Make sure its dependencies are enabled too:

```bash
drush en elasticsearch_connector search_api_autocomplete -y
```

## Verify it worked

Open a Search API index's **Autocomplete** tab and confirm that the
**"Elastic display live results"** suggester appears as a selectable option. If it
does, the module is wired in — select it and choose your fields, as described in the
[overview](../index.md#how-to-use-it).
