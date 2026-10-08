# Configure the drilldown Views style

No admin settings page — everything is set on a View's **Format → Chart highcharts drilldown** style.

## Setup
1. Create a View that returns the fields you want to chart (a parent-grouping field, a child field, a numeric
   value field).
2. Set the View **Format** to **Chart highcharts drilldown** (`chart_highcharts_drilldown`).
3. In the style settings choose a Charts **chart type** that supports drilldown — `bar`, `column`, `donut`, or
   `pie` (others are rejected by `validateOptionsForm`).
4. Configure the four drilldown fields (all selects of the View's field labels):

| Option | Config key | Meaning |
|---|---|---|
| Series Field | `fields_series_field` | Parent series; data is aggregated at this level first. Required. |
| Drilldown Field | `fields_drilldown_series_field` | Child series revealed when a parent point is clicked. Required. |
| Data Field | `fields_data_field` | The numeric values field that gets aggregated. Required. |
| Operator | `fields_operator` | Aggregation method: `sum` (default) or `average`. |

These persist under the `views.style.chart_highcharts_drilldown` schema (extends `views.style.chart`).
The plugin also `unset`s the standard Views `grouping` UI (drilldown does its own grouping).

## Rendering / hooks (`charts_highcharts_drilldown.module`)
- `hook_chart_alter()` attaches asset library `charts_highcharts_drilldown/drilldown` to every chart element.
- `hook_chart_definition_alter()` (only when `#chart_library === 'highcharts'` and a `drilldown` key is present):
  rebuilds `yAxis` (keeps title + any plotLines), sets `xAxis = ['type' => 'category']`, enables
  `accessibility.announceNewData`, enables `plotOptions.series.dataLabels`, and zeroes legend symbols for
  non-pie/donut types.

## Drilldown JS library
- Declared in `charts_highcharts_drilldown.libraries.yml` as `drilldown`, depending on
  `charts_highcharts/highcharts` + `charts_highcharts/data`.
- Loads from the Highcharts **CDN** (`https://code.highcharts.com/12.1.1/modules/drilldown.js`) by default; if a
  local copy exists at `libraries/highcharts_drilldown/drilldown.js` (or `.min.js`) it is used instead.
- `hook_requirements()` (`charts_highcharts_drilldown_find_library()`) reports at
  `admin/reports/status`: Installed (local), Available through a CDN (warning), or Not Installed (error, when CDN
  is disabled in Charts settings). Self-host to avoid the external CDN dependency.
