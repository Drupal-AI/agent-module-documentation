# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3`).
- **Symfony Messenger** (`sm`).
- **Prometheus Exporter** (`prometheus_exporter`) — the module whose plugin
  system this integrates with.

Composer pulls in the module dependencies for you. Symfony Messenger Metrics
(`sm_metrics`) should also be present, since it is the source of the statistics
being exported.

## Install with Composer

From the project root:

```bash
composer require drupal/sm_prometheus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `sm`,
`prometheus_exporter`, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm_prometheus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm_prometheus -y
```

Note this module is **minimally maintained** and **not covered by the security
advisory policy**, so apply your own judgement before relying on it in
production.

## What next

Configure the Prometheus Exporter's metrics endpoint and point your Prometheus
server at it to scrape the Symfony Messenger statistics. Restrict access to the
metrics endpoint appropriately.
