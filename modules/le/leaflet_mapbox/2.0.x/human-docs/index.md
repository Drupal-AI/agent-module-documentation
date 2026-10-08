# Leaflet Mapbox — manual setup guide

**Leaflet Mapbox** (`leaflet_mapbox`) lets Drupal's Leaflet maps use **Mapbox**
tile layers instead of the default tiles. Leaflet itself is just the mapping
library and does not care where its tiles come from; out of the box it usually
falls back to OpenStreetMap's public tile servers, which are free but explicitly
**not intended for production traffic**. Mapbox is one of the standard answers:
commercial tiles with custom styling, so your map can match your site's design —
a branded basemap, satellite imagery, a dark‑mode style — rather than looking
like plain OpenStreetMap.

The module supplies the integration and depends only on the **Leaflet** module.
You define a Mapbox map (a label, an API version, a Style URL from Mapbox, and an
access token), and it then becomes selectable when you build Leaflet maps in
Views and field formatters.

Two things belong in any decision to use Mapbox, and neither is technical:

- **Cost.** Mapbox is **billed per map load** above a free tier, so a map on a
  high‑traffic page is a running cost. Understand it before launch, not when the
  invoice arrives.
- **The access token is a credential.** Mapbox tokens are public by necessity —
  the browser uses them — which is exactly why they should be **scoped with URL
  restrictions** at Mapbox. An unrestricted token found in your page source can be
  used by anyone, on your account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Leaflet dependency.
2. [Configuration](configuration/index.md) — define a Mapbox style with its Style
   URL and access token, and handle the token safely.

## Where it lives in the admin menu

Once enabled, configure your Mapbox maps at **Configuration → Web Services →
Leaflet MapBox**. From there you add a labelled map style pointing at your Mapbox
Style URL and access token; it then appears as an option when you create Leaflet
Views and formatters.
