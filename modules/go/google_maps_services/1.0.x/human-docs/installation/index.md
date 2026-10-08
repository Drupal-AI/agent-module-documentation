# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **Google Maps Platform** project with the web service APIs you need enabled and
  an **API key** — see [Configuration](../configuration/index.md).

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/google_maps_services -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_maps_services -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_maps_services -y
```

## Verify it worked

Go to **Configuration → Web services → Google Maps Services**
(`/admin/config/services/google-maps-services`) — the settings form should load,
ready for your API key. Continue to [Configuration](../configuration/index.md).
