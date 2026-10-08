<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenStreetMap Views Integration (openstreetmap_views) — agent index

Submodule of **openstreetmap**. **Dependency-only shim** — its entire codebase is
`openstreetmap_views.info.yml`; it ships no PHP, config, schema, templates, plugins, permissions,
routes, or services. Its sole effect is declaring dependencies on **`openstreetmap`** and
**`leaflet`**, so enabling it guarantees the Leaflet mapping stack is present to display the
parent's `osm_node` `geodata` Geofield through Views. Core `^8.7.7 || ^9 || ^10`. License
GPL-2.0-or-later. Version dir `1.x` (installed 1.0.4).

- **How to map OSM Nodes with it** → [views/integration.md](views/integration.md)

## What it actually is (from source)

- Files on disk: only `openstreetmap_views.info.yml`
  (`name: OpenStreetMap Views Integration`, `description: Tools`,
  `dependencies: [openstreetmap, leaflet]`).
- No `*.module`, `src/`, `config/`, `*.routing.yml`, `*.services.yml`, `*.permissions.yml`,
  `*.libraries.yml`, or Views plugins/handlers. Nothing to configure.
- All mapping is delivered by the **`leaflet`** contrib module and core **Views**; this submodule
  only pins that dependency. There is no bespoke Views data/handler code here (the parent supplies
  `osm_node` Views data via `OSMNodeViewsData`).
