# Leaflet Layers — manual setup guide

**Leaflet Layers** (`leaflet_layers`) lets you administer Leaflet map layers
through the Drupal UI and combine them into reusable **map bundles** that any
Leaflet map can select. Normally, the base maps and overlays a Leaflet map can use
come hard‑coded from whichever modules provide them. Leaflet Layers turns that into
something editors and site builders can manage: you define your own custom tile or
WMS layers, and you mix them together with layers other modules expose into a
single named bundle.

It adds two configuration entities under **Structure → Leaflet Layers**. A **Map
layer** describes one custom layer — an OpenStreetMap‑style tile source (a URL
template with `{x}/{y}/{z}`) or a WMS layer from GeoServer/MapServer — with all the
Leaflet options you would expect (zoom range, opacity, subdomains, attribution, TMS,
retina detection, and so on). A **Map bundle** groups layers together: it lists
every layer available on the site (both those from other Leaflet‑provider modules
and your own Map layers), lets you enable, reorder, relabel, and mark each as a base
layer or overlay, and choose which overlays are on by default. A bundle also carries
a set of Leaflet behavior toggles — dragging, zoom controls, animations, the layer
switcher, and more.

Once you save a bundle, it automatically becomes a selectable map wherever the
**Leaflet** module offers a map option (its field formatters and Views), because
Leaflet Layers implements Leaflet's `hook_leaflet_map_info()` for you and merges the
referenced layers, ordering base layers before overlays. Custom layer types are
built from **LayerType** plugins (`tilelayer` and `wms` ship in the box), and
developers can add their own.

There is no global settings page and no module‑specific permission — the config
entities are gated by core's **Administer site configuration**, and the overview
page by **Access administration pages**. Leaflet Layers requires the contributed
**Leaflet** module and works on Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Leaflet
   dependency with Composer, then enable it.
2. [Configuration](configuration/index.md) — creating Map layers and Map bundles,
   field by field.

## Where it lives in the admin menu

Everything is under **Structure → Leaflet Layers**
(`/admin/structure/leaflet_layers`): an overview page, a **Map layer** collection
for your custom layers, and a **Map bundle** collection for grouping layers into
selectable maps.

## How to use it

1. (Optional) Create one or more **Map layers** for any custom tile or WMS sources
   you need.
2. Create a **Map bundle**, enable the layers you want (yours plus any from other
   modules), set each as base or overlay, order them, and toggle the map behaviors.
3. On a Leaflet map formatter or Views Leaflet display, select your bundle as the
   map. That's it — the bundle's layers and behaviors are used.

See [Configuration](configuration/index.md) for the full field‑by‑field walkthrough.
