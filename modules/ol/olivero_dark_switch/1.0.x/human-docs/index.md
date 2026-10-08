# Olivero Dark Switch — manual setup guide

**Olivero Dark Switch** (`olivero_dark_switch`) adds a light/dark mode toggle to
Drupal's default front‑end theme, **Olivero** — without abandoning Olivero or
switching to a sub‑theme. Instead of shipping a whole dark sub‑theme, it provides a
**block** containing a toggle that's styled to blend into Olivero, so you place it
wherever you want the control to appear and visitors can flip the site between light
and dark themselves.

A few things make it fit Olivero nicely:

- It **alters Olivero's own CSS variables** to produce the dark appearance, reversing
  gradient variables with small adjustments so the result still meets accessibility
  contrast standards — and so it stays compatible with Olivero's colour‑picking
  feature.
- It **remembers each visitor's choice** using the browser's local storage.
- It **respects the browser preference** — it detects `prefers-color-scheme: dark` and
  serves the dark theme to visitors who've set their browser to dark mode.

It's a presentation‑only feature: no content and no access‑control role. It assumes
you're using Drupal core's Olivero theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it on an
   Olivero site.

There is no settings form; the only setup is placing the toggle block, described in
"How to use it" below.

## How to use it

1. Enable `olivero_dark_switch` (see [Installation](installation/index.md)) on a site
   using the Olivero theme.
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** next to the region where you want the toggle. A good choice
   is the **Hero (full width)** region.
4. Find **Olivero Dark Switch** in the block list and place it.
5. On the block's configuration form, turn **Display title** off, and set **Float**
   to **Right** before saving. (The block can float the toggle within its region.)
6. Visit the home page or any Olivero‑themed page and you'll see the toggle — by
   default in the top‑right corner. Clicking it switches between light and dark, and
   the choice is remembered for that visitor.
