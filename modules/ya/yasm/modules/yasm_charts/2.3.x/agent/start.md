<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YASM Charts (yasm_charts) — agent index

Optional **YASM submodule**: renders YASM dashboard tables as **charts** via the contrib Charts
module. Version **2.3.x**, package `statistics`, core `^10.3 || ^11 || ^12`, PHP `^8.1`,
GPL-2.0-or-later. Depends on **`yasm`** and **`charts`**. No routes, permissions, or config schema of
its own.

## What it provides

- **Route subscriber** `Routing\YasmChartsRouteSubscriber` — reuses the parent routes but swaps their
  `_controller` to chart-aware subclasses for: `yasm.statistics.site.contents`, `.my.contents`,
  `.site.users`, `.site.files`, `.site.groups`, `.my.groups`. It changes **only** `_controller`, so
  the original `_permission` and `_custom_access` requirements (and thus all access control) stay in
  force.
- **Controllers** `Controller\{Contents,Users,Files,Groups}` — each `extends` the matching
  `Drupal\yasm\Controller\*` base, calls `parent::siteContent()/myContent()` to get the normal build,
  then passes it through `yasm_charts.builder->discoverCharts($build, [...])` with per-chart settings.
  No new query or data logic.
- **Service** `yasm_charts.builder` (`Services\YasmChartsBuilder`, implements
  `YasmChartsBuilderInterface`) — injects `config.factory`, `messenger`, `uuid`. `discoverCharts()`
  recursively finds render elements flagged `#yasm_chart` (set by `YasmBuilder::table()`) and builds a
  Charts render array from the table's `#header`/`#rows`. Supports pie, single-series ranking, and
  multi-series line/bar/column; reads the active library from `charts.settings`
  (`charts_default_settings.library`) and shows a one-time error linking to the Charts settings page
  if none is set.
- **Template** `templates/yasm_chart.html.twig` and hook `Hook\YasmChartsHooks::help()` (renders
  README).

## Solution docs

- **Route override, chart building, supported chart types** → [plugins/charts.md](plugins/charts.md)
- Parent module: [`yasm`](../../../2.3.x/agent/start.md)
