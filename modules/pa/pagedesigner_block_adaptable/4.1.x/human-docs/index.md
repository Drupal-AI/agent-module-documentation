# Pagedesigner block filter — manual setup guide

**Pagedesigner block filter** (`pagedesigner_block_adaptable`) is an add‑on for the
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) drag‑and‑drop page
builder. It lets you create blocks whose output can be **customised and filtered per
element** within Pagedesigner — so a block placed inside built‑page content can adapt
what it shows depending on the element it sits in. In practice this is used to build
blocks (for example Views‑backed listings) that are configurable directly from the
Pagedesigner interface.

It is a content‑display / site‑building feature: it affects how blocks render inside
Pagedesigner pages. It does not change the blocks' own access rules and has no
access‑control role of its own — each block keeps whatever access it already had.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Pagedesigner.

This add‑on has **no configuration page of its own** (its configure route is empty).
You use it from within the Pagedesigner editor, where the block's output is customised
per element. Set up the base [Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)
module first.

## How to use it

1. Install and enable both Pagedesigner and this module (see
   [Installation](installation/index.md)).
2. Edit content that uses Pagedesigner. Place a block element, and use the per‑element
   options this module adds to adapt/filter its output.
3. Save the page.

> **Upgrading from an older major version?** In 3.x the Views filters
> `nid_views_filter` and `tid_views_filter` were removed and replaced by a single
> `pba_entity_filter`, which is a breaking change. The supported path is to first
> upgrade to 2.5.y and run the update hooks (which convert existing Views and data to the
> new filter), and only then move on to 3.x / 4.x.
