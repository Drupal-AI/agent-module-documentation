Adds a Views style plugin that extends the Charts (Highcharts) module to render interactive Highcharts **drilldown** charts, where clicking a top-level series expands into a child series.

---

The module provides a single Views style plugin `chart_highcharts_drilldown`
(`ChartsDrilldownPluginStyleChart`, extending Charts' `ChartsPluginStyleChart`). Its options form adds four
settings — **Series Field** (parent grouping), **Drilldown Field** (child series shown on click), **Data Field**
(the aggregated values) and **Operator** (`sum` or `average`) — stored under the
`views.style.chart_highcharts_drilldown` config schema. It validates that the chosen chart type is one of the
supported types (`bar`, `column`, `donut`, `pie`). At render time it aggregates the view's rows into a parent
series plus per-parent drilldown series and hands the definition to Charts. Two module hooks finish the wiring:
`hook_chart_alter()` attaches the `charts_highcharts_drilldown/drilldown` asset library (the Highcharts
drilldown JS), and `hook_chart_definition_alter()` sets `xAxis.type = category`, enables data labels and
accessibility "announce new data", and normalizes the yAxis/legend for drilldown. The drilldown JS loads from
the Highcharts CDN by default (`code.highcharts.com/.../modules/drilldown.js`) unless a local
`libraries/highcharts_drilldown/drilldown(.min).js` copy is present; `hook_requirements()` reports which. It has
no admin settings page, menu, or permissions — configuration lives entirely in the Views style options. Requires
the Charts module (`charts_highcharts` submodule).

---

- Build an interactive drilldown chart from a View.
- Show top-level categories that expand into sub-categories on click.
- Aggregate a data field by SUM across each parent series.
- Aggregate a data field by AVERAGE across each parent series.
- Visualize hierarchical data (e.g. region → country, category → product).
- Render drilldown as a column or bar chart.
- Render drilldown as a pie or donut chart.
- Map a "series" field to the parent grouping level.
- Map a "drilldown" field to the child series revealed on click.
- Reuse existing Charts/Highcharts configuration and theming.
- Add data labels automatically to the drilldown chart.
- Improve accessibility with Highcharts "announce new data" on drill.
- Serve the drilldown library locally instead of via CDN.
- Get an install-time requirements check for the drilldown JS library.
- Present summarized metrics that users can explore without leaving the page.
- Turn tabular View results into an explorable two-level chart.
- Restrict chart type selection to types that support drilldown.
- Combine Views filters/contextual filters with a drilldown chart display.
