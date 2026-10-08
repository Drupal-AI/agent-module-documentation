# Drutopia Social — manual setup guide

**Drutopia Social** (`drutopia_social`) is a tiny base feature that wires up a
**social media links block** for a
[Drutopia](https://www.drupal.org/project/drutopia) site. Its whole job is to
declare a dependency on core **Block** and the contributed
[Social Media Links](https://www.drupal.org/project/social_media_links) module, so
that once enabled a site has a ready-to-place "social media links" block.

There is no PHP code and (in this release) no exported configuration of its own —
which networks appear, their icons, and their order are all configured on the
Social Media Links block instance once you place it. Because it ships no routes,
services or permissions, there is nothing to secure in the module itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the Social Media Links dependency.

## Where it lives in the admin menu

There is no settings form. You place and configure the social block at
**Structure → Block layout** (`/admin/structure/block`); the block's own settings
(networks, icons, order) come from the Social Media Links module.

## How to use it

1. Enable the module so the Social Media Links block becomes available.
2. Go to **Structure → Block layout** (`/admin/structure/block`) and place the
   **Social Media Links** block in a region — a footer or header is typical.
3. In the block's settings, choose which networks appear (Facebook, X, Instagram,
   and so on), set the icon style and size, and reorder the platforms.

You can place several social blocks in different regions, and restrict a block's
visibility by path or role using core block conditions. To remove the social
links, disable the module or delete the block placement.
