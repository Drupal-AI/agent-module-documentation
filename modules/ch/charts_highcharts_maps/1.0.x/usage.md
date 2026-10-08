<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Charts Highcharts Maps extends the Charts module with **Highcharts Maps (Highmaps)**, so a Views result set can be rendered as a choropleth — a geographic map whose areas are coloured by a value — instead of a bar or line chart.

---

The module plugs into the Charts abstraction rather than replacing it: it registers a `map` chart type, a `highmap` chart-library plugin (`@Chart`, extending Charts' `ChartBase`), and a `chart_highmap` Views style that reuses all the standard Charts settings and adds map-specific ones. You build a map by making a View, choosing the **HighMaps** format, and giving it a value series plus a geometry source. Geometry (GeoJSON/TopoJSON) comes from one of two places: a JSON **file** — a managed `file` entity, an internal path, an external URL, or a token — or a **taxonomy-term field**, which the client fetches from the module's `/charts-highmap/map-data/{field}/{term}` endpoint (access follows the term's own view access). Rows are matched to map features with Highmaps' `joinBy`/`keys` (defaults `hasc` and `['hasc','value']`), single-series data gets a white→colour gradient while grouped data becomes `colorAxis` data classes, and an optional pop-up renders a chosen View field as a Highcharts annotation. Requirements: the `charts:charts` module, either **charts_highcharts** (bundled with charts) or **charts_highstock** enabled, and the Highcharts Maps `map.js` library installed locally or served via the Charts CDN toggle. The library is declared non-commercial (CC BY-NC), so confirm licensing before commercial use.

---

- Show data as a colour-shaded (choropleth) map.
- Build a regional map from a Drupal View.
- Visualise statistics by country, region, or district.
- Colour map areas by a numeric field value.
- Render election, census, or survey results on a map.
- Map sales or revenue by territory.
- Show membership or subscriber distribution geographically.
- Serve map geometry from a managed JSON/TopoJSON file entity.
- Serve map geometry from a taxonomy-term field endpoint.
- Load geometry from an external GeoJSON URL.
- Join tabular rows to map features by a shared property (`joinBy`).
- Add clickable pop-ups showing a View field per area.
- Group areas into colour classes (data classes) by a category field.
- Add a legend with a custom title, prefix/suffix, and decimals.
- Combine a map display with other Charts outputs on the same site.
- Build a public-health or coverage dashboard.
- Show population or density across administrative areas.
- Present per-region performance or KPI data.
- Use map navigation (zoom/pan) on a rendered dataset.
- Override any Highmaps option through the Charts raw-options field.
