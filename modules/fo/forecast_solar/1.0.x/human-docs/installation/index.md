# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **HTTP Client Manager** module
  (`http_client_manager:http_client_manager`) — a hard dependency. This is the
  module that actually holds and runs the Guzzle client; Forecast Solar only
  registers the service description for it.

**No API key is required.** forecast.solar's public endpoints are open, so there
is no secret to store — nothing to set up in an environment variable or a Key
entity.

> **Not security‑advisory covered.** This project is marked
> `security_advisory_coverage: not-covered`. Keep that in mind for
> security‑sensitive deployments.

## Install with Composer

From the project root:

```bash
composer require drupal/forecast_solar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including HTTP Client Manager if it isn't already
installed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/forecast_solar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forecast_solar -y
```

Drupal will enable HTTP Client Manager too if it isn't already on.

## Verify it worked

Go to **Configuration → Web services → HTTP Client Manager**
(`/admin/config/services/http-client-manager`) and confirm that the **Forecast
Solar API** client (`forecast_solar_services`) is listed. If it appears, the
client is registered and ready to be called from code.
