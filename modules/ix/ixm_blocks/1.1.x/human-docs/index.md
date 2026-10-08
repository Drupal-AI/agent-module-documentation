# IXM Blocks — manual setup guide

**IXM Blocks** (`ixm_blocks`) is a **shell module** that packages a set of reusable
**custom block types** an agency (ImageX) uses across client builds — the components
a marketing site tends to need over and over. Instead of rebuilding a hero or a card
grid from scratch on every project (with slightly different field names each time),
you enable the components you want and get consistent, ready-made block types.

The module itself is just the shell; each **component lives in its own submodule**, so
a build only turns on the pieces it needs. When you enable a component's submodule it
**imports the field configuration** for that block type, sets up a **default
template** (a theme hook you can override in your own theme), and — if you use the
Block Library with Layout Builder — provides a **default set of icons** in the
off-canvas menu.

The components are ordinary `block_content` bundles, so they are **revisioned,
translatable, and reusable through the block library**, and they work equally well
with **Layout Builder** or plain **block layout**. Two things make it worth a look
even from outside the agency: the `ixm_blocks_boilerplate` submodule is a clean
worked example of how to package a block type properly (fields, form display, view
display, template), and the ten-component set is a reasonable checklist when scoping a
component library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   component submodules you need.

There is **no settings form** for this module. You enable the component submodules
you want and then create and place blocks of those types, described in "How to use
it" below.

## Where it lives in the admin menu

IXM Blocks adds no admin configuration page. Its block types appear where all custom
blocks do — you create content blocks under **Content → Blocks**
(`/admin/content/block`) and place them via **Structure → Block layout** or through
**Layout Builder**.

## How to use it

1. Enable the component submodules your site needs (see
   [Installation](installation/index.md)).
2. Each enabled component becomes a **custom block type** with its fields already
   configured.
3. Create a block of that type under **Content → Blocks**, fill in its fields, and
   **place** it via Block layout or add it to a layout in **Layout Builder**.
4. If you need a component that is not in the set, use **`ixm_blocks_boilerplate`** as
   the pattern for packaging your own.
