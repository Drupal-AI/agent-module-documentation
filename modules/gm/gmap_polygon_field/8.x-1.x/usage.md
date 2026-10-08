<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GMap Polygon Field adds a field type that lets editors draw one or more polygons on an embedded Google Map and stores the resulting geometry, with a formatter to display the map and shapes.

---

It defines a field type, widget (Google Maps drawing tools for creating/editing polygons), and formatter, plus a settings form at /admin/config/content/gmap_polygon_field (perm 'administer gmap_polygon_field') for the Google Maps API key and related options, and a sample page at /examples/gmap_polygon_field (perm 'access content') demonstrating the field. A ConfigService reads module configuration and JS libraries load the Maps drawing UI. It depends on core field. Because it embeds the Google Maps JavaScript API, you must supply a valid API key with the Maps JavaScript + Drawing libraries enabled; note the field's admin permission is defined with 'restrict access: FALSE'. Use it to capture service areas, delivery zones, land parcels, or any editor-drawn regions.

---

- Let editors draw a delivery or service area on a map.
- Capture land parcel boundaries as polygons.
- Store a region shape alongside a content item.
- Display an area map on a node's page.
- Define coverage zones for a locations directory.
- Draw multiple polygons for a multi-area entity.
- Show a Google Map with a highlighted region.
- Collect geographic boundaries from non-technical users.
- Map event or venue catchment areas.
- Record no-go / restricted zones visually.
- Attach a drawn map area to a taxonomy term.
- Present property boundaries on real-estate listings.
- Configure the Google Maps API key centrally.
- Try the field via the bundled example page.
- Visualize sales territories per record.
- Edit an existing polygon with map drawing tools.
