<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Geofield polygon select lets editors pick a named polygon from a predefined GeoJSON feature collection instead of drawing geometry by hand.
---
The module adds a `PolygonFeatureCollection` config entity that stores a GeoJSON FeatureCollection plus a "keyholder" property naming the index of each feature (e.g. `city_name`). A field widget (`PolygonSelectFieldWidget`) then presents a two-step select — choose the collection, then choose a feature within it — and can be used on a plain Geofield (storing only WKT) or on the module's extended field type `GeofieldPolygonItem`, which additionally persists the selected `geojson`, `feature__collection`, and `feature` values. Supporting classes include a `FeatureCollectionStore` service for retrieving features/keys, list builders for admin and widget-settings UIs, a formatter, and a `PolygonSelectFieldSelectedEvent` dispatched whenever a feature is associated with content on save.

Widget/field settings control which collections are enabled and their order, and (for the extended field type) can sync the chosen geometry into another Geofield on the same entity just before save. When used on a pure geofield the module only writes WKT and relies on subscribers to the selection event to populate related fields (text/taxonomy). Requires the `geofield` module (and `jmikola/geojson`).

Typical setup: create one or more PolygonFeatureCollection config entities from GeoJSON, add a Geofield (or GeofieldPolygonItem) field, set its form widget to Polygon select, and enable/order collections in the field display cog settings.
---
- Let editors choose a country/region polygon from a dropdown.
- Store predefined city or district boundaries as reusable collections.
- Populate a Geofield's WKT from a picked GeoJSON feature.
- Persist the full GeoJSON of the selected feature (extended field type).
- Sync the chosen polygon into a second Geofield on the same entity.
- Subscribe to `PolygonSelectFieldSelectedEvent` to fill a taxonomy/text field.
- Manage feature collections via the admin list builder UI.
- Restrict which collections are available per field.
- Order the collections shown in the widget.
- Provide a two-step collection→feature picker to editors.
- Name feature indexes via a configurable keyholder property.
- Retrieve a feature by key using the FeatureCollectionStore service.
- Avoid hand-drawing map geometry for standardized shapes.
- Reuse the same polygon library across multiple content types.
- Format the stored selection as feature name + collection.
- Import a GeoJSON FeatureCollection once and reference it everywhere.
- Tag content with a geographic scope chosen from a curated list.
- Keep geometry consistent across editors (no free-hand variance).
- Combine WKT storage with GeoJSON metadata for richer widgets.
- Drive downstream taxonomy assignment from the selection event.
