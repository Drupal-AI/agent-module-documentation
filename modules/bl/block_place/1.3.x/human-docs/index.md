# Place Blocks — manual setup guide

**Place Blocks** (`block_place`) adds a **"Place block"** button to the admin toolbar
so you can drop blocks into your theme's regions directly from any front-end page —
seeing exactly where each block will land, in the real page context, instead of
juggling region machine names on the Block layout admin screen. It's the contrib
continuation of the "Place block" module that used to ship with Drupal 8 core and was
later removed, brought back for Drupal 9, 10, and 11.

It's a deliberately simple tool. Enabling it (it depends on core **Block**,
**System**, and **Toolbar**) adds the toolbar button for anyone with the core
**Administer blocks** permission. Clicking the button turns on "placement mode": the
page reloads with every visible theme region highlighted and a "Place block in the …
region" link in each one. Clicking a region opens Drupal's normal block library in a
modal, already scoped to that region and the active theme, so you pick a block and it's
placed there. Click the button again to leave placement mode.

There is **nothing to configure** — no settings page, no config, and no permissions of
its own. It reuses core's **Administer blocks** permission, so whoever can already
manage blocks can use it, and it stays hidden on admin pages so it doesn't get in the
way there. Think of it as a lightweight, in-context alternative to the Block layout
screen (and to Layout Builder) for simple region-based block placement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. That's the whole setup.

## Where it lives in the admin menu

There is no settings page. The feature is the **Place block** button in the admin
toolbar, visible to users with **Administer blocks** on non-admin (front-end) pages.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Browse to a front-end page as a user with **Administer blocks**.
3. Click **Place block** in the admin toolbar. The page reloads in placement mode with
   each visible theme region highlighted.
4. Click **Place block in the … region** for the region you want. Drupal's block
   library opens in a modal, already scoped to that region and the active theme.
5. Choose a block, configure it as usual, and it's placed into that region. You're
   returned to the page you started from.
6. Click **Place block** again to turn placement mode off.

Blocks are placed per theme, using the active theme's regions — so switch to the theme
you want to build out before you start.
