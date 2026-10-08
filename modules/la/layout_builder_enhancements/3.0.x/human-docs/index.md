# Layout Builder Enhancements — manual setup guide

**Layout Builder Enhancements** (`layout_builder_enhancements`) adds a set of
extra conveniences to core's Layout Builder, delivered through optional
submodules so you enable only the parts you want. Its two headline features are a
**View Block** that places Views results neatly into a Layout Builder grid (with
automatic offset calculation so items flow across the grid), and a **layout
preview** feature that adds a dedicated view mode letting complex block types show
a meaningful preview while you edit a layout, instead of a bare placeholder.

It is a site‑building / layout feature. Layout content still follows normal block
and entity access — the module changes the building experience, not who may see or
edit content. It depends on core's Layout Builder and Block Content modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the enhancement submodules you need.

This module has **no single settings form**. Each feature is configured where it
naturally lives — the preview view mode on a block type's *Manage display*, and the
View Block by adding an embed View — as described below.

## Where it lives in the admin menu

It adds no dedicated admin page. Its features surface inside the Layout Builder
interface and on the relevant *Manage display* pages (for example **Structure →
Block content → *(block type)* → Manage display** for the preview view mode).

## How to use it

- **Preview.** Enable the preview enhancement, then configure a preview display
  for the block types you want to preview. In Layout Builder those blocks then
  show a proper preview rather than a placeholder.
- **View Block.** Add a new embed View, and a new block for Layout Builder will
  become available. Placed in a Layout Builder grid, it lays out the View's items
  with automatic offset calculation so they fit the grid flexibly.

> **Good companion:** pairing this with
> [Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions)
> is recommended to keep the block palette manageable.
