# Mapkit Google Maps — manual setup guide

**Mapkit Google Maps** (`mapkit_gmap`) is the Google Maps provider for the
[Mapkit](https://www.drupal.org/project/mapkit) framework. On its own Mapkit
renders no maps; this module plugs in Google Maps as the concrete provider — a
map renderer, a symbol marker plugin, and Google **Places** autocomplete — and
loads the Google Maps JavaScript API using an API key you configure.

You enter a Google Maps JS API key, optionally a region code to bias results, and
select which optional Google JS libraries to load (Drawing, Geometry, Places,
Visualization). The module builds the Google Maps loader URL from those settings
and attaches it as a deferred external script; saving the form clears the asset
library cache so the new URL takes effect immediately. Enable **Places** if you
want address/location autocomplete in Mapkit's location inputs.

The Google Maps **JavaScript API key is a client-side key** — it's emitted into
the rendered page so the browser can load Google Maps. That's by design, so it
must be an **HTTP-referrer-restricted browser key** (restricted in the Google
Cloud console), never a server/secret key. The settings form is gated by
Mapkit's **Administer mapkit providers** permission. It requires both **Mapkit**
and [Toolshed](https://www.drupal.org/project/toolshed).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with Mapkit).
2. [Configuration](configuration/index.md) — enter the API key, pick a region,
   and choose which Google libraries to load.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Mapkit → Providers →
Google Maps** (`/admin/config/services/mapkit/providers/gmap`, route
`mapkit_gmap.settings`), reached from Mapkit's provider listing and gated by the
**Administer mapkit providers** permission.

## How to use it

1. Enable Mapkit and this module.
2. Obtain a Google Maps JavaScript API key and enter it on the settings form.
3. Select the **Places** library if you need autocomplete (and any others you
   need), then save.
4. Google Maps is now the provider Mapkit uses — render a Mapkit map field or
   build a Mapkit Views display, and use Google Places for location autocomplete.
