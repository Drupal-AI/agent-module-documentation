# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Outbound HTTPS access to the National Weather Service API at
  `https://api.weather.gov/` — the module fetches forecasts from there. No API key
  is required; the NWS API is public.

There are no module dependencies and no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/nws_weather -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nws_weather -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

> **Note.** The current release is a beta (2.0.0‑beta1). Review it before relying on
> it in production.

## Enable the module

```bash
drush en nws_weather -y
```

## Verify it worked

Visit **Configuration → Web services → NWS Weather**
(`/admin/config/weather/nws_weather`) and confirm the settings form loads. After
setting a location and placing the **Multi Day Forecast** block (see
[Configuration](../configuration/index.md)), load a page with the block and confirm
the forecast renders. If it does not, check that your server can reach
`https://api.weather.gov/`.
