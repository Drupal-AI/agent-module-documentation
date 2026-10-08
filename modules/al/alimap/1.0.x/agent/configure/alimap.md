<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Alimap

1. Obtain an AMap **key** and **security (jscode) key** from https://console.amap.com/dev/key/app (choose a Web-JS-API key).
2. Visit `/admin/config/services/alimap` (requires `administer site configuration`).
3. Enter `alimap_api_key` and `alimap_security_key`. These are read by `AlimapTrait::getAlimapApiKey()` / `getAlimapSecurityKey()` from the `alimap.settings` config object.
4. Optional map defaults exposed through `AlimapTrait`:
   - **Map Dimensions** — width / height as CSS lengths (`100%`, `450px`).
   - **Map Style** — zoom (1-18 or Automatic), map type (standard/satellite), theme (normal, dark, light, whitesmoke, fresh, grey, graffiti, macaron, blue, darkblue, wine).
   - **Map Controls** — toolbar, place search, scale, control bar, geolocation, hawkeye toggles.
5. Add an `alimap_field` or `alimap_polygon_field` to an entity to capture and render map data.

Note: the security (jscode) key is embedded in the page for the AMap JS SDK; restrict it to the production domain in the AMap console so it cannot be reused elsewhere.
