<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts Highcharts Maps (charts_highcharts_maps) — agent index

Extends the **Charts** module with **Highcharts Maps (Highmaps)** to render choropleth
(value-shaded) geographic maps. It adds a `map` chart type, a `highmap` chart-library plugin,
and a `chart_highmap` Views style; a View's rows become map areas, joined onto GeoJSON/TopoJSON
geometry by a shared property.

- Depends on `charts:charts`. Also needs **charts_highcharts** (bundled with charts) OR
  **charts_highstock** (separate contrib) enabled — enforced at runtime by `hook_requirements`.
- Needs the **Highcharts Maps** JS library (`libraries/highcharts_maps/map.js`) installed locally,
  or the Charts CDN toggle enabled. The declared remote is
  `code.highcharts.com/maps/12.1.1/modules/map.js`.
- No dedicated settings page (no `configure` route). No permissions, no drush, no new plugin type.
- Provides config schema for the Views style (`views.style.chart_highmap`).

What you'd do:
- **Render a View as a choropleth map** → [configure/views-map.md](configure/views-map.md)
- **Install / point at the Highcharts Maps library (local vs CDN)** → [configure/library.md](configure/library.md)
- **Understand the plugins it contributes (map type, highmap library, JSON-file selection)** → [plugins/highmap.md](plugins/highmap.md)
- **Serve a taxonomy-term GeoJSON field as the map's geometry endpoint** → [api/map-data-endpoint.md](api/map-data-endpoint.md)

Key facts:
- Chart type: `map` — `charts_highcharts_maps.charts_types.yml` (label `Map`, axis `y_only`).
- Chart library plugin: `@Chart(id="highmap", types={"map"})` — `src/Plugin/chart/Library/Highmap.php`
  (extends charts' `ChartBase`, managed by `plugin.manager.charts`).
- Views style: `@ViewsStyle(id="chart_highmap")` — `HighMapsPluginStyleChart` (extends charts'
  `ChartsPluginStyleChart`), theme hook `views_view_charts_highcharts_maps`.
- Entity-reference selection: `default:charts_highcharts_charts_json_file_entity_selection`
  (extends core `FileSelection`, filters to `application/json`).
- Route: `charts_highcharts_maps.map_data` → `/charts-highmap/map-data/{json_field_name}/{taxonomy_term}`
  (`MapDataController::json`).
- Libraries: `charts_highcharts_maps/charts_highcharts_maps` (JS glue) and
  `charts_highcharts_maps/highmap` (the Highmaps `map.js`).
- Views-style config keys: `topology`, `map_data_source_settings.{json_file,vid,tid,json_field_name}`,
  `series_join_by_property_name`, `series_keys_mapping_options`, `popup`, `popup_content`, `subtitle`.
- The Highcharts Maps library is declared **CC BY-NC (non-commercial)** in the library definition —
  confirm licensing before commercial/production use.
