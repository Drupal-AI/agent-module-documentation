# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- The **Address** module (`address`) enabled — a required dependency, and the field
  this module enhances. Composer pulls it in automatically.
- An account with one of the supported geocoding providers — **Google Maps**,
  **Mapbox**, or **Post.ch** — and its API key / token / credentials.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/address_autocomplete_suggestion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `address` dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_autocomplete_suggestion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_autocomplete_suggestion -y
```

Drush enables the `address` dependency at the same time. Next, choose a provider,
enter its credentials, and switch your Address field to the widget — see
[Configuration](../configuration/index.md).
