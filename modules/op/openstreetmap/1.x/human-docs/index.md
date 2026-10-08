# OpenStreetMap — manual setup guide

**OpenStreetMap** (`openstreetmap`) keeps Drupal content in sync with data from
[OpenStreetMap](https://www.openstreetmap.org/) (OSM). Instead of retyping the
details of real-world features — shops, bus stops, points of interest, boundaries
— you point Drupal at the corresponding OSM nodes and ways, and the module pulls in
their data. By default it stores each feature's OSM ID and name, but any field you
add to your OSM node type that matches an OSM tag is populated automatically: give
a node type a `field_wheelchair` field, for example, and an OSM feature tagged
`wheelchair=yes` will arrive with that value filled in.

You have two ways to bring features in. For a handful of locations you can **add
them individually** by their OSM ID (found on openstreetmap.org). For groups of
features you write **Overpass queries** — using the Overpass query language — that
match, say, "all bus stops in Atlanta," and the module imports every matching
feature into the OSM node type you choose. Overpass queries are provided by the
**OpenStreetMap Query Tools** submodule.

The module talks to OSM's public APIs and an **Overpass interpreter** endpoint that
you supply. Reads generally need no credentials, but OSM's APIs have usage
policies, so be a good citizen about rate-limiting. And because you are importing
external data that becomes content on your site, validate what comes back before
relying on it. OpenStreetMap does not draw the maps itself — to place synced
features on a map, pair it with a mapping module such as
[Leaflet](https://www.drupal.org/project/leaflet) and its Leaflet Views submodule,
reading from the Geodata field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose which submodules you need.
2. [Configuration](configuration/index.md) — set the Overpass interpreter URL,
   create OSM node types, and import features.

## Where it lives in the admin menu

- **Configuration → OSM Settings** (`/admin/config/osm`) — enter the Overpass
  interpreter URL.
- **Structure → OSM Node Type** — define the entity types your OSM features are
  saved into, and add fields that match OSM tags.
- **Content → OSM Node List** (`/admin/content/osm_node`) — add, sync, and import
  individual OSM features; **Sync All** re-syncs everything.
- **Structure → Overpass Queries** (`/admin/structure/osm_query/add`) — create and
  run Overpass queries (requires the Query Tools submodule).
