# Configuration

Setting up OpenStreetMap has three parts: tell it which Overpass endpoint to talk
to, define the node type(s) your features are stored in, and then bring features
in — either one at a time or in bulk with an Overpass query.

## 1. Set the Overpass interpreter URL

1. Go to **Configuration → OSM Settings** (`/admin/config/osm`).
2. Enter an **Overpass interpreter URL** — a public or self-hosted Overpass API
   endpoint. A list of public endpoints is on the
   [Overpass API wiki](https://wiki.openstreetmap.org/wiki/Overpass_API). Because
   these are shared public services with usage policies, be considerate about how
   many queries you run.
3. Save.

## 2. Create an OSM Node Type

An "OSM node type" is the entity bundle your imported features are saved into.

1. Go to **Structure → OSM Node Type** and **Add OSM Node type** — for example a
   type called *Business* or *Bus Stop*.
2. Add fields for the OSM tags you care about. The field name should match the OSM
   tag, with or without the `field_` prefix: a field named `field_bus` will be
   filled from an OSM feature's `bus` tag, so an OSM node tagged `bus=yes` gives
   your Drupal field the value `yes`. A Geofield (the Geodata field) stores the
   location.

## 3a. Add features one at a time

For a small number of locations:

1. Go to **Content → OSM Node List** and **Add OSM Node**.
2. Enter the **OSM node ID** (obtained from
   [openstreetmap.org](https://www.openstreetmap.org/) using the online editor).
   To sync a *way* rather than a node, tick the **Is way** box.
3. **Save.** On save, the module fetches all matching tags and fills your fields.

## 3b. Import features in bulk with Overpass queries

This needs the **OpenStreetMap Query Tools** submodule
(`openstreetmap_queries`).

1. Go to **Structure → Overpass Queries → Add Query**
   (`/admin/structure/osm_query/add`).
2. Give the query a **title** (for example *All Bus Stops in Atlanta*).
3. Fill out the **query body** in Overpass syntax. You can develop and test
   queries at [overpass-turbo.eu](https://overpass-turbo.eu/) before pasting them
   in.
4. Choose the **bundle** (OSM node type) that matching features should be saved
   into.
5. **Save** the query.
6. Open the query's **Execute** tab to preview how many features it will import,
   then run it there — this starts a batch operation — or run it later from
   **Content → OSM Node List → Sync All** (`/admin/content/osm_node/sync`).

You can also run a one-off import from **Content → Import OSM Nodes**
(`/admin/content/osm_node/import`).

## 4. Keep features in sync

Re-running a query, or using **Sync All** on the OSM Node List, re-fetches the
current tag values from OpenStreetMap. Because this data is external and
user-editable on OSM, sanity-check imported values before depending on them for
anything important.

## Displaying features on a map

OpenStreetMap syncs data but does not render maps. To show your features, install
a mapping module such as [Leaflet](https://www.drupal.org/project/leaflet), enable
its Leaflet Views submodule, create a View of your OSM node type, add the Geodata
field, and set the Leaflet view type to read location from that field.
