<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins this module contributes

The module defines **no new plugin type/manager**. It contributes instances to three existing
managers (the Charts library manager, Views styles, and entity-reference selection) plus one chart
type via YAML.

## 1. `map` chart type (`charts_highcharts_maps.charts_types.yml`)
Consumed by charts' `plugin.manager.charts_type`.

```yaml
map:
  label: 'Map'
  axis: 'y_only'
  axis_inverted: false
  stacking: false
```

## 2. `highmap` chart library plugin — `src/Plugin/chart/Library/Highmap.php`
```php
@Chart(id = "highmap", name = @Translation("Highmap"), types = { "map" })
class Highmap extends \Drupal\charts\Plugin\chart\Library\ChartBase
```
Registered with charts' `plugin.manager.charts` (annotation `@Chart`). Responsibilities:
- **`defaultConfiguration()`** adds a `legend` config tree (`layout`, `background_color`,
  `border_width`, `shadow`, `item_style.{color,overflow}`) and `exporting_library` (bool) on top of
  the base.
- **`buildConfigurationForm()`** renders a placeholder intro (links to charts issue 3046981), the
  legend fieldset, and an "Enable Exporting library" checkbox. `submitConfigurationForm()` persists
  `legend` and `exporting_library`.
- **`preRender($element)`** builds the Highmaps option object and attaches libraries (see
  configure/library.md). It sets `mapNavigation`, `colorAxis`, one `series` per `chart_data` child
  with `joinBy`/`keys`/`dataLabels.format = '{point.properties.woe-name}'`, and copies
  `#map_data_source_settings` to `mapDataSourceSettings` (with `json_file` normalised via
  `getUriAsFilenameString()`: `internal:` → path, `entity:file/<id>` → the file's URL, else the raw
  URI). Grouping data is expanded into `colorAxis.dataClasses`; grouping keys are hashed to integers
  via `sha1`→`hexdec`. `#raw_options` are deep-merged, so any Highmaps option can be overridden.

## 3. `chart_highmap` Views style — `src/Plugin/views/style/HighMapsPluginStyleChart.php`
`@ViewsStyle(id="chart_highmap", title="HighMaps", theme="views_view_charts_highcharts_maps")`,
extends charts' `ChartsPluginStyleChart`. This is the user-facing configuration surface — see
configure/views-map.md.

## 4. JSON-file entity-reference selection — `src/Plugin/EntityReferenceSelection/JsonFileSelection.php`
```php
@EntityReferenceSelection(
  id = "default:charts_highcharts_charts_json_file_entity_selection",
  entity_types = {"file"}, group = "default", weight = -99)
class JsonFileSelection extends \Drupal\file\Plugin\EntityReferenceSelection\FileSelection
```
Overrides `buildEntityQuery()` to add `filemime = application/json` when the selection is invoked with
`map_data_source_settings` in its configuration. It backs the **JSON File** autocomplete on the Views
style form (`#selection_handler`).

## Adding your own map library
There is no dedicated extension point beyond the standard Charts plugin system: to support a
different maps engine or map type, add your own `@Chart` library plugin (and, if needed, a
`*.charts_types.yml` type) in your module — the same way this module wires `highmap` to the `map`
type.
