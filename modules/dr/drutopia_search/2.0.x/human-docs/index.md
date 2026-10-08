# Drutopia Search — manual setup guide

**Drutopia Search** (`drutopia_search`) bundles a complete content-search setup —
a Search API index, a search results page, and facets — as installable
configuration for the [Drutopia](https://www.drupal.org/project/drutopia)
distribution. It's what powers faceted search on Drutopia sites, and it works out
of the box with the other Drutopia content features (Article, Blog, Campaign,
Event, Organization, Page, People, Resource) as well as your own content types.

Enabling it imports a `search_api.index.content` index that uses Drupal's
**database** backend (`search_api_db`) — so you need no external search server —
a `views.view.search` results page, three facets (content type, date and
topics), and a Block Visibility Group for placing the search block. In a Drutopia
distribution install this feature is marked required, so it is enabled
automatically.

Because everything is configuration, operating the module is really just the
standard Search API workflow: after install you index your existing content, then
visit the search page and refine results with the facets. There is no custom
code, no routes and no permissions beyond what Search API, Views and Facets
provide. It depends on Search API, Search API DB, Facets, Views, Node, Block,
Block Visibility Groups and
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Search API / Facets dependencies.

## Where it lives in the admin menu

There is no settings form of its own. You manage the pieces it ships through the
standard admin pages:

- The **content index** is at **Configuration → Search and metadata → Search
  API** (`/admin/config/search/search-api`).
- The **search page** is a View at **Structure → Views**
  (`/admin/structure/views`).
- The **facets** are under the Facets admin, each bound to the search page's
  facet source.
- The **search block** is placed and scoped at **Structure → Block layout**
  (`/admin/structure/block`) via its Block Visibility Group.

## How to use it

1. Confirm the dependencies (Search API, Search API DB, Facets, Block Visibility
   Groups, Drutopia Core) are enabled — the distribution does this for you.
2. **Index your content:** open the Search API UI at
   `/admin/config/search/search-api`, or run `drush search-api:index content`.
3. Visit the search page and confirm results and the content-type, date and
   topics facets render.

To customise, edit the `content` index (indexed fields and processors), the
`search` View (display, filters, path) or the facets, and use the search block
visibility group to control where the search and facet blocks appear. For more
scale you can later swap the database backend for Apache Solr.
