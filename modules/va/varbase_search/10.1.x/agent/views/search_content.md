# View: `search_content` — the site search page & index

The search page/view and its `content` index are the search **result** of this module's ecosystem.
They ship in the `tests/varbase_search_test/` recipe/fixture here and are provided by the Varbase
distribution at the site level (this module's own `config/install/` is empty). Documented here
because they are what `search_api.server.database_server` (see
[../configure/search-setup.md](../configure/search-setup.md)) exists to serve.

## The index: `search_api.index.content`
- `id: content`, `server: database_server`, tracker `default` (fifo), `read_only: false`.
- Options: `index_directly: true`, `cron_limit: 50`, `delete_on_fail: true`,
  `track_changes_in_references: true`.
- Datasource `entity:node` — all bundles, all languages.
- Fields:

| Field | Type | Notes |
|-------|------|-------|
| `rendered_item` | text | Rendered HTML of the node, **rendered as the `anonymous` role**, `full` view mode for `article`/`page` |
| `title` | text | `boost: 2.0` |

- Processors: `html_filter` (tag boosts h1=5, h2=3, b/strong=2, …), `ignorecase`, `tokenizer`
  (`minimum_word_size: 3`), `rendered_item`, `add_url`, `language_with_fallback`, plus stubs.
  There is **no `content_access` processor** in this fixture (see node-access note below).

## The view: `views.view.search_content`
- `base_table: search_api_index_content`, label "Site search".
- Displays:

| Display | Plugin | Path / placement |
|---------|--------|------------------|
| `default` | — | shared config |
| `page_1` | page | path `/search`, `exposed_block: true` |
| `block_1` | block | "Search box" block (`Site search box`) |

- Exposed filter: `search_api_fulltext` on `search_api_fulltext`, operator `and`, parse mode
  `terms`, exposed identifier `search`, label "Search the site".
- Sort: `search_api_relevance` DESC. Pager: `mini`, 10 items. Row style: Search API rendering with
  node view mode `teaser` for `article`/`page`. Empty text: "No results found for your search."
- Display access: `type: none` — the `/search` page itself is open; visibility of results is
  governed by what is in the index and by node grants (below).

## Node access
Every display's `cache_metadata.contexts` includes **`user.node_grants:view`** (alongside
`languages:language_interface`, `url`, `url.query_args`), so rendered results vary per the viewing
user's node view grants. The index's `rendered_item` is rendered as the `anonymous` role, so the
indexed HTML body reflects only anonymous-visible output. For per-user grant filtering of which
items appear at query time, Search API's **"Content access" (`content_access`) processor** must be
enabled on the index — it is not present in this fixture, so a site relying on node access grants
should confirm that processor is enabled on its production `content` index.
