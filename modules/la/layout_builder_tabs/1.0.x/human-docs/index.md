# Layout Builder Tabs — manual setup guide

**Layout Builder Tabs** (`layout_builder_tabs`) adds a single new section type —
**Tabs** — to Drupal's core Layout Builder. Once the module is enabled, whenever
you build a layout you can drop in a Tabs section, and every block you place
inside it becomes its own tab, complete with an accessible tab list and matching
content panes. There is nothing to click through the block-by-block yourself:
the tabbed markup is generated for you.

It is a lightweight, focused module. It registers one layout plugin, has a single
region, and depends only on core's **Layout Discovery** module. There is no
settings form, no permissions, and no Drush commands — you use it entirely by
adding a Tabs section inside Layout Builder. Tab labels come from each block's
title (falling back to the block's configured label), and you reorder the tabs
simply by reordering the blocks in the section.

When the active theme is Olivero, the tabs automatically pick up Olivero's own
tab styling; under any other theme the module attaches its own lightweight CSS
and JavaScript to switch tabs on the rendered page. Inside the Layout Builder
editor the section shows a simplified stacked preview (each block under its
label) so the editing UI stays usable — the real tabs appear on the live page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module has no configuration page. Its only "setting" is choosing the Tabs
layout for a Layout Builder section:

1. Turn on Layout Builder for a display: **Structure → Content types → [type] →
   Manage display**, then tick **Use Layout Builder** (optionally allow each
   content item to have its layout customized).
2. Click **Manage layout** (or edit an individual entity's layout).
3. Choose **Add section**, then pick **Tabs** (listed under the *Extra Layouts*
   category).
4. Choose **Add block** to drop blocks into the section — each block becomes one
   tab. The tab label is the block's rendered title, falling back to its
   configured label.
5. Reorder the blocks to reorder the tabs (they sort by each block's weight).
6. **Save layout**.

Because the choice is stored on the entity view display, a Tabs layout travels
with your configuration export like any other Layout Builder section.
