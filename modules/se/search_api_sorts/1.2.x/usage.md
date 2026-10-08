Search API Sorts lets site builders expose a block of clickable **sort options** (e.g. "Sort by price / date / relevance") for a Search API search display, letting visitors reorder results by any single-value indexed field.

---

The module attaches to a Search API **display** (any instance where an index is shown - a Views page/block backed by the index, a Search API Pages page, etc.). For each display you enable one or more sortable fields on a "Manage sort fields" form (a tab under the index at `/admin/config/search/search-api/index/{index}/sorts`, guarded by the core `administer search_api` permission). Each enabled field is stored as a `search_api_sorts_field` **config entity** (id `{escaped_display_id}_{field_identifier}`) carrying its `label`, `weight`, `default_order` (asc/desc) and whether it is the `default_sort`. A derived block plugin (`search_api_sorts_block:{display}`, one derivative per display via `SearchApiSortsBlockDeriver`) renders the enabled sorts as toggle links that set `?sort=<field>&order=<asc|desc>` on the current URL. At query time an event subscriber (`SearchApiSortsQueryPreExecute`) reads the active sort from the request (or the configured default) and applies it to the Search API query. Because search results cannot be cached reliably, the sorts block has `max-age = 0` and is best delivered via BigPipe. Two alter hooks (`hook_search_api_sorts_active_sort_alter`, `hook_search_api_sorts_default_sort_alter`) let modules rewrite the chosen field/order in code. Only single-value string/number fields are offered (fulltext and multi-value list fields are skipped).

---

- Add a "Sort by" block to a Search API results page (price, date, title, popularity).
- Let visitors flip result order between ascending and descending with one click.
- Set a default sort (e.g. newest first) for a search display out of the box.
- Expose relevance as one selectable sort option alongside field sorts.
- Provide different sort options per display (search page vs. a search block).
- Order an e-commerce faceted search by price low-to-high or high-to-low.
- Sort a catalogue by title A→Z using an indexed string field.
- Sort news/search results by "last updated" date descending by default.
- Give editors a "Manage sort fields" screen to curate which fields are sortable.
- Relabel a sort option (e.g. show "Newest" instead of the raw field name).
- Control the order sort links appear in via per-field weight.
- Programmatically override the active sort for anonymous users via hook_search_api_sorts_active_sort_alter().
- Force a fixed default sort in code with hook_search_api_sorts_default_sort_alter().
- Combine sort links with Search API Facets for a full filter+sort UI.
- Drive sorting purely from URL query params (`?sort=field&order=desc`) for shareable links.
- Deliver the uncacheable sorts block efficiently by enabling BigPipe.
- Restrict who can configure sorts using the core administer search_api permission.
- Remove obsolete sort fields automatically when an index's fields change.
- Offer a "Relevance" default that falls back when no explicit sort is chosen.
- Sort a directory/listing search by a numeric distance or rating field.
- Add sort toggles to a Solr-backed search without touching Solr config.
- Export the sort configuration as `search_api_sorts.search_api_sorts_field.*` config for deployment.
- Present sort direction indicators (asc/desc arrows) on the active sort link.
- Let multiple search displays on one site each have their own independent sort set.
