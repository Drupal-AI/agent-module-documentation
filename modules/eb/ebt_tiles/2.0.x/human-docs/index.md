# EBT Tiles — manual setup guide

**EBT Tiles** (`ebt_tiles`) adds a **Tiles** block type — a grid of cards, each with
a title, text, image, and link. It is the "key items" or "feature cards" element you
often want on a landing page, edited with a WYSIWYG editor. Enable the module and the
Tiles block type is ready to place.

It is part of the **Extra Block Types (EBT)** family, sharing the **EBT Core**
(`ebt_core`) base for common design options — spacing, background, borders, and
container width — and it also depends on **Paragraphs** (each tile is a Paragraph
item). It is a display block: tile text is edited with the WYSIWYG editor and
rendered through the text format you assign to the block's fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Tiles adds no configuration page of its own. You use it by placing a **Tiles**
block: in **Layout Builder**, at **Structure → Block layout**, or as a reusable
block under **Content → Blocks → Add content block**.

## How to use it

1. Add a Tiles block through Layout Builder or Block layout.
2. Add your tiles (each is a Paragraph item with a title, text, image, and link).
3. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block.
