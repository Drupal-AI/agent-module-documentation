# Interactive Globe — manual setup guide

**Interactive Globe** (`interactive_globe`) provides a block that renders a
rotatable **3D globe** in the browser, complete with your own images and text.
It's a visual, geographic storytelling element: place the block in a region, give
it custom imagery and text markers or labels, and visitors can spin the globe to
explore it.

Setup is simple because everything happens through Drupal's normal Block Layout —
you place the "Interactive Globe" block and configure its imagery and text in the
block's own settings. There is no separate site‑wide settings page.

One naming quirk to note: the Composer package is `drupal/iglobeblock` (the project
is *iglobeblock*), while the module you enable is `interactive_globe`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module — the globe is
configured on the block itself. See "How to use it" below.

## Where it lives in the admin menu

Interactive Globe adds no configuration page of its own. You work with it from
**Structure → Block Layout** (`/admin/structure/block`), where you place the
"Interactive Globe" block into a region.

## How to use it

1. Go to **Structure → Block Layout** and click **Place block** on the region
   where the globe should appear.
2. Search for and select the **Interactive Globe** block.
3. In the block settings, configure the globe's **custom images** and the **text**
   markers/labels you want to show.
4. Save. The rotatable 3D globe now renders in the chosen region.

Because the block exposes settings, you may want to restrict who can place or
configure it via the permission the module provides (**People → Permissions**).
