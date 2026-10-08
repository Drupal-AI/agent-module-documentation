# Configure charts — settings, Views style, field formatter

**You must enable at least one library submodule** (e.g. `drush en charts_highcharts`) before
any chart renders — the core `charts` module defines no charting library.

## Global settings — `charts.settings`

Two forms under `/admin/config/content/charts` (permission: `administer site configuration`):

| Route | Path | Purpose |
|---|---|---|
| `charts.settings` | `/admin/config/content/charts` | Defaults: library, chart type, palette, legend, tooltips, dimensions, gauge |
| `charts.settings.advanced` | `/admin/config/content/charts/advanced` | Debug + CDN/local library requirements |

Config object `charts.settings` (schema `config/schema/charts.settings.schema.yml`), edit via
`drush cget/cset charts.settings`. Key structure (`charts_default_settings`):

| Key | Default | Meaning |
|---|---|---|
| `library` | `''` | Default charting library plugin id (e.g. `highcharts`, `chartjs`, `google`, `billboard`, `c3`); `''`/`site_default` resolves to the installed default |
| `type` | `line` | Default chart type |
| `display.colors` | 25-color palette | Ordered series colors (`#006fb0`, `#f07c33`, …) |
| `display.title` / `subtitle` | `''` | Chart titles |
| `display.legend` / `legend_position` | `false` / `right` | Legend toggle + placement |
| `display.tooltips` | `true` | Show tooltips |
| `display.data_labels` / `data_markers` | `false` | Point labels / markers |
| `display.three_dimensional` / `polar` | `0` | 3D / polar rendering (library-dependent) |
| `display.dimensions.width|height` (+ `_units`) | `''` | Chart size (`%` or px) |
| `display.gauge.{min,max,green_from,…}` | 0–100 bands | Gauge thresholds |
| `xaxis.title` / `yaxis.title,min,max,prefix,suffix,decimal_count` | `''` | Axis config |
| `advanced.requirements.cdn` | `true` | Load library JS from a CDN; set `false` to require a local copy in `/libraries` |
| `advanced.debug` | `false` | Debug output |

## Views "Chart" style

Views style plugin `id: chart` (`ChartsPluginStyleChart`, theme `views_view_charts`). In a
View, set **Format → Chart**; it uses fields (`usesFields`) and a row plugin. Style settings
let you pick the library, chart type, which field is the label vs. the data series, colors,
and axis titles — overriding the `charts.settings` defaults per View. Related Views field
plugins: `ExposedChartType` (let visitors pick the chart type), `BubbleField`, `ScatterField`,
`NumericArrayField`. There is also a `chart` Views **display** plugin.

## `chart_config` field type (charts on entities)

Field type `chart_config` (label "Chart") with default widget `chart_config_default` and
formatter `chart_config_default`. Add the field to a content type to let editors enter chart
data (via an AJAX data-collector table) and per-instance library/type; the formatter renders
it through the `chart` render element. Properties: `config`, `library`, `type`.
