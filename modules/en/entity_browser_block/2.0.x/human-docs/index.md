# Entity Browser Block — manual setup guide

**Entity Browser Block** (`entity_browser_block`) turns every Entity Browser on
your site into a placeable block. You pick one or more entities through that
browser's familiar UI, choose a view mode for each one, and the block renders
them wherever blocks go — theme regions, Layout Builder, or Panels. It's the
no-code way to build a curated, hand-picked content block without writing a View
or a query.

The module works by deriving one block for each Entity Browser you've configured:
the block plugin is `entity_browser_block:{browser_machine_name}`, and it's
labelled with that browser's name. When you place the block, its configuration
form embeds the matching Entity Browser so you select entities exactly the way
that browser is set up to — an inline widget, a modal, an iframe, whatever it
uses. A drag-sortable table then lets you order the chosen entities and pick a
**view mode** for each (teaser, full, or a custom mode) independently.

At render time the block loads each selected entity and renders it through its
normal view builder in the stored view mode. It respects per-entity **view**
access (so restricted content is hidden automatically), merges each entity's
cache metadata so the block stays in sync with its sources, and includes a
recursive-render guard so an entity can't embed itself endlessly. Placed blocks
are configuration and declare dependencies on the referenced entities, their
view-mode displays, and the browser, so they export and deploy cleanly.

There's **no admin settings form, no permissions, no services, and no
submodules**. The one prerequisite is that at least one Entity Browser must exist
first, because the blocks are derived from your browsers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (Entity Browser
   is required) and enable the module.

## Where it lives in the admin menu

There's no settings page. The blocks appear in the normal block-placement UI:
**Structure → Block layout → Place block** (`/admin/structure/block`), and in the
"Add block" chooser inside **Layout Builder** or Panels. Each Entity Browser you
have shows up there as its own block.

## How to use it

Make sure you have at least one Entity Browser configured first (under
**Configuration → Content authoring → Entity browsers**).

1. Install and enable the module and Entity Browser (see
   [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (or the Layout Builder / Panels "Add
   block" chooser) and place the block named after your Entity Browser.
3. In the block's configuration form, use the embedded Entity Browser to select
   one or more entities.
4. In the drag-sortable table, order the entities and choose a **view mode** for
   each — for example show a featured node in `full` and the rest as `teaser`.
   Use a row's **Remove** button to drop an entity.
5. Save. The block now renders your curated entities in the region or layout
   where you placed it.

To change what's shown later, edit the block and re-select in the browser. To
show the same reusable entity in several places, place several blocks.
