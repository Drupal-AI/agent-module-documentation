# Entity Collector — manual setup guide

**Entity Collector** (`entity_collector`) lets users gather entities into named
**collections** — think curated lists or bookmarks — and switch between an active
collection as they browse. A collection is a real content entity (the
`entity_collection` type), so collections can be published/unpublished, revisioned,
and shared with other users as *participants*.

The heart of the module is the idea of an **entity collection type**. You create one
for the kind of entity you want to gather (for example a "Media" collection type),
and the module automatically generates two extra display fields on the target
entity — an **add** field and a **remove** field (provided via the Extra Field
module) — so editors can add or remove items to/from their active collection right
from the interface. Adding and removing happen through AJAX endpoints (with a no-JS
fallback), and each collection is locked during a change to avoid race conditions.

On every page, a **Collection Bar** block shows the active collection. Its block
settings let you choose which collection type it displays and which view mode renders
the entities in it. From the bar, users can also switch between existing collections
or create a new one through a modal. Access to every add/remove/switch action is
enforced against the collection's own access rules, and the module ships a full set of
permissions (view/add/edit/delete published and unpublished collections, plus
revision grants). It requires **Drupal 8.8, 9, or 10**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the collection permissions.
2. [Configuration](configuration/index.md) — create collection types, place the
   Collection Bar block, and set up the display fields.

## Where it lives in the admin menu

- **Collection types:** **Structure → Collection types**
  (`/admin/structure/collection-types`) — create and manage the types of collection
  your site offers.
- **Collection Bar block:** the block settings at
  `/admin/structure/block/manage/entitycollectionblock` — choose the collection type
  and view mode the bar shows.
