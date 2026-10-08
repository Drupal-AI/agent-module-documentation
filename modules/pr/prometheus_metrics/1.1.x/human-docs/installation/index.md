# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The PromPHP `prometheus_client_php` library — installed automatically as a
  Composer dependency of this module.
- **For non-default storage:** the APCu or Redis PHP extension, depending on which
  storage backend you choose (see [Configuration](../configuration/index.md)). The
  default in-memory backend needs no extension. For Redis you may need
  `pecl install -o -f redis`; for APCu the `apcu` extension.

## Install with Composer

From the project root:

```bash
composer require drupal/prometheus_metrics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the PromPHP
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prometheus_metrics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prometheus_metrics -y
```

## Submodules

- **Prometheus Metrics: Commerce** (`prometheus_metrics_commerce`) — adds
  commerce-specific metrics. Enable it only if you run Drupal Commerce:

  ```bash
  drush en prometheus_metrics_commerce -y
  ```

## Verify it worked

Grant your user the **Access prometheus metrics** permission (the endpoint is
protected by default), then request `/metrics`. You should get a text response in
Prometheus format containing metrics such as request timings and counts. Before
pointing a Prometheus server at it, read [Configuration](../configuration/index.md)
to set the endpoint path, namespace, storage backend, and — importantly — how the
endpoint is protected.
