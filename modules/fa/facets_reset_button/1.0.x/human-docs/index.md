# Facets Reset Button — manual setup guide

**Facets Reset Button** (`facets_reset_button`) adds one small, useful control to
a faceted search page: a **"Reset filters"** link that clears every active facet
at once. Instead of un‑checking filters one by one, a visitor clicks it and lands
back on the unfiltered results.

The module provides a single block. When placed, the block renders a link that
points at the current page with the entire URL query string removed — and since
Search API facets normally live in query parameters, dropping the query string
clears them all. A little bundled JavaScript keeps the link tidy: it only shows
when at least one checkbox facet is currently ticked, and hides itself when
nothing is filtered. The block is intentionally uncacheable so it always matches
the live search results.

It builds on the **Facets** module and is meant for a Search API + Facets listing
whose filters are applied through URL query parameters. There is nothing to
configure beyond placing the block; you can style it with its CSS classes or
override its Twig template if you want different markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. You work with it at **Structure → Block layout**
(`/admin/structure/block`), where you place the **Facets Reset Button block**
(found under the *Facets* category) into a region.

## How to use it

1. Go to **Structure → Block layout** and click **Place block** in the region
   that holds your facet blocks — typically the sidebar of your Search API +
   Facets search page.
2. Find **Facets Reset Button block** (category *Facets*) and place it.
3. Under the block's **Visibility** settings, restrict it to your search page(s)
   — for example by request path — so the reset link only appears where facets
   are in use.
4. Save the block. On the search page, a **Reset filters** link now appears
   whenever at least one checkbox facet is active; clicking it returns the visitor
   to the unfiltered results.

Customizing it:

- Change the label by translating the **"Reset filters"** string (via Drupal's
  interface translation).
- Change the markup by overriding the `facets-reset-button.html.twig` template in
  your theme.
- Style it with the `facets-reset-button` wrapper class and the
  `facets-reset-link` link class.

Good to know:

- The reset works by dropping the URL query string, so it clears facets stored as
  **query parameters**. Facets encoded into the URL **path** (for example via
  *Facets Pretty Paths*) are not cleared by this button.
- The show/hide JavaScript keys off **checkbox‑widget** facets, so the link's
  automatic visibility is designed around checkbox facets.
