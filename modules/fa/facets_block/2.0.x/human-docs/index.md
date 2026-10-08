# Facets Block — manual setup guide

**Facets Block** (`facets_block`) lets you render several search facets — and Facets
Summary blocks — inside a **single** Drupal block, instead of placing each facet as
its own separate block. If you've built a faceted Search API results page, this is
how you gather brand, color, price, and a results summary into one tidy "Filters"
panel in your sidebar, rather than juggling half a dozen block placements.

It adds one block plugin, **Facets Block**, that depends on the Facets module. You
place it in a region like any other block, and in the block's own settings form you
tick which of your enabled facets to include. At render time it pulls each selected
facet's output together, can drop facets that have no available options, and wraps
everything in a single themeable container with a distinct CSS class per facet so
you can style them individually.

Because all of its options live in the block's configuration (there's no separate
admin settings page), the whole setup exports and deploys cleanly with the rest of
your block config. The module adds no permissions or Drush commands of its own.
Note that the block is intentionally uncacheable, since facet output depends on the
current search and filter state.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires the Facets module).

## Where it lives in the admin menu

There's no dedicated settings page. You place and configure the block at
**Structure → Block layout** (`/admin/structure/block`), like any other block.

## How to use it

First make sure the **Facets** module is set up — you need a facet source and some
configured facets (typically on a Search API results view). Then:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want your filters, click **Place block** and choose
   **Facets Block**.
3. In the block's settings, under **Facets to include**, tick the facets (and any
   Facets Summary) you want combined into this one block.
4. Adjust the display options:
   - **Show title** (`show_title`, default on) — show each facet's own title inside
     the block.
   - **Exclude empty facets** (`exclude_empty_facets`, default on) — automatically
     skip individual facets that currently have no available options, so the panel
     stays clean.
   - **Hide empty block** (`hide_empty_block`, default off) — render nothing at all
     when no facets are available (for example when a search returns no results),
     rather than showing an empty container.
   - **Add JS classes** (`add_js_classes`, default off) — attach extra
     JavaScript-friendly CSS classes for custom front-end behavior.
5. **Save block.**

Each facet is output with a unique CSS class (`facet-block--<facet_id>`), and the
whole block renders through a `facets_block` Twig template you can override in your
theme for a fully custom filter layout.
