# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- The **Monolog** module (`monolog`) — this module adds a processor to Monolog's
  pipeline, so Monolog must be installed and configured.
- An Elasticsearch destination and a shipper (such as Filebeat) if you actually
  want the formatted date to reach Elasticsearch — optional, but that is the point.

## Install with Composer

From the project root:

```bash
composer require drupal/monolog_elasticsearch_date_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Monolog
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monolog_elasticsearch_date_processor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monolog_elasticsearch_date_processor -y
```

## Add the processor to your Monolog config

Enabling the module makes the processor available, but it does nothing until you
add `elasticsearch_date` to the `monolog.processors` list in your services YAML
file. See "How to use it" on the [overview page](../index.md) for the exact YAML.
Clear caches after editing the services file so the container rebuilds.

## Verify it worked

After adding the processor and clearing caches, trigger a log entry and inspect a
log record — it should now include an `extra.elasticsearch_date` field with an
Elasticsearch-compatible timestamp.
