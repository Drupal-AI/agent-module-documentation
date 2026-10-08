# Facets — manual setup guide

**Facets** (`facets`) adds **faceted search** to your site — the clickable filters
you see alongside search results, like *Category*, *Price range*, *Brand*, or
*Tags*, that let visitors drill down and refine a result list without typing a
query. Each filter is called a **facet**. A facet targets a single **indexed
field** on a [Search API](../../../search_api/1.41.x/human-docs/index.md) index
and renders either as a **block** you place in a region or as an exposed filter
inside a view.

Because Facets works *on top of* a search index, it never reads your content
directly. Instead it attaches to a **facet source** — a Search API view or
display that has already been built and indexed — and turns the fields on that
index into interactive filters. Selecting a facet value narrows the results, and
the chosen values are kept in the page URL so a filtered view can be bookmarked
and shared.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to creating your
first facet. If you are looking for terse, token-cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Facets list page under Configuration → Search and metadata → Facets](images/list.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Search and metadata →
Facets** (`/admin/config/search/facets`). That page lists the facets you have
configured, grouped by the facet source they filter, and gives you the
**+ Add facet** button to create new ones.

## Contents

1. [Installation](installation/index.md) — install Facets with Composer and enable
   it alongside its Search API dependency.
2. [Configuration](configuration/index.md) — the Facets list page and the essential
   prerequisite: a Search API index (the facet source) with your fields indexed.
3. [Creating a facet](creating-a-facet/index.md) — ensure a facet source exists,
   then add a facet: pick the source and field, choose a widget, enable
   processors, and place the facet block.
