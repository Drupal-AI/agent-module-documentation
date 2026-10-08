# Facets Range Input — manual setup guide

**Facets Range Input** (`facets_range_input`) adds a min/max range‑input widget
to the [Facets](https://www.drupal.org/project/facets) module. Instead of asking a
visitor to tick individual values, it presents two boxes — a lower bound and an
upper bound — so results can be filtered by a *range*. That is the natural
interface for numeric or date facets: a price between 20 and 80, a publication
date between two years, a rating from 3 upward.

It is purely a search‑UI feature. It shapes how a facet is presented and queried;
it does not change access control, and results still respect the underlying search
index and entity access. The module depends only on Facets and works with any
Facets source (Search API and friends).

There is no separate settings page. You turn the widget on where every other facet
option lives — the individual facet's edit form — so the "configuration" for this
module is really just choosing it as the widget for a numeric or date facet.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Facets.

There is **no module‑wide configuration page** — the widget is selected on each
facet, described in "How to use it" below.

## Where it lives in the admin menu

Facets Range Input adds no admin page of its own. You use it from **Configuration →
Search and metadata → Facets** (`/admin/config/search/facets`), on the edit form of
the specific facet you want to filter by range.

## How to use it

1. Make sure you already have a working faceted search: a Search API index and a
   facet source, with at least one facet built on a **numeric or date field**
   (price, year, rating, and so on).
2. Edit that facet at **Configuration → Search and metadata → Facets** and open its
   settings.
3. For the facet's **widget**, choose the range‑input widget this module provides.
   The facet will now render as a *minimum* and *maximum* input instead of a list of
   discrete values.
4. Save the facet. On the search page, visitors enter a min and a max to narrow the
   results to that range.

Use it wherever a numeric or date facet reads better as "between X and Y" than as a
long list of individual values.
