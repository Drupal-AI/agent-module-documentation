# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`).
- The **Charts** module (`charts:charts`), which provides the charting framework.
- The **Highcharts Maps** JavaScript library — this is **not bundled** with the
  module and must be installed separately (see below).
- **Licensing:** Highcharts requires a commercial licence for anything beyond
  personal/non‑profit use, and **Highcharts Maps is licensed separately** from
  Highcharts. Confirm your licence position before deploying.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_highcharts_maps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Charts
dependency and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_highcharts_maps -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Add the Highcharts Maps library

The Highcharts Maps library is not included with the module. Install it into your
site's `libraries` directory following the Charts module's library‑installation
guidance, then check the site's status report at `/admin/reports/status` to
confirm the library is detected.

## Enable the module

```bash
drush en charts_highcharts_maps -y
```

## Verify it worked

Check `/admin/reports/status` to confirm the Highcharts Maps library is found.
Then build a map chart through the Charts module and Views and confirm it renders.
If the map does not appear, the most common cause is a missing or misplaced
Highcharts Maps library.
