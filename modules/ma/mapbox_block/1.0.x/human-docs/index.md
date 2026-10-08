# Mapbox Block — manual setup guide

**Mapbox Block** (`mapbox_block`) gives you a configurable Drupal **block** that
renders an interactive [Mapbox GL JS](https://docs.mapbox.com/mapbox-gl-js/) map.
Each block instance is set up in its own block form: you pick a map style, set the
center and zoom, toggle behaviour options, and add a set of draggable static
markers. Drop the block into a region and the map appears there — place several,
each configured independently, and you get multiple maps on a page.

Per block you can choose a built-in Mapbox style (streets, outdoors, satellite,
navigation, and so on) or point at a custom `mapbox://` Studio style; set the
center latitude/longitude and zoom; and switch on options like disabling
scroll-to-zoom, showing navigation controls, and cooperative gestures for touch
devices. Markers are managed in a drag-and-drop table (label plus latitude and
longitude, reorderable by weight) and emitted as GeoJSON.

Crucially, the Mapbox access token is **not** stored in block config. The module
depends on the [Key](https://www.drupal.org/project/key) module and looks the
token up by the Key name saved in its settings — so the secret lives in a Key
entity, not in plaintext configuration. The token itself is a Mapbox public
(`pk.`) token exposed to the browser, which is how client-side Mapbox GL works;
scope and restrict it in your Mapbox dashboard. This module requires **Mapbox GL
JS v2** and does not work with older versions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the Key module).
2. [Configuration](configuration/index.md) — store the token in a Key, point the
   module at it, then add and configure the Mapbox Map block.

## Where it lives in the admin menu

The module's token setting lives at **Configuration → Mapbox Block**
(`/admin/config/mapbox-block`), gated by the **Administer mapbox_block**
permission. The map itself is placed and configured from **Structure → Block
layout** (`/admin/structure/block`), where you add the **Mapbox Map** block.

## How to use it

1. Store your Mapbox public token in a **Key** entity.
2. On the settings page, select that Key.
3. Add the **Mapbox Map** block to a region and configure its style, center,
   zoom, behaviour, and markers.
4. Save — the map renders on the page.
