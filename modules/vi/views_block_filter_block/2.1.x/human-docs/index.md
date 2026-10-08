# Views Block Exposed Filter Block — manual setup guide

**Views Block Exposed Filter Block** (`views_block_filter_block`) unlocks the
"Exposed form in block" option for Views **block** displays. Normally Drupal only
offers that option on *page* displays, so a block display's exposed filters (the
search box, category select, sort controls and so on) are stuck inside the same
block as the results. With this module enabled, you can pull those filters out
into their own separate block and place them anywhere on the page — in a sidebar,
a header, an off-canvas panel, or a completely different Layout Builder section —
while the results block lives somewhere else entirely.

That opens up layouts that were previously awkward: a filter form fixed at the top
of a dashboard with results scrolling below, a search widget above a listing that
sits in the footer, or a faceted-looking UI without installing a heavier facets
stack. It also spares you from converting a block display into a page display
just to get the filters into a block.

The module is deliberately zero-configuration: it has **no settings form, no
permissions and nothing to set up beyond installing it**. Once it is on, the
"Exposed form in block" option simply becomes available on your block displays.
It builds on the CTools Views module, so it also keeps CTools' per-block-instance
display overrides available.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You use it through the **Views** UI
(`/admin/structure/views`) when editing a view's block display, and through
**Structure → Block layout** (`/admin/structure/block`) when placing the
resulting filter block.

## How to use it

1. Edit your view at **Structure → Views** and select the **Block** display.
2. In the display's **Advanced** column, set **Exposed form in block** to **Yes**
   and save the view. (This option only appears on block displays once this
   module is installed.)
3. The filters now vanish from the results block — that is expected, because they
   have moved into a block of their own.
4. Go to **Structure → Block layout**, click **Place block**, and search for the
   new block named **Exposed form: &lt;view&gt;-&lt;display&gt;**. Place it in the
   region where you want the filter form.
5. Place the view's own results block wherever the listing belongs.

A few practical notes:

- After turning the option on, clear caches (`drush cr`) so the new filter block
  appears in the block list.
- You can restrict where the filter block shows using core's normal block
  visibility conditions, place it in a different region from the results, or reuse
  it across a layout.
- To undo the effect, simply set **Exposed form in block** back to **No** — the
  filters return to the results block.
