# EBT Quote — manual setup guide

**EBT Quote** (`ebt_quote`) adds a styled **Quote** block type — a pull‑quote or
testimonial you can place as a block in a layout, a sidebar, or anywhere a block
goes. Enable the module and the Quote block type is ready to use.

It is part of the **Extra Block Types (EBT)** family and depends only on the shared
**EBT Core** base (`ebt_core`), which provides the common design options — spacing,
background, borders, and container width — so a quote here is styled consistently
with the rest of the family. It is a display‑only block with no security surface:
no routes, no permissions, nothing to lock down.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Quote adds no configuration page of its own. You use it by placing a **Quote**
block: in **Layout Builder**, at **Structure → Block layout**, or as a reusable
block under **Content → Blocks → Add content block**.

## How to use it

1. Add a Quote block through Layout Builder or Block layout.
2. Enter the quotation text and citation.
3. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block.
