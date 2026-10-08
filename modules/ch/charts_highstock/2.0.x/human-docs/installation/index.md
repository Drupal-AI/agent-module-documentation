# Installation

## Requirements

- **Drupal core 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The base **Charts** module `drupal/charts:^5.2` and its **Charts Highcharts**
  submodule (`charts_highcharts`), both enabled. The `^5.2` constraint is why this
  2.0.x branch will not install against older Charts 4.x.
- The **Highcharts Stock** library file `stock.js` (version 12.5.0), provided as
  a local file or served from a CDN — see below. The library requires a licence
  for commercial use (<https://shop.highcharts.com/>).

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_highstock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_highstock -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Provide the `stock.js` library

You have three options; pick one.

- **Composer (recommended).** Make sure `composer/installers` is present and your
  `composer.json` has an `installer-paths` entry mapping
  `"libraries/{$name}": ["type:drupal-library"]`, and that the `highstock/highstock`
  package repository is registered. Then:

  ```bash
  composer require highstock/highstock:12.5.0
  ```

  This drops a single file at `/libraries/highstock/stock.js`.

- **npm.** Add the module to your `workspaces` with a `libraries:copy`
  postinstall step, then run `npm install` to copy `stock.js` into place.

- **CDN — no local file.** Enable the CDN option under **Chart Settings →
  Advanced**. Charts will then serve Highcharts plus the Stock module from
  jsDelivr, and you don't need a local file at all.

After enabling, visit **Reports → Status report** (`/admin/reports/status`). The
module reports the library as *Installed*, *Available through CDN*, or
*Not installed*, and warns if a stale copy of the library contains an unsafe
`js/exporting-server` sample directory.

## Enable the module

```bash
drush en charts_highstock -y
```

If the Charts Highcharts submodule is not already on, enable it too:

```bash
drush en charts_highcharts -y
```

## Submodules

- **`charts_highstock_api_example`** — an optional example module (in the Examples
  package) demonstrating the render‑array API and a JavaScript override. Enable it
  only if you want a working reference to learn from:

  ```bash
  drush en charts_highstock_api_example -y
  ```

## Verify it worked

Check the status report as described above, then edit a Views chart display or a
chart field formatter and open the library selector — **Highstock** should be
listed. Pick it, feed it a datetime x‑axis and a numeric series, and view the
chart: it should render with the six‑button range selector (1m / 3m / 6m / YTD /
1y / All) and the navigator.
