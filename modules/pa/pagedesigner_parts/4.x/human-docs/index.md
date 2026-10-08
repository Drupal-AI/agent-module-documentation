# Pagedesigner Parts — manual setup guide

**Pagedesigner Parts** (`pagedesigner_parts`) is an extension for the
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) drag‑and‑drop page
builder that lets you build **reusable page parts**. Rather than rebuilding a common
section — a standard header, a footer, a call‑to‑action band — on every page, you design
it once as a "part" and then reference it from a block, which you place anywhere through
the normal block layout. Update the part once and every place it appears reflects the
change.

Mechanically, the module adds a **`pagedesigner_part` content type**: you create nodes
of that type and design their content with Pagedesigner. It also adds a
**"Pagedesigner part" block type** that references one of those nodes; you place that
block wherever you want the part to appear.

It extends the page builder, and the parts render authored content within the same
access model as Pagedesigner. One thing worth checking: because a part appears
everywhere it's referenced, make sure a reusable part doesn't embed anything sensitive
that would then be exposed in every location it's reused.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Pagedesigner.

This add‑on has **no separate configuration page** (its configure route is empty). You
work with it by creating `pagedesigner_part` nodes and placing "Pagedesigner part"
blocks. Set up the base [Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)
module first.

## How to use it

1. Install and enable Pagedesigner and this module (see
   [Installation](installation/index.md)).
2. Create a node of type **`pagedesigner_part`** and design its content with
   Pagedesigner.
3. Add a block of type **Pagedesigner part**, and reference the part node you just
   created.
4. Place that block through **Structure → Block layout** wherever the part should
   appear.
