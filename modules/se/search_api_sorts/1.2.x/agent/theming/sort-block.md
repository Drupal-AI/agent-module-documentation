# The sort block, URL params & theming

## The block

`search_api_sorts_block` (`SearchApiSortsBlock`) is a **derived** block — the deriver
`SearchApiSortsBlockDeriver` creates one derivative per Search API display
(`search_api_sorts_block:{display_plugin_id}`, admin label "Sort by (@index)"). Place the
derivative for the display whose results you want to sort.

The block renders nothing when:
- the display is not rendered in the current request, or
- no sort fields are enabled for that display.

Otherwise it builds a list of sort links (sorted by each field's `weight`), each pointing at
the current URL with updated query params.

## URL parameters

Sorting is driven entirely by two query params on the results page:

- `sort` = the `field_identifier` to sort on.
- `order` = `asc` or `desc`.

Clicking an already-active sort link flips its order. `getActiveSort()` reads these from the
request; if absent, `getDefaultSort()` supplies the display's default (the `default_sort`
field, else `search_api_relevance` `desc`).

## Caching

`getCacheMaxAge()` returns **0** — results (and therefore the sort UI) cannot be cached because
Search API may read from an external backend. Enable **BigPipe** (`big_pipe`) so the block is
lazy-rendered after the main results instead of blocking the page.

## Theme hooks

`hook_theme()` registers `search_api_sorts_sort` (one per sort link) with variables:
`label`, `url`, `order`, `active` (bool), `order_indicator`, `sort_field`. Template:
`templates/search-api-sorts-sort.html.twig`. The overall list uses
`item_list__search_api_sorts` with classes `search-api-sorts search-api-sorts--{display}`.
The active link carries a `tablesort_indicator` (asc/desc arrow). Override the twig template or
the `search_api_sorts_sort` theme hook in your theme to restyle the links.
