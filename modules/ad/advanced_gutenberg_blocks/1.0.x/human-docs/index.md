# Advanced Gutenberg Blocks — manual setup guide

**Advanced Gutenberg Blocks** (`advanced_gutenberg_blocks`) adds a set of extra
content blocks to the **Gutenberg** editor in Drupal. On a site that uses
Gutenberg for authoring, it gives editors richer building blocks — layout, media,
and content components — beyond the default block set, so they can compose pages
visually without a developer building custom blocks.

Several of the blocks work with media, which is why the module depends on
Gutenberg together with core **Media** and **Media Library**. It is purely a
content-editing and site-building feature: the blocks render authored content
through Drupal's normal render layer and have no role in access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   ensure Gutenberg and Media are in place, and enable it.

## Where it lives

There is no separate settings form. Once the module is enabled, the additional
blocks simply appear in the Gutenberg editor's block inserter when you edit
Gutenberg-authored content.

## How to use it

1. Make sure the **Gutenberg** module (and core Media / Media Library) are
   installed and that Gutenberg is enabled as the editor for the content type you
   are working with.
2. Install and enable this module (see [Installation](installation/index.md)).
3. Edit a piece of Gutenberg content and open the block inserter (the "+"). The
   extra blocks provided by this module are now available alongside Gutenberg's
   defaults — drop them in and configure them like any other Gutenberg block.
