# Plugin type — TetherStatsChartRenderer

Tether Stats renders its charts through a pluggable **chart renderer** so a different chart library
can be swapped in. The active plugin id is stored in `tether_stats.settings:chart_plugin` (default
`tether_stats_google_charts`) and resolved by `TetherStatsManager::getChartRenderer()` (falls back to
the Google plugin if the configured id no longer exists).

## Defining a renderer

- Manager: `plugin.manager.tether_stats.chart_renderer`
  (`\Drupal\tether_stats\TetherStatsChartRendererPluginManager`, extends `DefaultPluginManager`).
- Plugin namespace / directory: `Plugin/tether_stats/Chart`.
- Annotation: `\Drupal\tether_stats\Annotation\TetherStatsChartRenderer` (fields: `id`, `label`).
- Interface to implement: `\Drupal\tether_stats\TetherStatsChartRendererInterface`.
- Cache key: `tether_stats_chart_renderer_plugins`.

```php
namespace Drupal\my_module\Plugin\tether_stats\Chart;

use Drupal\Core\Plugin\PluginBase;
use Drupal\tether_stats\TetherStatsChartRendererInterface;
use Drupal\tether_stats\Chart\TetherStatsChart;

/**
 * @TetherStatsChartRenderer(
 *   id = "my_chart_lib",
 *   label = @Translation("My Chart Library")
 * )
 */
class MyChartRenderer extends PluginBase implements TetherStatsChartRendererInterface {

  public function buildChart(TetherStatsChart $chart, array $options = [], bool $iterate = FALSE): array {
    // Return a render array that draws $chart with your library.
  }

  public function getDataTable(TetherStatsChart $chart): array {
    // Convert $chart->getDataTable() into your library's data structure.
  }
}
```

## Interface contract (`TetherStatsChartRendererInterface`)

- `buildChart(TetherStatsChart $chart, array $options = [], bool $iterate = FALSE): array` — the
  renderable build array; when `$iterate` is true and the schema is a
  `TetherStatsSteppedChartSchemaInterface`, store the schema in `tempstore.private`
  (`chart_schema_<id>`) so `tether_stats.chart.data` can iterate it, and add iterator state
  (`start`/`previous`/`next`).
- `getDataTable(TetherStatsChart $chart): array` — turn the chart's raw data table into the shape the
  chart API expects (used both for initial render and for AJAX iteration).

## Bundled plugin — `tether_stats_google_charts`

`\Drupal\tether_stats\Plugin\tether_stats\Chart\TetherStatsChartRendererGoogle` (label "Google Charts
API"). Injects `tether_stats.manager` and `tempstore.private:tether_stats`. Renders through theme
`tether_stats_chart_google` (template `templates/tether-stats-chart-google.html.twig`), attaching
libraries `tether_stats/tether_stats.chart.google.api` (the external `https://www.google.com/jsapi`
loader), `…/tether_stats.chart.google` and `…/tether_stats.chart`. Supports combo (bars + line/mean)
and pie charts; `getAxisStepLabel()` formats the domain axis per step (hour/day/month/year) via the
`date.formatter` service.
