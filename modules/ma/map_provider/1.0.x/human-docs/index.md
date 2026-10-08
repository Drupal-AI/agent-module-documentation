# Map Provider — manual setup guide

**Map Provider** (`map_provider`) is a small developer-facing framework for
managing **map tile providers** as plugins, plus a render element that draws a map
with [Leaflet](https://leafletjs.com/). Its purpose is to let a site define its
base maps — OpenStreetMap, a national mapping agency, a commercial tile service —
in one place, so several mapping features can share the same provider list and the
same credentials instead of each hard-coding its own.

The distinctive part is that providers can be declared in **YAML** rather than
PHP. A plugin manager discovers them (the module ships its own definitions in
`map_provider.map.provider.yml`), which means adding a tile provider is a matter
of writing a config-style file, not a class. Out of the box the module supports
**OpenStreetMap (OSM)**. A render element and the bundled Leaflet library and
JavaScript then draw a map from a chosen provider.

This is infrastructure: enabling the module on its own renders nothing visible.
It has **no routes, no permissions, and no configuration forms** — it exists for
developers to build on. It has no dependencies and supports a wide range of core
versions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — no settings form, no
permissions, and no admin UI. It's a developer building block, described in "How
to use it" below.

## Where it lives in the admin menu

Nowhere — the module adds no admin pages. Providers are declared in YAML files and
the map is drawn through a render element in your own code or templates.

## How to use it

Because Map Provider is developer infrastructure, "using" it means building on its
API rather than clicking through screens:

- **Add a tile provider** by declaring it in a YAML file (following the shape of
  the module's own `map_provider.map.provider.yml`) — no PHP class required.
- **Render a map** by using the module's render element, which loads Leaflet and
  the module's JavaScript to draw the selected provider's tiles.
- **Share one provider list** across every mapping feature on the site, so a tile
  source (and any API key it needs) is defined once, not repeated.

> **Operational note worth passing on:** tile providers come with usage terms.
> OpenStreetMap's public tile servers are explicitly **not** intended for heavy
> production traffic, and commercial providers bill per tile. Choosing a provider
> here is a licensing and cost decision as much as a technical one.
