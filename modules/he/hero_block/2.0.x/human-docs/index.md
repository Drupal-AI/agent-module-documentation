# Hero Block — manual setup guide

**Hero Block** (`hero_block`) is a simple way to create hero image blocks — the
large banner‑style sections you often see at the top of a landing or content page.
Each hero block can carry an **image** (with a chosen image style), a **title**, and
a **subtitle**, and you can create as many of them as you like for different pages.

Because a hero block is a normal Drupal block, you place it through the block layer
and use core's block visibility conditions to control where it shows — on specific
pages, a path, a node, a node type, or a taxonomy term. The module also defines
custom CSS classes on the markup so your theme can style the heroes exactly how you
want.

The hero content is admin‑authored and rendered through Drupal's normal layers; the
module has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no global settings page** for this module — each hero is configured on
its own block instance when you place it, as described below.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the hero to appear, and choose
   the **Hero Block** you want to add.
3. In the block's configuration form, set the **image** (and pick an **image
   style**), the **title**, and the **subtitle**.
4. Use the standard **Visibility** settings to limit the block to the pages, paths,
   content types, nodes, or taxonomy terms where the hero should appear.
5. Save the block. Repeat to build separate hero blocks for different pages.

Style the result with your theme's CSS by targeting the custom classes the module
adds to the hero markup.
