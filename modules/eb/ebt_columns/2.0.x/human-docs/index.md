# Extra Block Types (EBT): Columns / Container — manual setup guide

**Extra Block Types (EBT): Columns / Container** (`ebt_columns`) adds a block type
for building **multi-column layouts** that hold other blocks. You place a Columns
block, choose the column widths, and nest other blocks inside each column — a
simple way to lay out a page section, or even to arrange common Drupal blocks
(such as menus in a site footer) into columns.

It is part of the **Extra Block Types (EBT)** family, whose components are
provided as **block types** placeable in any region and in **Layout Builder** in a
few clicks. The shared design widget comes from the **EBT Core** (`ebt_core`) base
module. To let you place blocks *inside* the columns, it also requires the **Block
Field** (`block_field`) module. It runs on Drupal 10.1+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its EBT Core and Block Field dependencies).

## Configuration

There is **no separate settings page** for this module. Like all EBT block types,
the Columns / Container is configured **per block instance** when you place it:
you set the column widths, add the blocks that go in each column, and adjust the
shared **Design** options (CSS box margins/paddings/borders; background colour,
image — including parallax and cover — or YouTube video; edge-to-edge vs.
container width) from the **EBT Core** widget. See the [EBT Core project
page](https://www.drupal.org/project/ebt_core) for more.

## How to use it

1. Edit a page with **Layout Builder**, or go to **Structure → Block layout**.
2. Click **Add block** and choose the **Columns / Container** block type.
3. Choose the number of columns and their widths, then add a block to each column.
4. Adjust the shared Design options and save. The multi-column layout renders on
   the page.
