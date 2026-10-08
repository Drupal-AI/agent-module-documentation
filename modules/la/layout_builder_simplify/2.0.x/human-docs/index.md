# Layout Builder Simplify — manual setup guide

**Layout Builder Simplify** (`layout_builder_simplify`) makes core **Layout
Builder**'s "Choose a block" screen easier to work with on sites that have a lot of
blocks. Core shows every available block in a single long off‑canvas list. This
module replaces that with a **category‑first**, two‑step chooser: the first screen
lists only the block **categories**, and picking a category opens a second screen
showing just that category's blocks, with a name filter and a "Back" link to return
to the category list.

The **Custom** category is handled specially: instead of listing everything, it
shows the 20 most‑recently‑updated content blocks and adds a type‑ahead
**autocomplete search**, so on a site with a large custom‑block library editors can
type part of a block's label to find it quickly. Each entry in the recent list shows
the block's type and when it was last changed.

It is a drop‑in enhancement — enabling the module changes the chooser everywhere
Layout Builder is used, and there is nothing to configure. Block *placement* still
runs through core's own routes, so who may place a block and what access those blocks
have is unchanged. It depends on core Layout Builder (and core System).

The autocomplete uses an endpoint, `/block-search.json`, that requires the *access
content* permission and returns custom‑block labels, UUIDs and type labels for keyword
matches.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — enabling it changes the block
chooser immediately. How the new chooser behaves is described below.

## How to use it

Nothing to set up beyond enabling the module. Wherever Layout Builder is used:

1. Edit a page's layout in **Layout Builder** and click **Add block**.
2. The off‑canvas chooser now shows block **categories** first.
3. Click a category to see just that category's blocks, and type in the filter to
   narrow the list. Use **Back** to return to the category list.
4. Under **Custom**, you'll see the 20 most recently updated content blocks, plus a
   search box that autocompletes custom blocks by their label as you type.
