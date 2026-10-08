# Drupal Planet Feeds Block — manual setup guide

**Drupal Planet Feeds Block** (`drupal_planet_feeds_block`) provides a ready‑made
block that shows the latest posts from the **Drupal Planet** feed — the
aggregated blog feed of the Drupal community at
[drupal.org/planet](https://www.drupal.org/planet). Place the block in a region
and your site surfaces recent community news and blog posts, no custom feed work
required.

The problem it solves is a small but common one: you want a bit of live community
content in a sidebar or footer without building a feed importer. This module
fetches the Planet feed and renders its most recent entries in a block you can
place through the normal Block layout UI. Because it pulls an **external feed**,
keep feed availability and caching in mind — the block depends on drupal.org being
reachable, and Drupal's block/render caching governs how often the entries
refresh.

It works as soon as you place the block; the setup happens entirely on the Block
layout page (title, number of feeds to display, and visibility). It depends on
core's **Views** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Views dependency.

There is **no separate settings page** — you configure everything when you place
the block, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no dedicated config page. You use it from **Structure → Block
layout** (`/admin/structure/block`), where its block becomes available to place.

## How to use it

1. After enabling the module, go to **Structure → Block layout**
   (`/admin/structure/block`).
2. Find the region where you want the feed to appear and click **Place block**
   next to it.
3. In the block browser, filter by **Planet Drupal** and click **Place block**
   next to the Drupal Planet Feeds Block.
4. Set the block's **Title**, the **Number of feeds to display**, and any
   **Visibility** conditions (pages, roles, content types), then click **Save
   block**.
5. Visit the page where you placed the block — you should see the latest Drupal
   Planet posts listed.
