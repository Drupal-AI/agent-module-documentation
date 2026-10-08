# Jquery Fireworks — manual setup guide

**Jquery Fireworks** (`jquery_fireworks`) adds a decorative, canvas‑based
fireworks animation to your site. It's a bit of celebratory sparkle — handy for a
seasonal landing page, a launch announcement, or any moment you want a page to
feel festive. The animation is rendered on an HTML canvas and is responsive, so
it scales across desktops, tablets, and phones.

You place the effect through Drupal's normal **Block Layout**: the module
provides a **Canvas based fireworks** block that you drop into any region, on all
pages or only specific ones. All the usual core block visibility settings apply —
by page, by content type, by role, and so on — so you control exactly where the
fireworks appear.

There is no dedicated settings page: everything you need is on the block itself
and the standard block placement options.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module. You set it up entirely by
placing its block, described in "How to use it" below.

## How to use it

1. Go to **Structure → Block Layout** (`/admin/structure/block`).
2. Find the region where you want the fireworks and click **Place block** next to
   it.
3. In the dialog, click **Place block** next to **Canvas based fireworks**.
4. Use the block's standard visibility settings to choose where it shows — all
   pages, or only specific paths, content types, or roles.
5. Click **Save block**.

Reload a front‑end page in that region and the fireworks animation should play.
