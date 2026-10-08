<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operating Drutopia Search

## What gets installed
All configuration lives in `config/install`:
- `search_api.index.content` — a Search API index using the **database** backend (`search_api_db`) over site content.
- `views.view.search` — the search results page View (facet source `search_api__views_page__search__page_1`).
- `facets.facet.search_content_type`, `facets.facet.search_date`, `facets.facet.search_topics` — three facets, plus `facets.facet_source.*` binding them to the search View page.
- `block_visibility_groups.block_visibility_group.search` — visibility group for placing the search/facet blocks.

## First-run steps
1. Ensure the dependencies (Search API, Search API DB, Facets, Block Visibility Groups, drutopia_core) are enabled — the distribution does this automatically.
2. Index content: Search API UI at `/admin/config/search/search-api`, or `drush search-api:index content`.
3. Visit the search View page and confirm results + facets render.

## Customising
- **Indexed fields / processors:** edit the `content` index.
- **Results display / filters / path:** edit the `search` View.
- **Facets:** adjust or add facets under Facets admin; each is bound to the search page facet source.
- **Blocks:** the search block visibility group controls where the search/facet blocks appear.

The README lists faceted search as a "potential future feature", but the shipped config already includes the three facets above.
