# Burger Menu — manual setup guide

**Burger Menu** (`burger`) adds a hamburger-style navigation toggle to your
site. It renders a hamburger button that, when tapped or clicked, opens a
full-screen overlay navigation — a clean, mobile-friendly way to present a menu
on small screens. The animation and behavior are based on the Burger JavaScript
plugin.

You add it to a page by placing its **block** in a region of your theme, just
like any other block. There is no separate settings page to fill in — enable the
module, place the block, and the toggle appears. It depends only on Drupal core's
Block module and requires Drupal 11.

Burger Menu is purely a navigation and theming enhancement. It stores no content
and has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Burger Menu does not add its own configuration page. You work with it on the
**Block layout** screen at **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** in the region where you want the hamburger button to
   appear (typically a header region) and choose the Burger Menu block.
4. Configure the block's normal settings (title, visibility, region) and save.

The hamburger button now shows in that region; clicking it opens the full-screen
navigation overlay. Styling follows the Burger JS plugin, so the look can be
adjusted through your theme's CSS.
