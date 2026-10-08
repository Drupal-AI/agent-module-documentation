# Configuration

Application Tiles has **no dedicated settings form of its own**. Instead, its tile
images and colours are configured inside your **theme's settings** form
(`system.theme_settings`), and the module reads them from there to build the tile
metadata for that theme.

## Where to set the tiles

1. Go to **Appearance** (`/admin/appearance`).
2. Click **Settings** for the theme you want to configure (each theme has its own
   settings, so you can give different themes different tiles).
3. In the theme settings form, set the tile **images** (point them at
   appropriately sized **square** icons) and the tile **colour(s)** that the module
   exposes.
4. Save the theme settings.

## Apply your changes

The module caches the generated tile markup, so after changing the theme settings
you should **clear caches** for the new tiles to be regenerated:

```bash
drush cr
```

(Or use the cache-clear option in the admin UI.)

## What the module then does

From those settings the `AppTilesManager` service:

- produces a **`browserconfig.xml`** from the module's bundled template plus your
  values;
- emits the appropriate **`<meta name="msapplication-*">`** tags and icon links in
  the page head;
- caches the result and **skips generation on admin routes**, so it only runs where
  it is needed.

## Verify it

Because tiles are a per-theme feature, test the pinned tile in a browser that
supports Windows tiles (and check touch icons on a mobile device) to confirm your
artwork appears correctly. Application Tiles complements a full PWA/manifest setup
rather than replacing it, so keep any separate web-app-manifest configuration in
place as well.
