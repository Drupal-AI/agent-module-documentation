# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- An **external endpoint** — a CDN/reverse-proxy purge webhook, a static-site rebuild
  hook, or similar — that can receive an HTTP POST with a JSON body.
- No other modules or third-party Composer packages are required (the module uses
  Drupal core's built-in Guzzle HTTP client).

## Install with Composer

From the project root:

```bash
composer require drupal/cachetag_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cachetag_notify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cachetag_notify -y
```

After enabling, set the destination endpoint on the settings form — see
[Configuration](../configuration/index.md). Until an endpoint is configured, the
module has nothing to POST to and stays quiet.
