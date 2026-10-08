# Charts Highcharts Drilldown — agent index

A Views **style plugin** that extends Charts (Highcharts) to render interactive drilldown charts. Depends on
`charts:charts_highcharts`. No admin page (`configure` null), no permissions, no Drush. Configuration is entirely
in the Views style options.

- **The Views style plugin, its four option fields, supported chart types, library loading, the chart hooks** →
  [configure/views-style.md](configure/views-style.md)

Key facts:
- Plugin `chart_highcharts_drilldown` (`ChartsDrilldownPluginStyleChart` extends `ChartsPluginStyleChart`),
  theme `views_view_chart_highcharts_drilldown`.
- Options (schema `views.style.chart_highcharts_drilldown`): `fields_series_field`,
  `fields_drilldown_series_field`, `fields_data_field`, `fields_operator` (`sum`|`average`).
- Supported chart types: `bar`, `column`, `donut`, `pie` (validated in `validateOptionsForm`).
- `hook_chart_alter()` attaches library `charts_highcharts_drilldown/drilldown`;
  `hook_chart_definition_alter()` sets `xAxis.type=category`, enables dataLabels + accessibility announceNewData,
  normalizes yAxis/legend. Library loads from Highcharts CDN unless `libraries/highcharts_drilldown/` exists.
