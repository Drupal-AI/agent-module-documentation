<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geofield polygon select (geofield_polygon_select) — agent index
**Field widget/type to pick a polygon from predefined GeoJSON feature collections held as config entities.**

- **Version:** 2.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Requires:** geofield (composer: `drupal/geofield`, `jmikola/geojson`)
- **Config entity:** `PolygonFeatureCollection` (GeoJSON FeatureCollection + keyholder)
- **Field:** widget `PolygonSelectFieldWidget`; field type `GeofieldPolygonItem`; formatter `PolygonSelectFieldFormatter`
- **Service:** `FeatureCollectionStore`; **Event:** `PolygonSelectFieldSelectedEvent` (dispatched on save)

**Security:** field-plugin and config-entity module; admin config-entity management uses core entity access; no custom public/mutating routes; inputs are editor-supplied field values.
