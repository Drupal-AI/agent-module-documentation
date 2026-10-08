# Layout Builder Browser Block Library — manual setup guide

**Layout Builder Browser Block Library** (`layout_builder_browser_block_library`)
is a small companion to the
[Layout Builder Browser](https://www.drupal.org/project/layout_builder_browser)
module. Layout Builder Browser gives editors a curated, categorised palette of
inline blocks to place in Layout Builder. This module adds a **"Browse Block
Library"** link next to each of those inline block options, so an editor can
either create a brand‑new inline block *or* pick an existing block from the
site's global (reusable) block library.

For example, if you have a "Banner" inline block in the Layout Builder Browser,
this module lets an editor either build a fresh Banner from scratch or drop in a
Banner they created earlier and stored in the block library — reusing content
instead of recreating it.

It has no settings form; enabling it changes what the Layout Builder Browser
offers. Because it broadens the block browser to include the whole reusable block
library, take a moment to confirm the newly‑surfaced blocks are all appropriate
for editors to place. Making a block available in the browser is a UI/availability
change, not an access grant — so protect any block with sensitive content using
the block's own access, not by keeping it off the list.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration page**. Its behaviour appears inside the Layout
Builder Browser, as described below.

## Where it lives in the admin menu

It adds no admin page of its own. The "Browse Block Library" link appears in the
Layout Builder add‑block off‑canvas panel provided by Layout Builder Browser,
which you reach whenever you build a layout (for example **Structure → Content
types → *(type)* → Manage display → Layout**).

## How to use it

1. Make sure the base **Layout Builder Browser** module is installed and
   configured with its curated block categories.
2. In a Layout Builder layout, click **Add block** to open the browser.
3. Alongside each inline block option you will now see a **Browse Block Library**
   link. Use it to select an existing reusable block from your block library
   instead of creating a new inline block.
