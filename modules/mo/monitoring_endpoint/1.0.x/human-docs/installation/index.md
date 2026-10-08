# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer.
- The **Monitoring** module (`monitoring`) — this module reads its sensors, so
  Monitoring must be installed and have sensors configured.
- An external monitoring tool (Uptime Kuma, Nagios, Icinga, a custom script, …)
  to poll the endpoint — optional, but that is the point of the module.

## Install with Composer

From the project root:

```bash
composer require drupal/monitoring_endpoint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Monitoring
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monitoring_endpoint -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monitoring_endpoint -y
```

## Verify it worked

After enabling, **set an endpoint key** (see
[Configuration](../configuration/index.md)).

Once you have set a key, confirm the endpoint responds by requesting it with the
token:

```bash
curl -s 'https://your-site.example/monitoring/status?token=YOUR-TOKEN'
```

You should get a JSON body with a `count_failures` value and per-sensor statuses.
A request with a wrong or missing token should return HTTP 403.
