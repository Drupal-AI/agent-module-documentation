# Paragraph Block — manual setup guide

**Paragraph Block** (`paragraph_block`) makes your existing **paragraph types
available as block types**, so the same components you already built with
Paragraphs can be placed through Drupal's block layout or **Layout Builder** —
without rebuilding them as separate block content types. It stores the data in
Drupal core's ordinary block content entity, which keeps the implementation
minimal and gives you a solid out‑of‑the‑box experience, and it offers
per‑paragraph‑type configurability so each type can behave the way you want when it
is placed as a block.

The problem it solves is a common one. Many sites built their component library on
Paragraphs before Layout Builder was a realistic option. When they later adopt
Layout Builder — which places *blocks* — everything the editors know how to build
is a *paragraph*. The alternatives are to rebuild every component as a block type,
to keep two parallel component sets, or to bridge. Paragraph Block is the bridge: a
component built years ago becomes placeable in a layout without being rewritten and
without asking editors to learn a second vocabulary.

It is most valuable as a **migration path**, and least valuable as a permanent
architecture. If you run both systems indefinitely, every new component needs a
"which is it?" decision that drifts by whoever built it — which is how a site ends
up with three different ways to place a call‑to‑action. The healthy pattern is:
bridge now, agree a direction, and let new work follow it.

Two things are worth checking on a real content model before you commit. First,
**translation** — paragraphs and block content translate differently, so a
component that was translatable as a paragraph may not behave the same as a block.
Second, **nested paragraphs** — a component that contains other paragraphs is
exactly where a bridge like this tends to break, so confirm those survive.

Note that this is *not* the similarly named "Paragraph Blocks" module (which places
the paragraphs of a given node into that node's Layout Builder layout). Paragraph
Block is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   and enable it.

There is **no central settings page** for this module; configurability is per
paragraph type, and you work with the components through the normal block / Layout
Builder UI.

## Where it lives in the admin menu

Paragraph Block does not add a settings page of its own. Once enabled, your
paragraph types appear alongside block types when you place blocks — through
**Structure → Block layout** (`/admin/structure/block`) or through **Layout
Builder** on any layout‑enabled entity — and their block content is managed with
core's block content (**Content → Blocks**).

## How to use it

1. Install and enable Paragraph Block and its dependencies (see
   [Installation](installation/index.md)).
2. Place a component: open Layout Builder on a layout‑enabled entity (or the block
   layout), add a block, and choose one of your paragraph types from the list — it
   is now placeable like any block, no rebuild required.
3. Before rolling it out widely, test the two risk areas on your real content:
   confirm a bridged paragraph keeps the **translation** behaviour you need, and
   that any **nested paragraphs** inside a component still render correctly when
   placed as a block.
4. Decide your direction — Paragraphs or blocks for new components — and document it
   so the team does not accumulate duplicate component types.
