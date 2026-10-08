<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Map Object Field implements a field which allows editors to draw shapes on maps, with Google Maps supported.

---

Map Object Field provides a field type that lets editors draw shapes (points, lines, polygons) on a map
and store them — useful for capturing geographic areas/routes/locations as structured data. It supports
Google Maps as the map provider and depends on core Field, in the Field types package.

Use it to capture map-drawn geometry on content. It is a content-editing/fields feature storing geographic
shapes. Note: if using the Google Maps provider, it loads Google's Maps JavaScript with an API key — **store/
restrict that API key** appropriately (Google Maps keys should be HTTP-referrer/domain-restricted to prevent
abuse/quota theft), and loading Google Maps is a third-party/privacy consideration. It has no access-control
role. Add the field and configure the map provider.

---

- Draw shapes on a map in a field.
- Capture points/lines/polygons.
- Store geographic geometry.
- Support Google Maps.
- Depend on core Field.
- Capture areas/routes/locations.
- Restrict the Google Maps API key (referrer/domain).
- Prevent Maps key abuse/quota theft.
- Mind Google Maps third-party/privacy.
- Have no access-control role.
- Add the map field.
- Configure the map provider.
- Draw map geometry.
- Store map shapes.
- Capture map data.
- Handle map fields.
- Draw on maps.
- Configure the map.
- Store shapes.
- Add map drawing.
