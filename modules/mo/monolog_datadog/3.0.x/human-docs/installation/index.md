# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Monolog** module (`monolog`) — this module adds a handler to Monolog's
  pipeline, so Monolog must be installed and configured.
- A **Datadog account** and an **API key** — you add the key to `settings.php`
  during setup.

> **Version note:** this is the 3.0.x branch, which is compatible with Monolog 3.
> Follow the module's README for the 3.x setup (the instructions here match it);
> the older 1.0.x branch had a different setup.

## Install with Composer

From the project root:

```bash
composer require drupal/monolog_datadog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Monolog
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monolog_datadog -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the module **first**, before adding the handler service, so the handler
class exists when the container is rebuilt:

```bash
drush en monolog_datadog -y
```

## Finish setup

Enabling the module is only the first step — you still need to add the Datadog
handler to `logging.services.yml` and the API key to `settings.php`. Follow "How
to set it up" on the [overview page](../index.md), in that order, to avoid a
container-build error.

## Verify it worked

Once the handler and API key are in place, run the built-in test command and check
that the entries reach Datadog:

```bash
drush monolog_datadog:test-logging-services
```
