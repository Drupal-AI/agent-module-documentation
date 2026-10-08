# Configuration

Setting up Entity Collector has three parts: create a **collection type** for the
entities you want to gather, arrange the **add/remove display fields** it generates,
and place the **Collection Bar** block so users can see and switch their active
collection.

## 1. Create a collection type

1. Log in as a user with **Administer entity collection entities**.
2. Go to **Structure → Collection types** (`/admin/structure/collection-types`) and
   add a collection type.
3. Choose the entity type this collection gathers (for example Media, or nodes).

When you create the collection type, the module automatically generates a field on
the target entity for that type — and exposes two display fields, **add** and
**remove**, that let users put an entity into, or take it out of, their active
collection.

## 2. Arrange the add/remove fields on a view mode

The add and remove fields appear on the target entity's display. A common pattern is
to build a dedicated view mode — for example a thumbnail plus the **add** and
**remove** fields — and then use that view mode in a listing (a View) of the
entities. That gives users a browsable list where each item has its own add/remove
controls for managing their collection.

## 3. Place the Collection Bar block

The Collection Bar shows the user's active collection on each page and is where they
switch collections or create a new one.

1. Go to the block layout and place the **Entity collection** block in a region, or
   open its settings directly at
   `/admin/structure/block/manage/entitycollectionblock`.
2. In the block settings choose:
   - **Entity collection type** — which collection type the bar displays.
   - **Entity collection view mode** — which view mode is used to render the entities
     inside the bar.
3. Save the block.

From the bar, users can switch between their existing collections (handled by an AJAX
request that swaps the bar's contents) or create a new collection (a normal form
submission that reloads the page with the new collection active).

## Sharing collections

A collection can be shared with other users by adding them as **participants** on the
collection entity. Participants can also remove themselves from a collection.

## Save

Save your collection type, the entity display/view mode, and the block. Users with
the appropriate permissions can then start gathering entities into collections
immediately.
