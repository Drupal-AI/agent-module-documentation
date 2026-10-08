# Configuration

Setting up Taxonomy Facets is two jobs: adjusting the module's settings (mainly
the browse base path), and placing one or more facet‑menu blocks so visitors can
click through the filters.

## Open the settings form

1. Log in as an administrator.
2. Open the **Taxonomy Facets settings form** (`taxonomy_facets.settings_form`)
   from the module's admin link.

Here you configure how the faceted browsing behaves — most importantly the
**base path** at which the node listing lives (the default is `/browse`). The
listing at that path shows the nodes matching the intersection of all the terms
in the URL.

## How the URLs and filtering work

You do not build these URLs by hand — the facet menus generate them — but it
helps to know the shape:

- Each URL segment after the base path is a **taxonomy term's URL alias**, so
  your vocabulary terms need aliases.
- Hierarchical terms are written as their **full ancestor trail, root first**
  (for example `/browse/europe/balkan/dalmatinska`), so the hierarchy shows in
  the address bar. Only the leaf term filters; the ancestors are just the
  readable trail.
- **Intersection:** terms from different vocabularies are AND‑ed together, and
  multiple terms from a single multi‑value vocabulary are AND‑ed too.
- **Hierarchical cascade:** selecting a parent term also matches content tagged
  with any of its descendants, to any depth.
- Segments are ordered canonically, so every combination of filters has exactly
  one URL.

## Place a facet‑menu block

The facet menus are rendered by a configurable **block**, one vocabulary per
block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the Taxonomy Facets menu block in a region (for example a sidebar),
   choosing the vocabulary it should render.
3. Configure the block's options and save.

Once placed, the block renders that vocabulary as nested HTML links. Selecting a
term applies it — replacing any current term from the same vocabulary while
preserving your other facets — and each active facet gets a **remove** link.

### Collapse hierarchy (drill‑down) — optional, per block

Each facet block has a **Collapse hierarchy** option. With it on, the menu starts
at the top level, and selecting a term both applies the filter and reveals its
children, while every other branch stays closed. Because the open state is simply
the selected term's own page, this drill‑down needs no JavaScript and behaves
identically in a static export. Openable items get a CSS disclosure caret
(pointing right when closed, down when open) via `is-collapsed` / `is-open`
classes that your theme can restyle.

## Contextual counts

Facet menus can show, next to each term, how many results selecting it would
produce — a helpful cue for visitors deciding where to drill next.

## A note on crawling and duplicate content

Because every facet combination is its own URL, the site can generate a very
large number of crawlable pages. Keep search‑engine crawl budget and
duplicate‑content in mind, and consider enabling the **XML Sitemap** submodule
(`taxonomy_facets_simple_sitemap`) to surface the URLs deliberately. The listed
content always respects its own access permissions; Taxonomy Facets only shapes
how listings are filtered.
