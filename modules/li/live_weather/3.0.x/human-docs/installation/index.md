# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- No other module dependencies.
- An account and credentials with a compatible weather API provider (see the
  caveats in the [overview](../index.md) — the original Yahoo Weather endpoint is
  defunct).

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/live_weather -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/live_weather -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en live_weather -y
```

## Grant the permission

Configuration is gated by the **live_weather configuration** permission. Grant it
to trusted administrator roles at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Log in as a user with the **live_weather configuration** permission and open the
Live Weather settings/location pages (see [Configuration](../configuration/index.md)).
You should be able to add a location and enter API credentials. Note that, given
the defunct upstream endpoint described in the overview, a live report may not
render until you point the module at a compatible weather service.
