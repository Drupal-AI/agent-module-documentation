# Entity Block — manual setup guide

**Entity Block** (`entity_block`) lets you render any content entity — a node,
media item, custom block, taxonomy term, user, and so on — as a **block**, in a
view mode you choose, and place it wherever blocks go. That means one piece of
content (a call-to-action node, a legal disclaimer, a featured article teaser)
can be reused across many pages without duplicating it.

When you enable the module it adds one block type per content entity type that
has a view builder. Placing one gives you an autocomplete field to pick the
exact entity to show and a dropdown of that entity type's view modes. On save
the block stores just the entity ID and the view mode, then renders the entity
through its normal display — so it always reflects the source content. The block
automatically respects the entity's view permissions (viewers who can't see the
entity don't see the block) and merges the entity's cache information, so the
block updates whenever the underlying content changes.

There is **no settings form, no permissions, and no submodules** — everything is
done by placing blocks, either in the core **Block layout** UI or inside
**Layout Builder**. Placed blocks are configuration, so they export and deploy
with the rest of your config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no separate configuration page — the module has no settings form. See
**How to use it** below for placing a block.

## Where it lives in the admin menu

Entity Block adds no menu item or settings page of its own. You use it wherever
you already place blocks:

- **Structure → Block layout** (`/admin/structure/block`), or
- a **Layout Builder** section on an entity's layout.

In the block picker, the new blocks appear under the **Entity Block** category,
one per entity type (labelled with the entity type's name).

## How to use it

1. Create the entity you want to show (a node, media item, custom block, etc.).
2. Go to **Block layout** or open a **Layout Builder** section and choose to add
   a block.
3. In the picker, under the **Entity Block** category, pick the block for the
   **entity type** you want (for example the one for nodes).
4. Fill in the block form:
   - **Entity** — start typing to find and select the specific entity to render.
     This field is required.
   - **View mode** — choose which view mode the entity renders in (for example
     *Teaser* or *Full content*). Defaults to *Default*.
   - **Display title** — off by default. When off, the block's title is generated
     automatically from the entity's label. Turn it on to type your own title.
5. Save. To show a different entity later, just edit the block and change the
   autocomplete value.

If the optional **Canvas** module is installed, the view-mode dropdown groups the
modes so those with a Canvas template are listed first (marked "Canvas
enabled").
