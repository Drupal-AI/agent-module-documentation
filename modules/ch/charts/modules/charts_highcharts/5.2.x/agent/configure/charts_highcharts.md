# Use the Highcharts library

## Enable & select

```bash
drush en charts_highcharts -y
```

Registers the Chart library plugin `highcharts` (`Highcharts`, `#[Chart(id: "highcharts",
name: "Highcharts", …)]`). Make it the default at **Admin → Config → Content authoring → Chart
configuration** (`/admin/config/content/charts`) by setting the default **library** to
Highcharts, or pick "Highcharts" per View (Chart style), per chart block, or per
`chart_config` field. In a render array set `'#chart_library' => 'highcharts'`.

## Supported chart types

area, arearange, bar, boxplot, bubble, column, donut, **dumbbell**, gauge, heatmap, line, pie,
scatter, **solidgauge**, spline. The `solidgauge` and `dumbbell` types are added by this
submodule via `charts_highcharts.charts_types.yml`. Highcharts has the broadest coverage of
the bundled libraries.

## ColorChanger

Ships `src/Form/ColorChanger.php` — a form that lets editors recolor a rendered Highcharts
chart live in the UI (extends the base color-changer behavior).

## External libraries (CDN vs local) + license

Requires Highcharts 12.5.0 plus a set of official add-on modules (all 12.5.0), each a
drupal-library declared in the submodule's `composer.json`, loaded from **jsDelivr** by
default:

`highcharts` (core) + `more`, `3d`, `accessibility`, `annotations`, `boost`, `coloraxis`,
`data`, `dumbbell`, `export-data`, `exporting`, `high-contrast-light`, `no-data-to-display`,
`pareto`, `pattern-fill`.

- **CDN (default):** with `charts.settings` → `advanced.requirements.cdn: true`, all load from
  jsDelivr (`cdn.jsdelivr.net/npm/highcharts@12.5.0/…`) — no install needed.
- **Local:** disable the CDN option (`/admin/config/content/charts/advanced`) and install the
  packages into `/libraries/highcharts*` via Composer or the npm `libraries:copy` script.

**Licensing:** Highcharts is free for non-commercial use but **requires a commercial license**
for commercial sites — verify licensing before production. Config schema:
`config/schema/charts_highcharts.schema.yml`. (The nested `charts_highcharts_api_example`
submodule is a demo page — skip it in production.)
