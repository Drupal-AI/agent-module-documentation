# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer** (`php_requirement: >=8.1`).
- The **Prometheus Exporter** module (`prometheus_exporter`, `^2.0`) — this add-on
  registers a collector for it and cannot work without it. This is also where the
  `/metrics` endpoint and its access control live.
- The **Webform** module (`webform`, `^6.2`) — the source of the submission
  counts.

## Install with Composer

From the project root:

```bash
composer require drupal/prometheus_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Prometheus
Exporter and Webform (and any shared dependencies) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prometheus_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prometheus_webform -y
```

Drupal enables `prometheus_exporter` and `webform` at the same time if they aren't
already on.

## Verify it worked

Go to the Prometheus Exporter settings form and confirm the **webform_submissions**
collector appears in the list of collectors. Then request the exporter's
`/metrics` endpoint and look for the `<namespace>_total` gauge with `webform="…"`
labels. See [Configuration](../configuration/index.md) to enable the collector and
check endpoint protection.
