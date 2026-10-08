# Facet Type Tray — manual setup guide

**Facet Type Tray** (`facet_type_tray`) bridges the
[Type Tray](https://www.drupal.org/project/type_tray) module and the
[Facets](https://www.drupal.org/project/facets) module. Type Tray lets you group
content types into named categories on the "Add content" screen; this module
exposes those same groupings as a **Search API facet**, so a search or listing
page can offer a facet that filters by the Type Tray category a content type
belongs to — rather than only by the raw machine name of each content type.

It supports a two‑level hierarchy: the parent level is the Type Tray category
(for example `resources`) and the child level is a category‑plus‑bundle value (for
example `resources.page`). Content types that have no Type Tray category assigned
are indexed under their own machine name instead of being grouped.

Under the hood it ships three plugins that work together: a **Search API
processor** that indexes each node's Type Tray category (both the category key and
the compound category/bundle value), a **Facets build processor** ("Type Tray –
Merge node types") that turns those indexed values back into readable labels, and
a **Facets sort processor** ("Sort by Type Tray categories") that orders the facet
to match the category order you defined in Type Tray.

This module has **no settings form of its own** — everything is configured on your
Search API index and on the facet, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Search API / Facets / Type Tray dependencies.

There is **no configuration page** for this module. Setup happens on the Search
API index and on the facet, described in "How to use it" below.

## Where it lives in the admin menu

Facet Type Tray adds no admin page. You configure it through **Configuration →
Search and metadata → Search API** (`/admin/config/search/search-api`) for the
index processor and field, and through the **Facets** admin pages for the facet
itself.

## How to use it

1. Make sure your content types have **Type Tray categories** assigned — types
   without a category are indexed individually under their machine name rather
   than grouped.
2. On your Search API index, open **Processors**, enable the **Type Tray**
   processor, then **re‑index** so the category and compound category/bundle
   values are stored.
3. Under the index's **Fields**, confirm the Type Tray category field is available,
   then add a **facet** for that field on your Search API‑backed view.
4. On the facet, enable the **Type Tray – Merge node types** build processor so
   raw values display as human‑readable labels, and optionally enable **Sort by
   Type Tray categories** so the facet follows your Type Tray order.
5. For the two‑level category/bundle hierarchy, also enable the facet's hierarchy
   option and choose a widget that supports hierarchy (for example the core
   checkbox widget with hierarchy turned on).
