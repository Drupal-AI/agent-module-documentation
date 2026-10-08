# Geolocation Leaflet Center Node — manual setup guide

**Geolocation Leaflet Center Node** (`geolocation_leafletcenternode`) makes a
**Geolocation Leaflet** map center itself on the **current node's location**. The
classic use case is a "nearby" or "related items" map: you build a View that
shows many locations and place it as a block on a node page — this module ensures
that map opens centered on the node you're actually looking at, rather than on
some arbitrary default center or the average of all the points.

It's a display/mapping convenience that affects presentation only. The locations
shown still come from the View and follow the View's and the entities' access
rules, so the module has no access‑control role of its own. As with any Leaflet
map, tiles are loaded from a third‑party tile provider in the visitor's browser.

It depends on the **Geolocation** (`geolocation`) module and core **Views**
(`views`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no configuration page** for this module. The centering behaviour is
enabled where you configure the Leaflet map in your View — described in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own. Its centering option appears
in the **Views UI**, in the settings of a Geolocation Leaflet (CommonMap) display
that's shown in a node context.

## How to use it

1. Build a **View** of locations that uses a **Geolocation Leaflet / CommonMap**
   display and shows your geolocation‑field points.
2. Configure that View to be placed in a **node context** — typically as a block
   embedded on the node page (so "the current node" is meaningful).
3. In the map display's settings, enable the option this module provides to
   **center the map on the current node's location**.
4. Place the View's block on your node pages. When a visitor opens a node, the map
   loads centered on that node's location while still showing the other points
   from the View.
