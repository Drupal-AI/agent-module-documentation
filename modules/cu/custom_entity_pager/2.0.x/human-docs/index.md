# Custom Entity Pager — manual setup guide

**Custom Entity Pager** (`custom_entity_pager`) adds previous/next ("pager")
navigation between entities — so a node page can offer links to the previous and next
item in a sequence, letting visitors browse articles, products, or gallery items one
after another. Its design goal is **performance, not features**: it renders the pager
through a lightweight custom Twig function rather than building it on top of Views, so
it stays fast on sites with a lot of nodes.

That focus comes with an important characteristic: **this module has no GUI.** It is
meant for developers. There is no settings page and no drag‑and‑drop block to place —
you wire the pager into your theme's Twig templates using the function the module
provides. If you'd rather configure a pager through the admin UI, the module's own
documentation points to alternatives — *Flippy* and *Previous/Next API* render their
pagers as blocks, and *Entity Pager* uses Views — each trading some of Custom Entity
Pager's performance for point‑and‑click configuration.

It has no dependencies and works on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no GUI. You use it from your
theme's Twig templates, as described in "How to use it" below.

## How to use it

Custom Entity Pager provides a custom Twig function that renders the previous/next
pager for the current entity. To add the pager:

1. Identify the Twig template where you want the pager to appear — typically a node
   template such as `node--article.html.twig` in your theme.
2. Call the module's pager Twig function in that template at the position you want the
   prev/next links, then rebuild caches (`drush cr`).
3. Style the rendered links with your theme's CSS.

Because it renders from the entity's natural sequence rather than a configurable UI,
placement and behaviour are decided in code. Consult the module's README for the exact
Twig function name and any arguments it accepts for the branch you installed.
