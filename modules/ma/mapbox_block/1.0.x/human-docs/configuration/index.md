# Configuration

There are two stages: a one-time **settings page** where you tell the module which
Key holds your Mapbox token, and then a **block** you add and configure wherever
you want a map.

## 1. Store the Mapbox token in a Key

Because this module uses the [Key](https://www.drupal.org/project/key) module, the
token doesn't go into module config — it goes into a Key entity, keeping the
secret out of plaintext configuration.

The cleanest approach is to keep the token in an environment variable and have the
Key read it from there. With DDEV:

```bash
ddev dotenv set .ddev/.env --mapbox-access-token=YOUR_PK_TOKEN_HERE
ddev restart
```

Then create a Key that reads the environment variable (**Configuration → System →
Keys**, `/admin/config/system/keys` → *Add key*, using the "Environment" provider
pointed at `MAPBOX_ACCESS_TOKEN`). Keep `.ddev/.env` out of version control. If
you'd rather paste the token directly, you can instead create a Key with the
configuration provider — but the environment-backed approach avoids ever
committing the secret.

### About the token

The Mapbox token here is a **public (`pk.`) token** exposed to the browser — that
is how client-side Mapbox GL renders maps, so it's expected, not a leak. Restrict
and scope it in your Mapbox dashboard (URL restrictions), and remember map loads
are billed against your Mapbox plan. Never use a secret (`sk.`) token here.

## 2. Point the module at the Key

1. Go to **Configuration → Mapbox Block** (`/admin/config/mapbox-block`). You need
   the **Administer mapbox_block** permission.
2. Choose the **Key** that holds your Mapbox token (the setting saved as
   `mapbox_token_name`).
3. Save.

## 3. Add and configure the Mapbox Map block

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
   block** in the region you want.
2. Find and place the **Mapbox Map** block.
3. Configure the block:

   - **Container ID** — a custom DOM id for the map element (useful if you have
     more than one map on a page).
   - **Style** — a built-in Mapbox style (streets, outdoors, satellite,
     navigation, …) or a custom `mapbox://` Studio style URL.
   - **Center** — the initial map **latitude** and **longitude**.
   - **Zoom** — the initial zoom level (roughly 0–16).
   - **Behaviour toggles** — *disable scroll-to-zoom*, *show navigation controls*,
     and *cooperative gestures* (which requires a modifier/two-finger gesture to
     zoom, so the map doesn't hijack page scrolling on touch devices).
   - **Static markers** — add markers in the drag-and-drop table, each with a
     **label** and **latitude/longitude**, reorderable by **weight**. They're
     rendered as a GeoJSON FeatureCollection.

4. Set the block's visibility and region as you would any block, then **Save
   block**.

The map now renders on the page, localised to the current content language. Place
additional Mapbox Map blocks for more, independently-configured maps.
