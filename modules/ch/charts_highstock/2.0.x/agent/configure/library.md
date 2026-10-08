<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: install the library & select Highstock

No dedicated admin form and no `configure` route. Configuration is per-chart through Charts.

## Dependencies
- `drupal/charts:^5.2` (base module) + `charts_highcharts` submodule; core `^10.3 || ^11 || ^12`.
- The `^5.2` Charts constraint is why 2.0.0 will not install against Charts 4.x.

## Provide the JS library (`stock.js`, one file)
- **Composer:** ensure `composer/installers` + an `installer-paths` entry `"libraries/{$name}": ["type:drupal-library"]`, add the `highstock/highstock` package repo (from composer.json), then `composer require highstock/highstock:12.5.0`. Result: `/libraries/highstock/stock.js`.
- **npm:** add the module to `workspaces` + a `libraries:copy` postinstall; `npm install` copies `stock.js`.
- **CDN:** *Chart Settings → Advanced → enable CDN*. Charts then serves Highcharts + the Stock module from jsDelivr (`highcharts@12.5.0/modules/stock.js`); no local file needed.
- `hook_requirements()` (runtime) reports Installed / Available-through-CDN / Not-installed at `admin/reports/status`, and errors if a stale library contains a `js/exporting-server` sample dir.

## Select and tune
- Anywhere Charts offers a library (Views chart display, chart field formatter, `charts.settings`), choose **Highstock**.
- The plugin adds one extra setting over Highcharts: **Range selector zoom** label —
  config key `global_options.lang.range_selector_zoom` (default `Zoom`, required).
- OHLC chart type is registered via `charts_highstock.charts_types.yml` (`ohlc`, axis `xy`).
- Config schema: `charts.settings.library_plugin.highstock` (extends the highcharts schema).
