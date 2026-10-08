<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alimap integrates the Chinese AMap (Gaode, 高德地图) JavaScript map API so coordinate points and polygon shapes can be rendered on maps.

---

The module targets sites that must use AMap rather than Google Maps (the standard mapping provider inside mainland China). It loads AMap's `loader.js` as an external library and exposes a settings form at `/admin/config/services/alimap` where an administrator stores the AMap **API key** and **security (jscode) key** (obtained from https://console.amap.com/dev/key/app). A reusable `AlimapTrait` supplies the shared configuration form building blocks — map dimensions (width/height), map style (zoom 1-18, standard/satellite, and a dozen named colour themes such as dark, light, macaron, blue), and toggleable map controls (toolbar, place search, scale, control bar, geolocation, hawkeye). Per the README the project also provides `alimap_field` (basic coordinate points) and `alimap_polygon_field` (lines, polygons, dashed lines, circles) field types for placing map data on entities.

Operationally the only server-side surface is the admin settings form, gated by the core `administer site configuration` permission. The AMap API key and security key are stored in module configuration and injected into the front-end JS; treat the security (jscode) key as sensitive and scope it to the site domain in the AMap console. No custom routes, callbacks, or web-service endpoints are exposed.

---

- Add an AMap-backed map field to an entity to store coordinate points.
- Use the polygon field to draw lines, polygons, dashed lines and circles on a map.
- Configure the AMap API key at `/admin/config/services/alimap`.
- Configure the AMap security (jscode) key required by the modern AMap loader.
- Set a default map width and height as CSS lengths or percentages.
- Choose a default zoom level (1-18) or automatic fit-to-bounds.
- Switch the base map between standard and satellite imagery.
- Apply a named map theme (dark, light, macaron, blue, wine, etc.).
- Toggle the toolbar control on rendered maps.
- Toggle the place-search control.
- Toggle the scale control.
- Toggle the control bar.
- Enable or disable the geolocation control.
- Enable or disable the hawkeye (overview) control.
- Display store or office locations on a China-focused map.
- Provide an AMap alternative where Google Maps is blocked in mainland China.
- Restrict the AMap security key to the production domain in the AMap console.
- Reuse `AlimapTrait` in custom code to read the configured keys.
- Render read-only location maps in a node's display.