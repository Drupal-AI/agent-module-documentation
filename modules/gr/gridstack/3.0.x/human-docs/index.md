# GridStack — manual setup guide

**GridStack** (`gridstack`) brings the [GridStack.js](https://www.drupal.org/project/gridstack)
JavaScript library into Drupal so you can build multi‑column, drag‑and‑drop grid
layouts. Instead of describing a layout in CSS by hand, a site builder or editor
composes a page as a grid of blocks and drags them into place — resizing and
rearranging regions visually — and the positions are saved.

It sits on top of core's **Layout Builder** rather than replacing it, exposing
the grids as Layout Builder layouts through the `gridstack_layouts` submodule. A
management UI (`gridstack_ui`) lets you create and edit the grid definitions
themselves, and an example submodule (`gridstack_example`) ships demo grids and
blocks so you can see the workflow before building your own.

One thing to know before you install: GridStack depends on the third‑party
GridStack.js library, which is **not** bundled with the module. You download it
into your site's `libraries/` directory yourself. The 3.x branch expects library
versions v4–v5. Installation covers this step in detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the GridStack.js library, and enable the submodules you need.

There is **no single settings form** for GridStack (`configure` is null). You
work with it through Layout Builder and the grid‑management UI, both described
under "How to use it" below.

## Where it lives in the admin menu

Once the `gridstack_ui` submodule is enabled, the grid‑management screens live at
**Structure → GridStack** (`/admin/structure/gridstack`), where you add and edit
grid layouts. A related UI at `/admin/structure/gridstack/ui` lets you enable
static‑grid supports such as Bootstrap and Foundation. Verify the JavaScript
library is detected on the **Status report** at `/admin/reports/status`.

## How to use it

The typical flow, once the module, library, and submodules are in place:

1. Confirm the GridStack.js library is installed and detected — check
   **Reports → Status report**.
2. Optionally visit **Structure → GridStack** to add or manage initial grid
   layouts. Always clear the cache after adding new layouts, because layout
   registrations are cached; you only need to do this once per new layout.
3. Enable Layout Builder on a content type's display at
   **Structure → Content types → *(type)* → Manage display**, and for the
   richer visual grids add an **unlimited (multi‑value) core Media field** to
   that content type first.
4. On a Layout Builder page (the display default, or an individual node's
   `/node/{id}/layout`), choose one of the **GridStack** layouts for a section,
   then drag blocks into the grid and resize the regions to taste.
5. If you want ready‑made blocks to experiment with, enable `gridstack_example`
   and place its sample blocks in a wide region.

Because GridStack builds on Layout Builder, the usual Layout Builder access rules
decide who may edit layouts — restrict layout building to the roles who should
be composing pages.
