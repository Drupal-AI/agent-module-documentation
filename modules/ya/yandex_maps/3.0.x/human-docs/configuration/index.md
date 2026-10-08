# Configuration

Yandex.Maps is configured in two places: a **global settings page** (the API key
and site‑wide defaults) and the **per‑display settings** on each geofield widget,
formatter, and View.

## Global settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Yandex.Maps**, or navigate directly to
   `/admin/config/system/yandex-maps`.

The form has four fields:

- **API key** — your Yandex.Maps API key. This is required for any map to load. It
  is a public browser‑side key (it appears in the page's JavaScript), so it is not a
  server secret, but you should still restrict it to your domain in the Yandex
  console.
- **Presets file path** — an optional path (relative to the site root) to a
  JavaScript file that defines reusable marker "presets" (custom icons/styles). The
  module ships an example you can copy, e.g.
  `modules/contrib/yandex_maps/js/yandex-maps-presets.example.js`.
- **Default objects preset** — the default marker style applied to map objects when
  nothing more specific is set, e.g. `islands#blueDotIcon`.
- **Debug mode** — loads the unpacked, uncompressed Yandex API for troubleshooting.
  Leave this off in production.

Saving the form rebuilds the map JavaScript library and clears caches, so your new
key/presets take effect immediately.

> **Note on locale.** The Yandex API is loaded with the language set to Russian
> (`ru_RU`) and a longitude‑latitude coordinate order, both hard‑coded into the
> library build. If you need a different locale or coordinate order, that requires
> altering the library in custom code.

## Geofield widget (editing geometry)

On a content type's **Manage form display**, set your geofield's widget to the
Yandex map widget. Its options let editors draw geometry on a map:

- **Map type** — `map` (roadmap), `satellite`, `hybrid`, `publicMap`, or
  `publicMapHybrid`.
- **Map centre** and **Map zoom** — where the map opens (leave centre blank to
  auto‑centre on existing geometry). Zoom ranges roughly 1–16.
- **Auto‑centering / Auto‑zooming** — fit the view to the drawn objects.
- **Controls** — which Yandex controls (search, zoom, fullscreen, …) appear; a
  special "none" value hides them all.
- **Object types** — which geometry the editor may add: point, line, and/or polygon.
- **Selected control** — which drawing tool is active first.
- **Object preset** — the marker style to use for drawn points.

The widget stores whatever the editor draws back into the geofield as WKT.

## Geofield formatter (displaying geometry)

On **Manage display**, set the geofield's formatter to the Yandex map formatter. It
shares most of the same options (map type, centre, zoom, auto‑centre/zoom, controls,
behaviours, object preset) plus:

- **Hide when empty** — render nothing if the field has no geometry.
- **Hint content** and **Balloon content** — text shown as a marker tooltip and in
  the pop‑up balloon when a marker is clicked. Both support **tokens**, so you can
  pull in values from the entity being displayed (e.g. the title or an address
  field).

## Views map style

To plot many entities on one map, build a View, add the geofield you want to plot,
then set the View's **Format** to the **Yandex map** style. Its settings let you map
each row's data onto the map:

- **Geofield field** — the field whose geometry provides each marker's position.
- **Id / Hint / Icon / Cluster caption / Preset fields** — Views fields that supply
  each marker's identifier, tooltip, icon, cluster label, and marker style.
- **Show balloon** — render the whole Views row as the balloon shown when a marker
  is clicked.
- **Clusterize** — group nearby markers into clusters when there are many.
- **Save state**, **Hide when empty**, **Map type**, **Centre**, **Zoom**,
  **auto‑centre/zoom**, **Controls**, **Behaviours**, **Object preset** — the same
  map controls as above.
- **Additional object options** — extra Yandex GeoObject options as JSON (custom
  icon layout, image href/size/offset, and so on).
