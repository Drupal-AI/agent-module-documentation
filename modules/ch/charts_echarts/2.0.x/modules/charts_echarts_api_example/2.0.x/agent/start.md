<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts Apache ECharts API Example (charts_echarts_api_example) — agent index

Demo submodule of **[charts_echarts](../../../../agent/start.md)**. Enables one page that renders the
shared Charts API example charts with the **Apache ECharts** library. Package `Examples`. Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.0.0. **No chart logic of its own** — it
delegates entirely to the `charts_api_example` builder.

## Dependencies

`charts:charts`, `charts_echarts:charts_echarts`, `charts:charts_api_example`.

## What it provides (from source)

- **One route** — `charts_echarts_api_example.display` at **`/charts/example/echarts`**
  (`charts_echarts_api_example.routing.yml`). Controller
  `\Drupal\charts_echarts_api_example\Controller\EchartsApiExample::display`, title
  *"Apache ECharts API Example"*, requirement `_permission: 'access content'`. Read-only demo page;
  no forms, no mutation, no query building.
- **One menu link** — `charts_echarts_api_example.display` (`.links.menu.yml`), parented to
  `charts_api_example.display`.
- **One controller** — `EchartsApiExample` (`src/Controller/EchartsApiExample.php`), a
  `ControllerBase` that injects `charts_api_example.builder`
  (`Drupal\charts_api_example\ChartExampleBuilder`) via `create()` and returns
  `$this->exampleBuilder->build('echarts')`. That is the whole implementation.
- **No permissions/services/hooks/config** of its own. A Kernel test
  (`tests/src/Kernel/EchartsApiExampleTest.php`) asserts which example keys ECharts exposes
  (area, bar, column, line, spline, pie, donut, gauge, scatter, bubble, combos) and which it omits
  (radar, boxplot, heatmap, candlestick, range_area, polar_area).

## Operate it

1. `drush en charts_echarts_api_example` (pulls in `charts_api_example` and `charts_echarts`).
2. Visit `/charts/example/echarts` to see the full ECharts example set.
3. Disable it in production; it exists only for demonstration/reference.
