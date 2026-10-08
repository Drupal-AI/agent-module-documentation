# Entity Submenu Block — manual setup guide

**Entity Submenu Block** (`entity_submenu_block`) gives you a block that shows the
current page's **submenu items as fully rendered content entities** — for example
as node teasers — instead of a plain list of links. When a visitor is on a page
within a menu, the block finds that page's child menu links and renders each one
that points to a content entity, in a view mode you choose.

The problem it solves is building "in this section" or "section landing" navigation
that shows more than link text — teaser images, summaries, and fields — and stays
automatically in sync with your menu structure. Rather than hand-building a related
pages view and keeping it aligned with the menu, you place this block and it
follows the active menu trail: as the visitor moves through a section, the block
shows the children of wherever they are.

It's built on core's System Menu Block, so it gives you one derived block **per
menu** (main, footer, or any custom menu). For each block you pick which view mode
to use per entity type (e.g. render child `node` links as teasers,
`taxonomy_term` links in their default view mode), and you can optionally show
non-entity or external menu links as ordinary links too. Everything works with
core's Block layout — no extra library, no dependencies beyond core's **Block**
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated configuration page** for this module — each block is
configured where you place it, in **Block layout**. See "How to use it" below.

## Where it lives in the admin menu

You add and configure Entity Submenu blocks at **Structure → Block layout**
(`/admin/structure/block`), using core's **administer blocks** permission. Each
menu on your site provides its own derived block, labeled with the menu name plus
"(Entity Submenu Block)".

## How to use it

1. Go to **Structure → Block layout** and click **Place block** in the region you
   want (a sidebar is typical for "in this section" navigation).
2. Choose the Entity Submenu block for the menu you want to follow (for example
   the main navigation menu).
3. In the block's settings, configure:
   - **View modes** — for each content entity type, pick the view mode to render
     its child links (e.g. `node` → *Teaser*). Select **- None -** to skip a type.
   - **Display non-entities** — turn on to also render menu links that aren't
     content entities (or that are external) as simple `<a>` links.
   - **Only current language** — skip entities that aren't translated in the
     current language.
   - **Show the block, even if empty** — keep the block's wrapper on the page even
     when there are no child items (useful as a template placeholder); by default
     the block simply doesn't render when a page has no children.
4. Optionally use core's Block layout **visibility conditions** (pages, roles,
   content types) to scope where the block appears, then save.

The output goes through the `entity_submenu` / `entity_submenu_item` theme hooks,
so you can override `entity-submenu.html.twig` / `entity-submenu-item.html.twig`
(and use the `entity_submenu__<menu>` template suggestion) to customize the markup.
