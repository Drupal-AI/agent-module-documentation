# Extra Block Types (EBT): Text — manual setup guide

**Extra Block Types (EBT): Text** (`ebt_text`) adds a ready‑made **Text** block type
— a title and a WYSIWYG body — wrapped in the Extra Block Types family's shared
presentation settings. It is the simplest component in the family and, arguably, the
one worth having most: a text block is placed more often than every other component
combined, and core's basic block gives you a body field and nothing else. The moment
a design calls for that text on a coloured background, with padding above it, or
constrained to a narrower column, EBT Text turns those decisions into form fields.

It is part of the **Extra Block Types (EBT)** family and depends only on the shared
**EBT Core** base (`ebt_core`), which provides the common design options — spacing,
background, borders, and edge‑to‑edge or fixed‑width container. As a block type (not
a paragraph type) it can be placed in a region, dropped into a Layout Builder
section, or referenced from a field.

Two things worth weighing, and they are the family's standing trade‑off. Pre‑built
components are quick to adopt but awkward to diverge from — a design the options do
not cover means overriding templates, at which point a locally defined block type is
sometimes cheaper. And the block type becomes a dependency of your content: pages are
built from it, so removing the module later leaves those blocks without a type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Text adds no configuration page of its own. You use it by placing a **Text**
block: in **Layout Builder**, at **Structure → Block layout**, or as a reusable
block under **Content → Blocks → Add content block**.

## How to use it

1. Add a Text block through Layout Builder or Block layout.
2. Enter the title and body text.
3. Set spacing, background, borders, and container width using the shared **EBT
   Core** design options, then save and place the block.
