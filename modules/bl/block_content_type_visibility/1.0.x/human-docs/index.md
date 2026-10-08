# Block Content Type Visibility — manual setup guide

**Block Content Type Visibility** (`block_content_type_visibility`) adds a new
visibility rule to Drupal's block system: show or hide a block depending on the
**content type of the node being viewed**. For example, you can place a
"Related products" block and set it to appear only on *Product* pages, or show a
promotional block only on *Article* nodes.

Drupal core already lets you limit a block by path, by role, or by language.
This module adds one more choice to that same list — a **content type**
condition — so you can target blocks at the kinds of content you actually
publish, instead of maintaining fragile lists of URLs. It depends only on core's
Block and Node modules and works on Drupal 11.

Keep one thing in mind: this controls *visibility*, not *access*. Hiding a block
does not protect whatever the block contains — it only stops the block from
being drawn on pages that don't match. If the content needs to be genuinely
restricted, use Drupal's permissions and access controls, not this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. Once enabled, its condition appears inside
the block placement form at **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** and either place a new block or configure
   an existing one.
2. On the block's configuration form, find the **Visibility** section (the same
   place you'd set path or role conditions).
3. Open the **Content type** condition and tick the content types the block
   should appear on (for example, only *Article*). Leave it empty to show the
   block on any page.
4. Save the block. It will now render only when the visitor is viewing a node of
   a matching type.

There is no separate settings page — everything is configured per block, right
alongside the visibility rules Drupal already provides.
