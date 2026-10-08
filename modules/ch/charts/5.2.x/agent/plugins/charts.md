# Chart plugin types — add a library backend or a chart type

Charts defines **two** plugin types.

## 1. Chart library plugin (`Plugin/chart/Library`) — the charting-library backend

- **Manager:** `plugin.manager.charts` (`Drupal\charts\ChartManager`), namespace
  `Plugin/chart/Library`.
- **Interface:** `Drupal\charts\Plugin\chart\Library\ChartInterface`; **base class:**
  `ChartBase`.
- **Attribute:** `Drupal\charts\Attribute\Chart` (legacy `Annotation\Chart` also supported).

Each library submodule provides exactly one such plugin. To register a new charting library,
add `src/Plugin/chart/Library/MyLib.php` to your module:

```php
use Drupal\charts\Attribute\Chart;
use Drupal\charts\Plugin\chart\Library\ChartBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[Chart(
  id: "mylib",
  name: new TranslatableMarkup("My Library"),
  types: ["line", "column", "bar", "pie", "donut", "scatter"],
  example_route: NULL,
)]
class MyLib extends ChartBase {
  public function preRender(array $element) { /* build the library JSON definition */ }
  // getChartName(), getSupportedChartTypes(), isSupportedChartType(), buildConfigurationForm()…
}
```

Attribute fields: `id`, `name`, `types` (chart-type ids the library supports),
`example_route` (optional API-example page). Attach the library's JS via a
`{module}.libraries.yml` entry (with a `remote`/`cdn` source so the CDN toggle works).
`ChartManager::createInstance()` resolves `''`/`site_default` to the configured default
library, so requesting `site_default` always returns the active backend.

## 2. Chart type plugin (`Plugin/chart/Type`) — YAML-defined chart types

- **Manager:** `plugin.manager.charts_type` (`Drupal\charts\TypeManager`), class
  `Drupal\charts\Plugin\chart\Type\Type`, interface `TypeInterface`.
- **Discovery:** a `{module}.charts_types.yml` file (not PHP). Core defines the base set in
  `charts.charts_types.yml` (area, arearange, bar, boxplot, bubble, candlestick, column,
  donut, gauge, heatmap, line, pie, scatter, spline).

Each entry:

```yaml
candlestick:
  label: 'Candlestick'
  axis: 'xy'          # 'xy' (ChartInterface::DUAL_AXIS) or 'y_only' (SINGLE_AXIS)
  axis_inverted: false
  stacking: false
  coordinate: false   # true for scatter/bubble/heatmap
```

Library submodules add their own types this way (e.g. charts_chartjs adds `polarArea`,
charts_google adds `table`, charts_highcharts adds `solidgauge` and `dumbbell`).

## Restricting a library's supported types

Implement `hook_charts_plugin_supported_chart_types_alter(array &$types, string $chart_plugin_id)`
to add/remove types for a specific library plugin. The `TypeManager` dispatches a
`TypesInfoEvent` (`ChartsEvents`) you can also subscribe to.
