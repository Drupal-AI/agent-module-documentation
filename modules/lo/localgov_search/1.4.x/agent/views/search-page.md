# Search results view and `/search` page

Config: `views.view.localgov_sitewide_search` (id `localgov_sitewide_search`), base table
`search_api_index_localgov_sitewide_search`, base field `search_api_id`.

## Displays

| Display | Plugin | Path |
| --- | --- | --- |
| `default` (Master) | default | — |
| `sitewide_search_page` | page | `/search` |

## What the view does

- **Access**: permission `access content` (`access.type: perm`).
- **Query** (`search_api_query`): `bypass_access: false`, `skip_access: false` — the query
  does **not** bypass Search API access checking.
- **Exposed filter**: `search_api_fulltext` on field `rendered_item`, exposed as identifier
  **`s`**, label "Search", `required: true`, `parse_mode: terms`. This is the `?s=` query
  parameter the block and page submit.
- **Sort**: `search_api_relevance` DESC (not exposed).
- **Row**: `search_api` row plugin; `view_modes['entity:node']` per bundle = `search_result`
  (filled in by the auto-enrol hook).
- **Style**: `html_list` as an `<ol>` with wrapper classes
  `search-results lgd-search-results-list`.
- **Pager**: full pager, 10 items per page, quantity 9.
- **Header**: text area `<h2>Search results</h2>` plus a result-summary
  (`Showing items @start to @end of @total results`).
- **Empty**: text area `"<p>No results</p><p><a href="/search">Reset search</a></p>"`.
- **Cache**: tag-based; cache contexts include `url.query_args`, `user.permissions` and
  `user.node_grants:view`.

## Runtime behaviour (from `localgov_search_views_pre_render()`)

Applies only to this view / the `sitewide_search_page` display:

- If there is **no `s` query parameter** (`\Drupal::request()->query->get('s') === NULL`),
  the header and empty areas are blanked — a bare search form shows before the first query,
  with no "No results" message.
- Otherwise, when there are results (`total_rows > 0`), the title becomes
  `"{search term} - {view title}"`. Per the source comment this sets the **header title
  only, not the HTML page title** (localgov_core issue #93).

## Reuse

To add facets, sorting, or a second results display, clone/extend this view or point another
Search API view at the same `localgov_sitewide_search` index. The exposed identifier `s`
must stay consistent with the block if you reuse [the block](../blocks/sitewide-search-block.md).
