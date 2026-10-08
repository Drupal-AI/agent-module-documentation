# Installation

## Requirements

- **Drupal 10.5+ or 11.2+** (`core_version_requirement: ^10.5 || ^11.2`) — any
  actively supported version of core.
- All other (non-Drupal) dependencies are managed automatically by Composer.

**Versions and upgrading:** for Drupal 11.4, 12, and above, use the module's
`v1`. On Drupal 10 and 11 you may use any `v0` release. When upgrading from
`v0.x`, switch any use of the `command` entry point to Drupal core's new `dr`
CLI; `v1` is intended as a drop-in replacement for `v0.2`/`v0.3`.

## Install with Composer

From the project root:

```bash
composer require drupal/sm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm -y
```

To enable the configuration submodule as well:

```bash
drush en sm_config -y
```

## What next

Symfony Messenger ships with a Drupal SQL native transport, so you can start
dispatching and consuming messages right away. Add a companion project only when
you need it — for example a **transport** (Redis, AMQP, Doctrine) for a different
async backend, the **Message Scheduler** for recurring dispatch, or the
**Metrics/Monitor** modules for observability. See the module's README for the
full developer setup, including how to run a consumer.
