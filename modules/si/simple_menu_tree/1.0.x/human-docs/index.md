# Simple Menu Tree — manual setup guide

**Simple Menu Tree** (`simple_menu_tree`) is an easy way to present a menu as a tree
on your site. It ships as a **Single Directory Component (SDC)** — a reusable
component that renders a menu's hierarchical structure — and it is designed to be as
simple as possible: enable the module, place its block in a region, choose the data
source and a title, and a menu tree appears on your site.

The tree's **source** can be either a **menu** or a **taxonomy** vocabulary, so you
can use it to display an ordinary navigation menu or to turn a vocabulary's term
hierarchy into a browsable tree. It is aimed at people who just want a straightforward
dynamic tree on the page without wiring up Views or custom templates. Because it
renders standard menu output, the menu follows normal menu access rules — the module
has no access‑control role of its own.

Simple Menu Tree requires **Drupal 10 or 11** (it relies on core's SDC support, which
arrived in Drupal 10) and depends only on Drupal core. There is no separate settings
form; configuration happens on the block you place. Note that this is an early
release candidate (1.0.0‑rc1) and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling the module you get a **menu tree** block that you place and configure:

1. Go to **Administration → Structure → Block layout**
   (`/admin/structure/block`).
2. Place the **menu tree** block in the region where you want the tree to appear.
3. In the block's settings, choose the **data source** — a menu or a taxonomy
   vocabulary — and set the **title**.
4. Save. The menu tree renders on your site.

That is the whole setup: place the block, pick a source, give it a title, and the
component draws the tree.
