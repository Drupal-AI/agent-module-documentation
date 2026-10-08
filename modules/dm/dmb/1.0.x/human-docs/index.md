# Dark Mode Button — manual setup guide

**Dark Mode Button** (`dmb`) provides a block with an icon button that lets
visitors switch your site between light and dark appearance, remembering their
choice. It's a small, focused theming/frontend feature: place the block somewhere
in your theme, and visitors get a one‑click toggle for dark mode that persists as
they move around the site.

There's nothing elaborate to it — it depends only on core's **Block** module and
supports a broad range of Drupal versions (8 through 11). Because it works by
placing a block, setup is just a matter of putting the block in a region through
the standard Block layout UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings form** — you set it up by placing the block,
described in "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page of its own. You place its block through
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Enable the module.
2. Go to **Structure → Block layout**.
3. Click **Place block** in the region where you want the toggle to appear (a
   header or utility region is typical), find the **Dark Mode Button** block, and
   place it.
4. Configure the standard block visibility settings if you want to limit where it
   shows, then save.

Visitors will now see the dark‑mode icon button and can toggle the site's
appearance; their preference is remembered.
