# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The base **Charts** module (`charts`) and the **Charts Highcharts** submodule
  (`charts_highcharts`), both enabled. Drupal will pull `charts` in as a
  dependency, but you must enable `charts_highcharts` too.
- The **Highcharts Stock (Highstock)** JavaScript library, provided per the
  Charts module's library‑loading conventions. This library requires a licence
  for commercial use — see <https://shop.highcharts.com/>.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_highstock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_highstock -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Provide the Highstock library

This module does not bundle the Highstock JavaScript. Add the library following
the Charts module's library conventions so Drupal can load it. The module's
`.install` may check for the library's presence and report if it is missing.
Remember to clear caches after adding library files.

## Enable the module

```bash
drush en charts_highstock -y
```

If the Charts Highcharts submodule is not already on, enable it too:

```bash
drush en charts_highcharts -y
```

## Verify it worked

Edit a Views chart display or a chart field formatter and open the library
selector. **Highstock** should now be listed as an available rendering library.
Pick it, save, and view the chart — a time‑series dataset should render with the
Highstock range selector and navigator.
