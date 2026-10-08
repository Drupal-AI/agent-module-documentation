# GGL Map — manual setup guide

**GGL Map** (`ggl_map`) makes putting a **Google Map** on your site
straightforward — you only need some basic template‑rendering knowledge, not a lot
of custom JavaScript. It ships with a complete set of sensible default settings
that you can override for any particular map, and the *only* thing you must supply
yourself is a **Google Maps API key**.

Maps are rendered through a single render array (the `ggl_map` theme). You give it
a required `#collection` (the marker collection or collections to load) and,
optionally, an `#overrideSettings` array to change any of the defaults — zoom
controls, clustering, whether the map fits itself to the markers, popup behaviour,
and so on. Marker data and popup content come from a collection or a separate JSON
file.

Key features include default or custom markers via one or more collections, popup
content, optional clustering, optional location search and "current location"
(based on the visitor's browser), JavaScript triggers for hooking in your own code
(on map loaded, marker click, popup close, and so on), and AJAX commands for
custom AJAX callbacks. A companion **GGL map examples** module is a good place to
start — after enabling it you can visit its `/ggl_map_examples/single_map` demo.

Two security points are worth keeping in mind: a Google Maps API key should be
**HTTP‑referrer‑restricted to your own domain** so a leaked key can't be abused
and billed elsewhere, and the map loads **Google's third‑party JavaScript** into
your pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and secure your Google Maps API
   key.

## Where it lives in the admin menu

GGL Map's main setting — the **Google Maps API key** — lives on the module's
configuration page (reachable from the module's *Configure* link on **Extend**, or
under **Configuration**). Actual maps are placed by rendering the `ggl_map` theme
from your templates or code, not through an admin form.

## How to use it

1. Get a Google Maps API key and enter it on the configuration page (see
   [Configuration](configuration/index.md)).
2. Optionally enable the **GGL map examples** module and open
   `/ggl_map_examples/single_map` to see a working map and copy its approach.
3. Render a map with the `ggl_map` theme, passing a `#collection` (your markers)
   and, if you want to change any defaults, an `#overrideSettings` array. Marker
   and popup data can come from a collection or a JSON file.
