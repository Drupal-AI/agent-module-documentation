# Geolocation — manual setup guide

**Geolocation** (`geolocation`) is Drupal's standard toolkit for storing and
displaying location data. At its heart is a simple `geolocation` field type that
holds a latitude/longitude pair, which you can add to any content type or other
entity. Editors set the value by typing coordinates, dropping a pin on an
interactive map, or geocoding a typed address into coordinates on save, and you
can display it as a raw pair of numbers, degrees/minutes/seconds, token-driven
text, or a live map. It depends only on core's **Field** module.

Its real power is a large plugin framework layered on top of that field. Map
providers (Google Maps, Leaflet, HERE, Baidu, Yandex) render the maps; map
features add markers, clustering, popups, controls, and custom tile layers;
geocoders turn addresses into coordinates; and map-center strategies decide how a
map frames its results. On top of that sits deep **Views** integration — a
CommonMap style plots a whole view of entities as markers, and proximity fields,
filters, sorts, and arguments let you build "stores near me" radius searches.

Because those map providers and integrations are large and often region-specific,
they ship as **submodules** that you enable only as needed — for example
`geolocation_google_maps` (needs an API key), `geolocation_leaflet` (open tiles,
no key), plus `geolocation_here`, `geolocation_baidu`, `geolocation_yandex`,
address/geofield/GPX/Search API integrations, and a `geolocation_demo` with
example views. The base module gives you the field and the plugin framework, but
to actually render a map you must enable at least one map-provider submodule and
configure your field's widget and display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the map-provider and integration submodules you need.
2. [Configuration](configuration/index.md) — add a geolocation field, set up its
   map widget and formatter, and build proximity/map views.

## Where it lives in the admin menu

Geolocation has **no single settings page**. You configure it in the places you
already manage content:

- **Structure → Content types → *(your type)* → Manage fields** — add the
  `geolocation` field (`/admin/structure/types/manage/<bundle>/fields`).
- **Manage form display** — choose the editing widget (Lat/Lng or Map).
- **Manage display** — choose the formatter (Map, Lat/Lng, Sexagesimal, Token,
  Image EXIF Map).
- **Views** — pick the *Geolocation CommonMap* format and add proximity
  filters/sorts.

Map-provider submodules add their own settings pages — most notably the Google
Maps API key at `geolocation_google_maps.settings`. See
[Configuration](configuration/index.md) for the full walkthrough.
