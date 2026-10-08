# Configuration

Panels has **no settings form of its own** — as its own description says, it
"provides no external UI; at least one other Panels module should be enabled." You
configure Panels by building **displays**, and you do that through **Page Manager**
(and, optionally, the **Panels IPE** on-page editor). This page walks through that
flow.

## The Panels display variant

The heart of Panels is a display variant with the plugin id `panels_variant`
(labeled **Panels** in the UI). You add it to a Page Manager page as a variant, and
it stores its configuration inside that page variant. Page Manager and Panels wire
the storage together automatically, which is also what enables the in-place editor
for that display.

## What a display holds

Each Panels display is made up of:

- **Layout** — a layout plugin from core Layout Discovery (for example one column,
  two column, or the 25/50/25 three-column layout), plus that layout's own
  settings.
- **Regions** — the named areas the chosen layout defines.
- **Blocks (panes)** — the blocks placed into those regions, each carrying its own
  visibility conditions, caching, and — via Panels — extra CSS classes, an HTML id,
  and inline CSS styles.
- **Page title** — the display's title, which can be taken from a specific pane
  rather than a fixed string.
- **Builder** — which display builder renders it (the standard builder by default;
  Panels IPE swaps in the in-place editor builder).

## Build flow

1. **Create a Page Manager page.** Go to **Structure → Pages**
   (`/admin/structure/page_manager`) and add a page, then add a **variant** of type
   **Panels**.
2. **Select a layout.** In the variant, pick a layout. If you change the layout
   later, Panels helps you remap the existing panes into the new layout's regions.
3. **Place blocks into regions.** Add blocks (panes) to the layout's regions and
   reorder them. The block add/edit/delete forms live under
   `/admin/structure/panels/…` and are reached while editing the variant. For each
   pane you can set visibility conditions, caching, and CSS classes/id/styles.
4. **Set the page title** if you want it drawn from a pane or set explicitly.
5. **Save.** The display is persisted, and the page now renders through Panels.

## In-place editing (Panels IPE)

If you enabled the **Panels IPE** submodule, you can edit a Panels display directly
on the rendered front-end page instead of through the Page Manager wizard forms.
The IPE lets you drag blocks between regions, add new custom block content inline,
and adjust the layout — all on the page itself. Access to the IPE is gated by
Panels' permissions.

## Permissions

Panels defines permissions that control who can configure the more advanced parts
of a pane or display — pane **access** settings, **advanced** settings, **styles**,
**caching**, and **locks** (which stop concurrent editors from clobbering each
other) — plus access to the Panels dashboard and the IPE. Grant these at **People →
Permissions** (`/admin/people/permissions`) to trusted roles.

## Layout Builder vs. Panels

Panels is the classic region-based page builder and pairs naturally with Page
Manager's route-level control. Core **Layout Builder** covers similar ground for
per-entity and per-bundle layouts; choose Panels when you specifically want Page
Manager routing or the Panels toolkit.
