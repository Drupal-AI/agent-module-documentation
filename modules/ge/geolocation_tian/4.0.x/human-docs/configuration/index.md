# Configuration

Configuring Tian Maps is a two‑part job: first store your Tianditu App ID on the
module's settings form, then choose Tian Maps as the map provider on each field or
View where you want a map. Both parts require the Geolocation module's **configure
geolocation** permission.

## Before you start

- Make sure **Geolocation** and **Geolocation - Tian Maps** are enabled.
- Have a **Tianditu App ID** ready — get one free from the Tianditu console at
  <https://console.tianditu.gov.cn/api/key>.

## Step 1 — set the Tianditu App ID

1. Go to **Configuration → Web services → Tian Maps settings**, or navigate
   directly to `/admin/config/services/geolocation/tian_maps` (config route
   `geolocation_tian.settings`).
2. In the **Tian Maps App ID** field, enter your Tianditu key.
3. Save. The value is stored in the module's configuration
   (`geolocation_tian.settings`, key `key`).

If you prefer the command line, the same value can be set with Drush:

```bash
drush config:set geolocation_tian.settings key <APP_ID> -y
```

The status report at `/admin/reports/status` warns whenever this key is empty, so
that's a quick way to confirm it's set.

### About the App ID — it's a public, client‑side key

The Tianditu App ID is **not a server secret**. By design it is embedded in the
Tianditu JavaScript URL that the module attaches to the page, so it is visible to
anyone who views the page source. There's no point trying to hide it, and it is
not handled as a Drupal Key entity. Instead, protect it the way client‑side map
keys are meant to be protected: **restrict it by referrer/domain in the Tianditu
console** so it only works when requested from your own site.

## Step 2 — use Tian Maps as your map provider

On any Geolocation field formatter, or on a Geolocation Views map style/format,
choose **Tian Maps** as the map provider. That display then offers the
Tian‑specific per‑map options:

- **Zoom level** — the default zoom, selectable from **3 to 19** (default 10).
- **Height / Width** — the map's size, in pixels or a percentage (for example
  `400px` or `100%`).
- **Navigation / zoom control** — enable the zoom control (on by default) and
  choose its position: top‑left, top‑right, bottom‑left, or bottom‑right.
- **Marker info window** — enable the info‑window layer feature to show a popup on
  markers.

Save the field or View. Your map now renders with Tianditu tiles.

## A typical end‑to‑end setup

1. Add a **geolocation field** to a content type (for example a node type) and
   enter locations on your content.
2. Build a **View** using a **Geolocation CommonMap** display.
3. In that display's settings, choose the geolocation field as the source and set
   **Map provider** to **Tian Maps**.
4. Adjust the zoom, size, and controls as above, and save.

For deeper Geolocation Views setup, see the Geolocation module's own "how to
create a view of locations on a CommonMap" documentation.

## Uninstalling

Uninstalling the module deletes its `geolocation_tian.settings` configuration, so
your stored App ID is removed cleanly.
