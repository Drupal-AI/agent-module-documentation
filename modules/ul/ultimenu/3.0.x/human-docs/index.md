# Ultimenu — manual setup guide

**Ultimenu** (`ultimenu`) turns an ordinary Drupal menu into a **mega-menu**
whose flyout panels are real Drupal regions. It flips the usual model on its head:
normally a region contains blocks, but with Ultimenu each top-level item of a menu
becomes its own dynamic region that you can drop any block into. So the "Products"
item in your main menu can open a panel containing a promo block, a view, and an
image, arranged exactly how you like at *Block layout*.

You enable which menus become Ultimenu blocks, and which of their items become
active regions, on the module's settings form. Each enabled menu then appears as a
placeable **Ultimenu block** (one per menu) that you position in a normal theme
region such as the header. Per-block settings control the look and behaviour:
skin, flyout orientation, carets, whether to render second-level items, sticky
header, and off-canvas / hamburger mode for mobile. Panels can even be AJAX-loaded
on demand so heavy menus don't slow the initial page.

Regions are contributed at runtime, so you never have to edit your theme's
`.info.yml` by hand (though you can paste the generated definitions in to make them
permanent). Ultimenu builds on **Blazy** (a shared vanilla-JS base) and core's
Block and Menu modules.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the full `ultimenu.settings`
key list and per-block settings — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Blazy
   and enable the module.
2. [Configuration](configuration/index.md) — the settings form, turning a menu
   into a mega-menu block, enabling its regions, and placing the block.

## Where it lives in the admin menu

Its settings form is at **Structure → Ultimenu** (`/admin/structure/ultimenu`),
guarded by the **Administer ultimenu** permission. From there you enable menus and
regions; you then place the resulting blocks at **Structure → Block layout**
(`/admin/structure/block`). The full step-by-step is in
[Configuration](configuration/index.md).
