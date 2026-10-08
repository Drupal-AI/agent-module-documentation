# Extra Block Types (EBT): Block — manual setup guide

**Extra Block Types (EBT): Block** (`ebt_block`) adds a block type that lets you
**embed any other Drupal block** — a View, a custom content block, or a block
created programmatically — and wrap it in the EBT design options. It's the EBT
family's way of taking an existing block and giving it the same margins, padding,
borders, and background controls as the rest of your EBT components, so it fits
visually into a Layout Builder page.

It is part of the **Extra Block Types (EBT)** family, whose components are
provided as **block types** placeable in any region and in **Layout Builder** in a
few clicks. The shared design widget comes from the **EBT Core** (`ebt_core`) base
module. To let you pick the block to embed, this module also requires the **Block
Field** (`block_field`) module. It runs on Drupal 10.1+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its EBT Core and Block Field dependencies).

## Configuration

There is **no separate settings page** for this module. Like all EBT block types,
it is configured **per block instance** when you place it: you choose which block
to embed (via the Block Field selector) and set the shared **Design** options
right there on the block form. Those Design options — CSS box margins/paddings/
borders; background colour, image (including parallax and cover) or YouTube video;
edge-to-edge vs. container width — come from the **EBT Core** widget every EBT
block includes. See the [EBT Core project
page](https://www.drupal.org/project/ebt_core) for more.

## How to use it

1. Edit a page with **Layout Builder**, or go to **Structure → Block layout**.
2. Click **Add block** and choose the **EBT Block** block type.
3. Use the block selector to pick the View, custom block, or programmatic block
   you want to embed, then adjust the shared Design options.
4. Save. The embedded block renders inside the EBT styling wrapper.
