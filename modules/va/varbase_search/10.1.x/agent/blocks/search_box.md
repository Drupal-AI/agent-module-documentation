# Blocks: the search box

Two block surfaces come from the `search_content` view (see
[../views/search_content.md](../views/search_content.md)). Like the view, these are provided by the
Varbase distribution / the `tests/varbase_search_test/` fixture, not by this module's own
`config/install/`.

## Block plugins available
- `views_exposed_filter_block:search_content-page_1` — the exposed keyword filter of the `/search`
  page, placeable as a standalone search box anywhere (this is what the shipped placement uses).
- `views_block:search_content-block_1` — the view's own "Search box" (`block_1`) display, a
  full search-results block.

## Shipped placement (Olivero)
`block.block.olivero_searchcontent` places the exposed-filter block in the Olivero theme:

| Key | Value |
|-----|-------|
| `id` | `olivero_searchcontent` |
| `plugin` | `views_exposed_filter_block:search_content-page_1` |
| `theme` | `olivero` |
| `region` | `content_above` |
| `weight` | `-10` |
| `settings.label` | `Search` (label_display: visible) |
| depends on | config `views.view.search_content`, module `views`, theme `olivero` |

To place the search box on another theme, add a block using the
`views_exposed_filter_block:search_content-page_1` plugin in the desired region, or export a
`block.block.*` config mirroring the Olivero one with the target theme.
