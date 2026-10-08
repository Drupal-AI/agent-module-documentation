<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Search is the search-UI layer of the Islandora ecosystem: on top of Search API Solr and Facets it adds an advanced (field + boolean) search block, a simple global search block, and a results pager block, and it AJAX-refreshes the facet, pager and exposed-filter blocks so a Solr view feels like a live, filterable search page.

---

A plain keyword box stops being enough once users need to combine conditions — this field is that, that field is not this, joined with AND/OR — and to page, sort and switch between list and grid without a full reload. Assembling that from Search API, Solr, Facets and Views by hand is fiddly and easy to get inconsistent. Advanced Search packages it: a multi-row query builder block that rewrites the Solr (eDisMax) query directly so real boolean and phrase queries score correctly, a pager block with per-page counts and a list/grid toggle, and JavaScript that keeps facets and the pager in sync over AJAX. It also understands Islandora collections, so a search can optionally recurse into sub-collections by relaxing the display's contextual filter.

Because it rewrites the Solr query rather than the Search API query, it is strictly for sites already running Search API against Solr: it depends on Facets, Facets Summary and Search API Solr and enhances an existing Solr-backed index rather than providing one. Global behaviour is configured at /admin/config/search/advanced (permission "administer site configuration") and the search-view blocks are derived per Search API display, so you place the Advanced Search and Search Results Pager blocks for the specific view/display you want to power. Confirm the index exposes the fields and facets you want to offer, since the blocks surface what Search API and Facets are configured to provide.

For a collection-heavy repository — the typical Islandora case — it turns a stack of search-related configuration into ready blocks: a rich query builder, faceted narrowing with a summary of active filters, and a results pager the visitor controls.

---

- Add a multi-row advanced (field + boolean) search block.
- Let users combine conditions with AND, OR and NOT.
- Search all fields with a single keyword box (Simple Search Block).
- Rewrite the Solr query with the eDisMax parser for real boolean/phrase queries.
- Restrict the all-fields search to specific Search API fields.
- Search an Islandora collection and recurse into its sub-collections.
- Toggle results between list and grid layout.
- Let visitors choose how many results show per page.
- Expose sort options on the results pager.
- Add a Search Results Pager block to a Solr-backed view.
- AJAX-refresh facets, pager and exposed filters without a page reload.
- Show a summary of the active search query and facets.
- Re-show active facets hidden by other facet processors.
- Show facet values present in the URL but missing from the result.
- Reset all facets and the query (and return to page 1) with one link.
- Truncate long facet labels to a set length.
- Add rel="nofollow" to pager and display links.
- Redirect a simple search box to a chosen search results page.
- Show a count of child/referenced items in a collection field.
- Turn a reference field label into a link to a faceted search.
- Restrict a block to nodes with a given term (collection-only blocks).
- Customise the URL query keys and facet add/remove operators.
- Provide highlighted Solr search snippets in results.
