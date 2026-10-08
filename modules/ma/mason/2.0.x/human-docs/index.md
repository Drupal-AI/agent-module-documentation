# Mason — manual setup guide

**Mason** (`mason`) creates a **perfectly gapless grid** of variably‑sized
elements. It is not the same as Masonry, Isotope, or Gridalicious: rather than
leaving the ragged gaps those layouts produce, Mason measures the blocks and the
total grid area, detects the empty spaces, and fills them — so the result is a
tightly packed, evenly filled grid, ideal for image galleries, card lists, and
mixed‑content listings.

Mason integrates the **Mason** JavaScript library into Drupal and exposes it as a
**Views style plugin** and a few **field formatters**, so you can render a View or
a multi‑value field as a Mason grid. It builds on **Blazy** (for lazy‑loading and
media handling) and core **Views**. Two optional submodules ship with it:
**Mason UI** (`mason_ui`) provides an admin builder for creating and tuning Mason
grid "optionsets", and **Mason Example** (`mason_example`) provides sample grids
and a README to learn from.

It is purely a front‑end layout integration — there is no security surface and no
sensitive configuration. The one thing to get right is the JavaScript library: the
Mason assets must be present on your site (typically at
`/libraries/mason/dist/mason.min.js`) for the grid to render.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Blazy
   dependency, add the Mason JavaScript library, and enable the submodules you
   want.

There is **no single settings page**. You build grids either in the Mason UI or
directly on a View, described in "How to use it" below.

## Where it lives in the admin menu

- **Structure → Mason** (`admin/structure/mason`) — build and manage Mason grid
  optionsets (provided by the **Mason UI** submodule).
- **Structure → Views** (`admin/structure/views`) — create a page or block View
  and choose the **Mason** display style.

## How to use it

1. With the Mason library in place (see [Installation](installation/index.md)),
   visit **Structure → Mason** to build a Mason grid optionset. Start from the
   provided samples and read the accompanying README.
2. Go to **Structure → Views** and create a new page or block. For its display
   format, choose the **Mason** style and select the optionset you built.
3. Alternatively, use one of Mason's **field formatters** on a multi‑value field's
   **Manage display** to render that field's items as a Mason grid.
4. Tune the result: Mason flows floated elements as a normal CSS layout and then
   fills the gaps with "fillers". If the fillers look wrong, use the **Promoted**
   option (with a matching count of visible Mason boxes) or the **Fillers** option
   in the Views UI to fill gaps automatically — expect a little trial and error,
   and use deliberate item sizes rather than random ones.

> **Tip:** The **Mason Example** submodule (`mason_example`) is the fastest way to
> see a working grid and copy a known‑good configuration before building your own.
