# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Charts** module (`drupal/charts`, `^5.1.3`) and its **Highcharts**
  submodule (`charts_highcharts`) enabled. Composer pulls in Charts
  automatically, and Drupal enables the Highcharts submodule as a dependency.
- Drupal's **Views** (core) — you build the chart from a View.

There are no third-party PHP library requirements, but the chart needs the
Highcharts drilldown JavaScript at render time (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/charts_highcharts_drilldown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Charts module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/charts_highcharts_drilldown -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_highcharts_drilldown -y
```

This enables `charts_highcharts` (and the base Charts module) as dependencies.

## The drilldown JavaScript library

The interactive drilldown behavior comes from Highcharts' `drilldown.js`. By
default it loads from the **Highcharts CDN**. If you would rather not depend on
an external CDN, place a local copy at
`libraries/highcharts_drilldown/drilldown.js` (or `drilldown.min.js`) and the
module will use that instead.

You can check which source is in use at **Reports → Status report**
(`/admin/reports/status`): the module reports whether the drilldown library is
installed locally, available through a CDN (shown as a warning), or not
installed at all (an error, if the CDN is disabled in the Charts settings).

## Next step

There is no settings page — configure the chart on a View as described in the
[overview](../index.md#how-to-use-it).
