# Configuration

All of Search API Pages' configuration happens on the **Search API Pages** admin
screen, where you create one or more search pages. Each page is exportable
configuration, so it deploys with the rest of your site.

## Open the admin screen

1. Log in as a user with the **Administer Search pages** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → Search API Pages**
   (`/admin/config/search/search-api-pages`).
3. Click **Add search page** to create one.

## Search page settings, field by field

- **Label** — the human-readable name of the page (admin-facing).
- **Path** — the URL the page serves, with no leading slash, e.g.
  `search/content`. Saving or deleting a page rebuilds the site's routes, so the
  path becomes a live page immediately.
- **Index** — the Search API index this page searches. This is the key binding:
  the index must already exist. The page adds a configuration dependency on it.
- **Searched fields** — which of the index's full-text fields to search. Leave
  it empty to search all of them, or choose a subset to narrow results (for
  example, title and body only).
- **Clean URL** *(on by default)* — when on, keywords appear in the path itself
  (`/search/content/drupal`) making URLs bookmarkable. When off, keywords go in a
  query string (`?keys=drupal`).
- **Show all when no keys** *(off by default)* — when on, the page lists all
  indexed results before the visitor has typed anything, so it doubles as a
  browsable listing.
- **Limit** *(default 10)* — how many results to show per page; this is the
  pager size.
- **Style** — how each result is rendered:
  - **View modes** *(default)* — results are rendered as full entity view modes
    (like teasers).
  - **Search results** — results are shown as compact excerpt snippets with the
    matched terms highlighted.
- **View mode configuration** — when using the "view modes" style, this lets you
  override which view mode is used per datasource/bundle.
- **Show search form** *(on by default)* — render the search form above the
  results on the page itself.
- **Parse mode** *(default `direct`)* — how the keyword string is interpreted by
  Search API. `direct` passes the phrase through as-is; `terms` splits it into
  individual terms. Choose based on whether you want exact-phrase or term
  matching.

Save the page, then visit its path to try it out.

## The search-form block

The module provides a block called **Search Api Page search block form**
(category *Forms*) so you can put a search box anywhere — a header, a sidebar,
the front page.

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Search Api Page search block form** block in a region.
3. In the block settings, choose **which search page** its submissions redirect
   to.
4. Optionally use the block's visibility conditions to show it only on certain
   pages or content types.

## Permissions

Search API Pages defines two permissions, set at **People → Permissions**
(`/admin/people/permissions`):

- **Administer Search pages** (`administer search_api_page`) — create, edit and
  delete search pages and reach the whole admin UI. This is effectively
  site-builder level; grant it only to trusted roles.
- **Use search** (`view search api pages`) — view and use the front-end search
  pages the module serves. Grant this to whichever roles (often including
  anonymous) should be able to search.

## Adding facets

Because each search page is exposed to Search API as a **display** plugin, you
can add [Facets](https://www.drupal.org/project/facets) to an individual page by
pointing a facet at that page's display. This is optional and only relevant if
you use the Facets module.
