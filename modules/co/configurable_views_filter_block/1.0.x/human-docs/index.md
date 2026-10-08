# Configurable Views Filter Block — manual setup guide

**Configurable Views Filter Block** (`configurable_views_filter_block`) gives you a
smarter version of Views' exposed‑filter block. Core lets you put a view's exposed
form (its filters, sort, reset button, and pager controls) into a block — but it's
all‑or‑nothing, and you can only place it once. This module adds a block called
**"Views Exposed Filter Block (configurable form)"** that behaves the same way but
lets you choose, *per block instance*, exactly which of those elements are shown.

That small change unlocks a lot of layout freedom. You can split one view's
exposed form across several regions — a keyword search box in the header and a
category filter in the sidebar, say — or place the same view's filters twice on a
page, each instance showing a different subset. You can move the sort options into
their own block, hide the reset button or pager on a particular instance, or
flatten collapsible filter fieldsets into a plain inline form. It's a clean way to
build a curated, uncluttered filter UI (great for mobile) or to combine a view's
filters with the Facets module in the same region.

Importantly, hidden filters are only *visually* hidden — their values are still
submitted with the form — so nothing about the view's results breaks. And because
each placed block regenerates a unique form id, you can safely have several
instances of the same view's exposed form on one page without the usual
duplicate‑form conflicts. It depends only on core's **Views** module, and pairs
nicely with **Better Exposed Filters** if you want to restyle the trimmed form.

There is no central settings page — you configure everything on each block as you
place it through the normal Block layout UI, so no code is required. It pairs well
with cloning-free reuse: instead of duplicating a view just to show a different set
of filters somewhere else, you place another configured block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module has no configuration page of its own. You work with it in two places:

- **The view** — the block only appears for a view display that has its exposed
  form set to show in a block. In the Views UI, open the display's **Advanced →
  Exposed form → Exposed form in block** option and set it to **Yes**.
- **Block layout** — place the block at **Structure → Block layout**
  (`/admin/structure/block`), where you choose which filters and controls each
  instance shows.

## How to use it

1. In the Views UI, edit the display and set **Advanced → Exposed form in block:
   Yes**. (Without this, no block is available for the display.)
2. Go to **Structure → Block layout**, click **Place block** in the region you
   want, and choose **"Views Exposed Filter Block (configurable form)"** for your
   view and display.
3. On the block's configuration form you'll see a **Visible filters** checkbox
   group — tick the exposed filters you want this instance to show (each is listed
   as *Label (identifier)*). Anything left unchecked is hidden on this instance.
4. Under **Other visibility options**, optionally tick:
   - **Hide reset button** — remove the exposed form's reset button here.
   - **Hide sort** — remove the exposed sort controls (shown only if the view
     exposes sorts).
   - **Hide pager** — remove the exposed items‑per‑page / offset controls (shown
     only if the view exposes them).
   - **Remove groups** — flatten collapsible `details` fieldsets into plain
     containers.
5. Save the block. Repeat to place additional instances of the same view's form
   elsewhere, each showing a different subset — for example one block with just the
   search filter and another with just the sort controls.
