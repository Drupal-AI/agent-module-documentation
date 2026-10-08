# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Monolog** module (`monolog`) — a hard dependency, installed
  automatically with Composer along with the underlying `monolog/monolog`
  library.
- A reachable **Grafana Loki** endpoint to push logs to (self-hosted or Grafana
  Cloud), ideally served over HTTPS and requiring authentication.

There are no additional third-party library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/monolog_loki -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Monolog module and shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monolog_loki -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monolog_loki -y
```

Enabling the module makes the Loki handler available, but logs won't be shipped
until you point it at a Loki endpoint and add the handler to your Monolog
channels. See [Configuration](../configuration/index.md).

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep monolog_loki
```

After configuring the connection (next page), trigger a log entry and confirm it
appears in Grafana / Loki (query by one of the labels you configured).
