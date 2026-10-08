# Alter blocks element markup — manual setup guide

**Alter blocks element markup** (`alter_blocks_element_markup`) lets site builders
change the **wrapper element, markup, and CSS classes** of a rendered block —
without writing a custom theme template override. Normally, changing the HTML tag a
block is wrapped in, or adding classes to it, means creating and maintaining a Twig
override in your theme. This module moves that choice into the block's own
configuration instead.

When enabled, it adds settings to the block configuration form where you pick the
wrapper HTML tag and the classes to apply, and it ships a `block.html.twig`
template (plus a config schema) that renders your choices. Because the settings are
stored in configuration, they travel with your configuration export and don't
require code.

It depends on core's **Block** module, works on Drupal 9.3+ and 10, and has no
permissions or routes of its own — the configuration is per block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. The options appear **on each block's own
configuration form**, which you reach from **Structure → Block layout**
(`/admin/structure/block`) when you place or configure a block.

## How to use it

1. Go to **Structure → Block layout** and configure (or place) a block.
2. On the block's configuration form, use the added options to choose the
   **wrapper HTML tag** and any **CSS classes** for the block.
3. Save the block. The chosen wrapper element and classes are applied to that
   block's rendered markup via the module's template.

Repeat per block — each block keeps its own markup settings in configuration.
