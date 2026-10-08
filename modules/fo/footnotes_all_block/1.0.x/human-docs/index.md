# Footnotes all block — manual setup guide

**Footnotes all block** (`footnotes_all_block`) adds a block that gathers **every
footnote on a page into one place** — a single "references" section — instead of
showing footnotes separately at the end of each field. If your content carries
footnotes across several fields, this collects them all into one consolidated
list, typically placed at the bottom of the page.

It works together with the [Footnotes](https://www.drupal.org/project/footnotes)
module (version 4.0 or newer), which is where the footnotes themselves come from.
After the page loads, this module uses JavaScript to move each footnote into the
block, so the block is where the aggregated footnotes end up. It is purely a
content‑display feature — it changes how footnotes are presented and has no
access‑control role.

Because this is a block, there is no dedicated settings form: you use it by
placing the block in a region through Drupal's normal **Block layout** page,
described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires the Footnotes module).

There is **no configuration page** for this module. You set it up by placing its
block, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own. You place its block from
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Make sure the [Footnotes](https://www.drupal.org/project/footnotes) module is
   installed and that your content uses footnotes.
2. Go to **Structure → Block layout**.
3. Choose the region where the aggregated footnotes should appear (commonly a
   content‑bottom or footer region) and click **Place block**.
4. Find and place the **Footnotes** block provided by this module.
5. Configure the block's visibility as you would any block (for example, restrict
   it to certain content types or pages), then save.

Once placed, footnotes from across the page's fields are moved into this block
after the page loads, giving you one consolidated references section.
