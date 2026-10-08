<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# yasm_charts — route override & chart building

Enable with `drush en yasm_charts` (pulls in `yasm` + `charts`). Then choose a chart library at
`/admin/config/content/charts` — without one, YASM shows a one-time "set up a charts library" error
and draws no charts.

## How charts attach to existing pages

`Routing\YasmChartsRouteSubscriber::alterRoutes()` overrides the `_controller` default of six parent
routes (site/my contents, site users, site files, site/my groups) to the subclasses in
`Controller\`. It does **not** touch `_permission` or `_custom_access`, so access is unchanged.

Each subclass `extends` its `Drupal\yasm\Controller\*` base and does:

```
$build = parent::siteContent($request);        // normal statistics tables
return $this->yasmChartsBuilder->discoverCharts($build, [ 'chart_key' => settings… ]);
```

So all data gathering (and its access checks, permissions, group filtering) is the parent's; this
submodule only decorates the finished render array.

## `Services\YasmChartsBuilder`

Constructor loads `charts.settings` and injects `messenger` + `uuid`.

- **`discoverCharts(array $build, array $settings)`** — recurses through `$build`; when it finds the
  `#yasm_chart` key (a chart-key string that `YasmBuilder::table()` stamps onto chartable tables) and
  the sibling `yasm_table`, it calls `applyChartSettings()` and inserts the resulting `yasm_chart`
  element next to the table. If no chart library is configured it emits a single error message (static
  guard) and returns the build unchanged.
- **`buildChart()`** builds a `#type => 'chart'` render array (Charts 5.x/6.x API) from the table
  `#rows`:
  - **pie** — one `[label, (int) value]` pair per row in `series_0` `#data`.
  - **single-series** (ranking bar/column) — same `[label, value]` pair shape with a color.
  - **multi-series line/bar/column** — `getChartSeries()` turns each row into a series, `xaxis`
    `#labels` come from `getChartCategories()` (the header), `yaxis` added; `skip_left/right/top` and
    `label_position` settings control which columns are labels vs. values.
- Helpers: `getPieChartData()`, `getChartLabel()`, `skipArray()`, `getChartColor()` (12 fixed hex
  colors, then random), `isSize()` + `Bytes::toNumber()` (so disk-size strings like "5 MB" chart as
  bytes). Values are cast to `(int)` / bytes; labels are cast to `(string)`.

## Data flow / safety notes

- Row values feeding charts are the parent's already-computed statistics (node titles, bundle labels,
  usernames, counts). They are placed into Charts `#data`/`#labels` render structures; the Charts
  module owns their front-end rendering/escaping. No remote data is fetched by this submodule and it
  runs no database queries of its own.
- `templates/yasm_chart.html.twig` derives the library to attach from `chart_type`
  (`charts_{type}/{type}`), a value from chart settings, not from request input.
