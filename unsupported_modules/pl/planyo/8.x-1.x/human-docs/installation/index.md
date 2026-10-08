# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Planyo account** with a configured Planyo site, and its **API key** (and site
  ID) from your Planyo dashboard.
- Outbound HTTPS access from visitors' browsers (and, where applicable, your server)
  to Planyo, since the reservation widget and flow are hosted by Planyo.
- No third-party Composer or PHP libraries.

## Install with Composer

Note that the **Composer package name differs from the module's machine name**. Install
with the project name:

```bash
composer require drupal/planyo_reservation_system -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/planyo_reservation_system -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **module machine name**, `planyo`:

```bash
drush en planyo -y
```

## Verify it worked

After enabling, provide your Planyo site and API details as described in
[Configuration](../configuration/index.md), then place or view the page where the
Planyo widget renders and confirm the reservation flow loads and shows your Planyo
site's availability. If it does not appear, re-check the API key, the site ID, and
that Planyo is reachable over HTTPS.
