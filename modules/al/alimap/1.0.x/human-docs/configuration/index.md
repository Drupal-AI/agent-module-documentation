# Configuration

Before Alimap can draw a map it needs your AMap keys. You set those, along with
the default look of your maps, on the settings form.

## Get your AMap keys

1. Sign in at the AMap console: <https://console.amap.com/dev/key/app>.
2. Create a **Web (JS API)** key. AMap gives you two values:
   - the **API key** (`alimap_api_key`), and
   - the **security key** / **jscode** (`alimap_security_key`), which the modern
     AMap loader requires.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Alimap**, or navigate directly to
   `/admin/config/services/alimap`.

## Enter the keys and defaults

Fill in the **API key** and **security key** fields, then set the map defaults:

- **Map dimensions** — width and height as CSS lengths, e.g. `100%` or `450px`.
- **Map style** — the zoom level (1–18, or Automatic to fit the data), the map
  type (standard or satellite), and a colour theme (normal, dark, light,
  whitesmoke, fresh, grey, graffiti, macaron, blue, darkblue, wine).
- **Map controls** — toggle the toolbar, place search, scale, control bar,
  geolocation, and hawkeye (overview) controls on rendered maps.

Save the form.

## Add a map field to your content

To store and display map data on entities, add one of the module's field types on
**Manage fields** for a content type (or other entity):

- **`alimap_field`** — basic coordinate points.
- **`alimap_polygon_field`** — lines, polygons, dashed lines, and circles.

## Keep the security key safe

The AMap **security (jscode) key** is embedded in the page so AMap's JavaScript
can run in the browser. In the AMap console, restrict that key to your production
domain so it cannot be reused on another site.
