# Entity Submenu Block — manual setup guide

**Entity Submenu Block** (`entity_submenu_block`) provides a block that shows the
current page's child menu items as **fully rendered content entities** — for
example node teasers — instead of a plain list of links. It's a drop-in
enhancement of core's System Menu Block: rather than "here are the links below
this page", you get "here are the actual pages below this one, rendered as cards
or teasers".

It's ideal for a "section landing" or "In this section" widget. When placed, the
block looks at the active menu trail, takes the child links at the current level,
and for each link that points to a content entity it renders that entity in a
view mode you choose per entity type (e.g. render child `node` links as teasers).
Links that aren't entity routes — or are external — can optionally be shown as
simple links, or skipped entirely.

The module defines **one block plugin, derived per menu** (so each menu gets its
own placeable block), and it works as soon as you place and configure that block.
It has **no global settings page and no permissions of its own** — you place and
configure it at **Block layout**, using core's normal block permissions. It
requires core's **Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the block and set its options
   (view modes per entity type, non-entity links, language filtering, empty
   behaviour).

## Where it lives in the admin menu

There is no dedicated settings page. You add and configure the block at
**Structure → Block layout** (`/admin/structure/block`) → **Place block**,
choosing the derivative for the menu you want.

## How to use it

Enable the module, then place the block: at **Block layout**, click **Place
block** and pick the entry labelled *"(Menu name) (Entity Submenu Block)"* for the
menu whose children you want to surface. Choose which entity types render (and in
which view mode), place it in a region, and save. Full option-by-option details
are in [Configuration](configuration/index.md).
