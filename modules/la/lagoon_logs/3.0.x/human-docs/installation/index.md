# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- The **Monolog** PHP library (`monolog/monolog`, `^3.0`) — pulled in automatically
  by Composer.

The module has no Drupal module dependencies of its own. It is intended for sites
hosted on the **Lagoon** platform, where the default log endpoint and the
`LAGOON_PROJECT` / `LAGOON_GIT_SAFE_BRANCH` environment variables are already
provided; it can also be pointed at any Logstash‑compatible UDP collector.

## Install with Composer

From the project root:

```bash
composer require drupal/lagoon_logs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Monolog and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lagoon_logs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lagoon_logs -y
```

There are no submodules. On Lagoon, that's all that's needed — logs begin shipping
with the built‑in defaults. Off Lagoon, or with a custom collector, adjust the host
and port as described in [Configuration](../configuration/index.md).
