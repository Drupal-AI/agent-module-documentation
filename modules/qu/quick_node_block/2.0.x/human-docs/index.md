# Quick Node Block — manual setup guide

**Quick Node Block** (`quick_node_block`) gives you a block that renders any
single node in the view mode you choose. That lets you drop a piece of existing
content — a promotional item, an "About us" node, a call-to-action, a featured
article — into any theme region without building a View or writing custom code.
You pick the node and the display mode, place the block, and Drupal renders that
node right there.

Because it renders the real node through Drupal's normal view builder, the block
stays in sync with the content automatically: edit the node and the block
updates (it adds a cache tag for the node so caches invalidate correctly). It
also respects access — if a visitor is not allowed to view the node, the block
simply does not appear for them.

There is no global settings page. Each block placement carries its own choice of
node and view mode, so you can place the same node as a compact teaser in one
region and as full content in another, or build a "featured content" area from
several Quick Node Blocks. A handy **Add to Block** tab on every node page lets
you jump straight to placing that node in a block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — placing the block, picking the node
   and view mode, and the "Add to Block" shortcut.

## Where it lives in the admin menu

The module has no settings page of its own. You work with it in **Structure →
Block layout** (`/admin/structure/block`), where **Quick Node Block** appears as
a placeable block (category "Quick Node Block"). Each node page also gains an
**Add to Block** tab at `/admin/node/{node}/quick_node_block` (requires the
**Administer blocks** permission).

## How to use it

Place a **Quick Node Block** into a region, choose the node you want to show and
the view mode to render it in, and save. To repeat with a different node, place
another block. See [Configuration](configuration/index.md) for the step-by-step.
