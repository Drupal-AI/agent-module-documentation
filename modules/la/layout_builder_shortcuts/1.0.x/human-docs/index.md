# Layout Builder Shortcuts — manual setup guide

**Layout Builder Shortcuts** (`layout_builder_shortcuts`) is a small editor‑UX
enhancement for core **Layout Builder**. While you are in the Layout Builder editing
interface, it surfaces an inline **edit shortcut** on blocks, so opening a block's
configure/edit form takes fewer clicks. On a complex layout with many inline blocks,
that saved click per edit adds up.

It is a lightweight, front‑end‑only convenience: it ships a JavaScript library and
nothing more — no new routes, no new entities, and no server‑side attack surface of
its own. It works entirely within the existing Layout Builder editing context, so
who is allowed to use it is governed by core Layout Builder's own access controls. It
depends on core Layout Builder and the core **Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it works out of the box. You
use it entirely from the Layout Builder editing interface, described below.

## How to use it

This module extends core Layout Builder, so there is nothing to set up beyond
enabling it:

1. Edit a page's layout in **Layout Builder**.
2. On the blocks in the layout, an inline **edit shortcut** is now available.
3. Use it to open a block's configure/edit form directly, without hunting through
   the contextual links first.
