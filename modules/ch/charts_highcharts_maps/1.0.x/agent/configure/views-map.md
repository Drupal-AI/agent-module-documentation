<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a choropleth map (Views style `chart_highmap`)

The module's main surface is a Views style plugin, `HighMapsPluginStyleChart`
(`@ViewsStyle(id="chart_highmap")`, title **HighMaps**). It extends charts'
`ChartsPluginStyleChart`, so the standard Charts settings apply, plus map-specific options.

## Build it
1. Create a View listing the entities that carry your per-area value (one row = one map area).
2. Set **Format → HighMaps**.
3. Add fields: a **label/category** field (the area name/code that will match the geometry) and a
   **value** field (the number that colours the area). These feed the Charts data series like any
   other Charts style.
4. Configure the map options below.

## Map data source (required — pick exactly one)
Set under **Map data settings** (`map_data_source_settings`, a `#tree` details element). Validation
(`validateOptionsForm`) fails the form unless either `json_file` or `vid` is set.

| Mode | Fields | Meaning |
|------|--------|---------|
| JSON/Topo file | `json_file` | An `entity_autocomplete` to a `file` entity (filtered to `application/json`, see the JSON-file selection plugin), OR an internal path such as `/files/data/example.json`, OR an external URL, OR a Drupal token. Stored as a URI: `entity:file/<id>`, `internal:/<path>`, or the raw URL. The browser fetches this URL directly. |
| Taxonomy-term field | `vid`, `tid`, `json_field_name` | Choose a vocabulary (`vid`), then a term (`tid`, entity_autocomplete), then one of that term's non-base fields (`json_field_name`) that stores the GeoJSON/TopoJSON. At runtime the geometry is fetched from the module's map-data endpoint (see api/map-data-endpoint.md). The vocabulary select uses AJAX (`refreshTermJsonFieldSelection`) to reveal the term/field selects. |

Choosing one mode hides the other via `#states`.

## Joining rows to geometry
- **`series_join_by_property_name`** (Highmaps `joinBy`, default `hasc`): the property name that links
  a data point to a geometry feature. Enter two comma-separated values to map different keys on each
  side (`[mapKey, dataKey]`). See `https://api.highcharts.com/highmaps/series.map.joinBy`.
- **`series_keys_mapping_options`** (Highmaps `series.map.keys`, default `['hasc','value']`): two
  textfields (**First key** / **Second key**) naming which data-array position maps to which key.

## Pop-ups
- **`popup`** (checkbox): enable clickable area pop-ups (rendered client-side as Highcharts
  annotations).
- **`popup_content`** (radios): pick one View field whose rendered output fills the pop-up. `render()`
  attaches each row's rendered field value as an annotation label keyed to that map point.

## Charts settings relabelled for maps (`chartsSettingsAfterBuild`)
- The **xAxis** section and the `data_markers`, `connect_nulls`, `three_dimensional`, `polar` display
  options are hidden (not meaningful for maps).
- The **yAxis** section is relabelled **Highcharts Map display settings**; its `title` becomes the
  **Legend title**, and `prefix`/`suffix`/`decimal_count` become the tooltip **Value prefix / suffix /
  decimals**. `min`, `max`, `min_max_label`, `labels_rotation` are hidden.

## What happens at runtime
`render()` copies `map_data_source_settings` onto `#map_data_source_settings` and the joinBy/keys/
tooltip onto `#series_data_settings`. The `highmap` library plugin's `preRender()`
(`src/Plugin/chart/Library/Highmap.php`) builds the Highmaps option object: `mapNavigation` enabled,
`colorAxis` (single series → white→series-colour gradient; grouping → `dataClasses`), one `series`
per data child with `joinBy`, `keys`, `dataLabels.format = '{point.properties.woe-name}'`, and
`chart.map = []` (a placeholder). The glue JS (`js/charts_highcharts_maps.js`) then fetches the map
geometry (from `json_file` or the endpoint), assigns it to `config.chart.map`, and calls
`Highcharts.mapChart(config)`.

## Config object & schema
These options live inside the View config entity (`views.view.<id>` → the display's
`display_options.style.options`), validated by schema type `views.style.chart_highmap`
(`config/schema/charts_highmap.views.schema.yml`). Schema keys:

| Key | Type | Notes |
|-----|------|-------|
| `chart_settings` | `charts_config` | Inherited Charts settings (colours, title, yAxis→legend, etc.). |
| `topology` | string | Declared option (default `''`); reserved, not consumed by the current render path. |
| `subtitle` | label | Map sub-title. |
| `series_join_by_property_name` | string | joinBy (default `hasc`). |
| `series_keys_mapping_options` | sequence of string | keys (default `['hasc','value']`). |
| `map_data_source_settings.json_file` | string | File URI / path / URL / token. |
| `map_data_source_settings.vid` | string | Vocabulary machine name. |
| `map_data_source_settings.tid` | integer | Term id. |
| `map_data_source_settings.json_field_name` | string | Term field holding the geometry. |
| `popup` | boolean | Enable pop-ups. |
| `popup_content` | string | View field id used as pop-up content. |

Edit through the Views UI, or export/import the view config. To set programmatically, load the view
config entity and write into the display's `style.options` array (e.g. via
`\Drupal::configFactory()->getEditable('views.view.<id>')` or a config import), keeping the keys above.
