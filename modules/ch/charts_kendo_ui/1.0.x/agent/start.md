<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kendo UI Charts (charts_kendo_ui) — agent index

A **backend/library plugin for the contrib Charts module**. It contributes one Charts *Library* plugin so charts
built through Charts (Views, chart fields, or the Charts render API) can be rendered with **Progress Telerik's Kendo
UI** jQuery charting widgets. Package `Charts`. Depends only on **`charts`**. Core `^8.8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later (but the Kendo UI library it drives is **commercial / GPL-incompatible** — needs a license
or the 30-day trial). Version 1.0.0-alpha1.

- **The plugin, chart-type mapping, options translation, library loading and the install requirement** →
  [plugins/kendo_ui.md](plugins/kendo_ui.md)

## What it actually is

- One plugin: `KendoUi` (Charts Library plugin, `#[Chart(id: "kendo_ui")]`, label *"Kendo UI"*) in
  `src/Plugin/chart/Library/KendoUi.php`, extending `Drupal\charts\Plugin\chart\Library\ChartBase`. Declared types:
  area, arearange, bar, boxplot, bubble, candlestick, column, donut, gauge, heatmap, line, pie, radar, scatter, spline.
- **No routes, no permissions, no forms, no services, no hooks, no config objects/schema, no Drush.** Only a
  `preRender` that builds a Kendo chart definition, three libraries, one JS behavior, and a `hook_requirements`.
- It is a pure rendering adapter: it reads the Charts render element and writes `$element['#chart_definition']`, which
  the Charts module core serializes to a `data-chart` attribute (`Json::encode` in `charts` `src/Element/Chart.php`).

## Mechanism (from source)

- `KendoUi::preRender()` sets a unique `#id`, then calls `populateOptions()`, `populateAxes()`, `populateData()` to
  build `$element['#chart_definition']`; attaches libraries `charts_kendo_ui/kendo_ui`, `charts_kendo_ui/kendo_license`
  and class `charts-kendo-ui`.
- `populateOptions()` maps Charts element props (`#title`, `#subtitle`, `#title_position`, `#legend*`, `#tooltips`,
  `#data_labels`, `#data_markers`, `#stacking`, `#connect_nulls`, `#width/#height`, `#background`, `#gauge`,
  `#raw_options`) onto a Kendo config. `chartTypeConversion()` maps `arearange→rangeArea`, `boxplot→boxPlot`,
  `spline→line` (+smooth stroke).
- `populateAxes()` builds `categoryAxis` (x) and `valueAxis` (y), honoring `#opposite` and named target axes.
- `populateData()` builds Kendo `series`, handling pie/donut categories, gauge percentage scaling, combo per-series
  types, grouping colors, and per-series/axis `#raw_options` merges.
- `js/charts_kendo_ui.js` (`Drupal.behaviors.chartsKendoUi`) reads the `data-chart` JSON off each `.charts-kendo-ui`
  element and calls `jQuery(element).kendoChart(config)`, or `kendoArcGauge` when `seriesDefaults.type === 'gauge'`.

## Library loading (from charts_kendo_ui.libraries.yml)

- `charts_kendo_ui`: loads Kendo from a **pinned Telerik CDN URL** (`https://kendo.cdn.telerik.com/2025.1.227/js/kendo.all.min.js`)
  or a local `/libraries/kendo_ui/kendo.all.min.js` + `default-main.css`; the CDN path is gated by the Charts setting
  `advanced.requirements.cdn`. `kendo_license` loads `/libraries/kendo_ui/telerik-license.js`. `kendo_ui` loads the
  module's own JS.
- `charts_kendo_ui.install`: `hook_requirements` + `charts_kendo_ui_find_library()` report whether the library is
  installed locally, available via CDN, or missing (searches `libraries/`, the install profile's `libraries/`, and
  `sites/<domain>/libraries/`).

## Notes

- No content or access role of its own; all authoring/access is the Charts module's. Enable with
  `drush en charts_kendo_ui`, then pick **Kendo UI** as the Charts library.
