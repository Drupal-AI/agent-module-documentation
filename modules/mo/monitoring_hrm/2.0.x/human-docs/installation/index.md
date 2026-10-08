# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1** or newer.
- The **Monitoring** module (`monitoring`) — the endpoint reflects Monitoring's
  sensor results, so Monitoring must be installed with sensors configured.

## Install with Composer

From the project root:

```bash
composer require drupal/monitoring_hrm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Monitoring
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monitoring_hrm -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monitoring_hrm -y
```

## Verify it worked

Request the endpoint and check its HTTP status code:

```bash
curl -sI 'https://your-site.example/healthz'
```

A healthy site returns a success status; if a Monitoring sensor is failing, the
status reflects that. Before relying on it in production, review who can reach
`/healthz` — see the access note on the [overview page](../index.md) — and point
your load balancer, Kubernetes probe, or uptime checker at it.
