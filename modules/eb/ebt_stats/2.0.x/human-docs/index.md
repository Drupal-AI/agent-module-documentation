# EBT Stats — manual setup guide

**EBT Stats** (`ebt_stats`) adds a **Stats** block type — the "impact numbers"
section you see on marketing pages, where big figures sit above short labels. Each
block holds a title and description (edited with a WYSIWYG editor) plus a set of
numbers with accompanying text or icons. Enable the module and the Stats block type
is ready to place.

It is part of the **Extra Block Types (EBT)** family, sharing the **EBT Core**
(`ebt_core`) base for common design options — spacing, background, borders, and
container width — and it also depends on **Paragraphs** (each stat is a Paragraph
item). It is a display‑only block with no security surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Stats adds no configuration page of its own. You use it by placing a **Stats**
block: in **Layout Builder**, at **Structure → Block layout**, or as a reusable
block under **Content → Blocks → Add content block**.

## How to use it

1. Add a Stats block through Layout Builder or Block layout.
2. Enter the title and description, then add your numbers with their text or icons
   (each is a Paragraph item, so add as many as you need).
3. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block.
