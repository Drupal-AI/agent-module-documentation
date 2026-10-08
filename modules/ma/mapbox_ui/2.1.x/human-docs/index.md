# MapBox UI — manual setup guide

**MapBox UI** (`mapbox_ui`) lets you put an interactive
[Mapbox GL](https://docs.mapbox.com/mapbox-gl-js/) map on your site as a
**block** — configured entirely from one admin settings form, with no JavaScript
to write. You enter a Mapbox access token, choose a style, set the center
coordinates, drop a marker with popup text, pick a zoom level, and decide whether
to show the navigation controls; then you place the **Mapbox block** wherever you
want the map to appear.

Behind the scenes the block reads your saved settings, hands them to the
front-end, loads Mapbox GL JS/CSS from the Mapbox CDN plus the module's own
script, and renders the map. It's a quick way to show an office location, a
contact-page map, or a footer map without any custom code.

The Mapbox access token is a **public, client-side token** (`pk.…`) that is
exposed in the page's JavaScript by design — that's how Mapbox GL works in the
browser, so it's expected, not a leaked secret. Use a URL-restricted public token,
never a secret (`sk.`) token.

Two rough edges are worth knowing before you start: the **navigation-control
toggle** is saved under a mis-keyed config name in this version, so that checkbox
may not persist as expected; and the module's README lists an outdated config path
(`/admin/config/mapbox/config`) — the **real** route is
`/admin/config/mapbox_ui/config`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter the token and map options, then
   place the Mapbox block.

## Where it lives in the admin menu

The settings form is at `/admin/config/mapbox_ui/config` (gated by the
**Administer site configuration** permission). The map is placed from **Structure
→ Block layout** (`/admin/structure/block`), where you add the **Mapbox block**.
The block itself is visible to anyone with **Access content**.

## How to use it

1. Create a Mapbox public token and pick a style.
2. Enter the token, style, center, marker, popup, and zoom on the settings form.
3. Place the **Mapbox block** in a region via Block layout.
