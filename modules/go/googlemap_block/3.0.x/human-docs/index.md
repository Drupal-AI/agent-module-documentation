# GoogleMap Blocks — manual setup guide

**GoogleMap Blocks** (`googlemap_block`) lets site builders create Google Maps
blocks and place them anywhere the block system reaches — regions, Layout Builder,
and so on. It is a straightforward way to add a map (an office address, a store
location, directions) to a page without writing any custom code.

You define a location and its map options, and the module renders the resulting
Google Map as a block. Because it uses the Google Maps service, you will need a
**Google Maps API key**, which should be stored as a secret and restricted in the
Google Cloud console so it cannot be abused if it appears in client-side map
requests.

This is a content-display / site-building module — it has no access-control role of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your Google Maps API key, define
   locations, and place the map block.

## Where it lives in the admin menu

- **Settings (API key):** **Structure → Googlemap → Settings**
  (`/admin/structure/gmap-location/settings`).
- **Locations:** **Structure → Googlemap** (`/admin/structure/gmap-location`),
  where you add the locations to show on maps.
- **Block placement:** **Structure → Block Layout** (`/admin/structure/block`).

## How to use it

Add your API key on the settings form, add one or more locations, then place a
GoogleMap block in the region (or layout) where you want the map to appear.
