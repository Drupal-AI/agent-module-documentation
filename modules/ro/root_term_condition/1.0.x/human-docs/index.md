# Root term condition — manual setup guide

**Root term condition** (`root_term_condition`) adds a single, focused **block
visibility condition**: show a block only on the pages of **top‑level (parentless)
taxonomy terms**. A "root" term is one that sits at the top of its vocabulary's
hierarchy — it has no parent term above it.

This is handy when you want something to appear on your main category pages but
not on their sub‑category pages. For example, on a "Products" vocabulary you could
show a category banner or an intro block only on the root category pages
(Electronics, Clothing, Home) and keep it off the deeper term pages beneath them.

The module does one thing and does it well. It adds no admin settings page of its
own — instead it plugs a new option into Drupal's standard block placement
screen, right alongside the built‑in visibility conditions like "Content types"
and "Pages". It relies on core's **Taxonomy** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** — you use the condition directly on
each block's placement/visibility settings, described below.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a new block, or edit an existing one, in the region you want.
3. In the block's configuration, open the **Visibility** settings and find the
   condition provided by this module (for parentless / root taxonomy terms).
4. Enable it so the block is restricted to root‑term pages, then save the block.

From then on, that block appears only on the pages of taxonomy terms that have no
parent.
