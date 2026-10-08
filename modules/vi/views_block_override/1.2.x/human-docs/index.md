# Views Block Override — manual setup guide

**Views Block Override** (`views_block_override`) adds a new kind of Views
display — **"Block with overrides"** — that lets each *placed* block instance
change how the view runs, right from the block's own settings form. Normally a
view's contextual filters, sort, pager, and "more" link are fixed on the view
itself, so reusing one view with different arguments means cloning displays.
With this module you build the view once and let each block placement supply its
own values.

On the display you decide (via *Allow settings*) which overrides to expose:
contextual filters (arguments), the exposed sort field and direction, the pager
ID, and the "more" link text and URL. Whatever you allow then appears as editable
fields in the block configuration form whenever that block is placed — through
Block Layout, Layout Builder, or the Block Field module. Contextual filters even
render smart widgets: an entity autocomplete when the argument validates against
an entity type, or radios/checkboxes when it validates against a bundle.

This makes one view reusable across many blocks — a "related content" block whose
term argument is chosen per placement, the same listing filtered by different
categories in different regions, or repeated Layout Builder placements each with
their own arguments. It depends only on core **Views** and adds no permissions,
routes, or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module adds no settings page. You work with it in the **Views UI**
(*Structure → Views*) when adding a display, and then in the **block
configuration form** wherever you place the resulting block (Block Layout,
Layout Builder, or a Block Field).

## How to use it

1. Edit a view at *Structure → Views* and click **Add** to create a new display,
   choosing **Block with overrides** (it behaves like a normal Block display but
   exposes extra per-placement options).
2. Open the display's **Block settings → Allow settings** and tick the overrides
   you want editors to control per block:
   - **Contextual filters** — let the block supply the view's contextual
     arguments.
   - **Exposed sort** — let the block choose the sort field and direction.
   - **Pager ID** — let the block set its pager ID (handy when several paginated
     views share one page and their pagers would otherwise collide).
   - **More link text** — a custom "more" link label per block.
   - **More link URL** — a custom "more" link target per block.
   - (Core's **Items per page** remains available too.)
3. Save the view.
4. Place the block: at **Structure → Block layout**, in **Layout Builder**, or
   through a **Block Field**. In the block's configuration form you'll now see a
   field for each override you allowed. For a contextual filter you tick
   "Override" and enter (or autocomplete/select) the value; multiple values are
   combined with `+` (OR-style) for that argument.
5. Save the block. At render time the module applies your chosen sort and pager
   ID, injects the contextual values as the view's arguments, and sets the
   custom "more" link.

A few things worth knowing: multiple contextual filters combine with **AND** (for
OR use the *Views Contextual Filters OR* module). The module adds no permissions
— access is governed by normal block placement and the block's own visibility.
And you can keep the form tidy by enabling only the overrides you actually need.
