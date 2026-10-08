<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Stats Term Blocks — agent index

Submodule of **search_api_stats**. Adds one **derivative block per Search API index** showing
the top search phrases for that index, read live from the `search_api_stats` log table. No
permissions, no config schema, no routes, no Drush.

- **Placing the block, its plugin/derivative id, the 3 settings, and the query it runs** →
  [configure/block.md](configure/block.md)

Key facts: plugin base id `search_api_stats_block`, derived to `search_api_stats_block:<index_id>`
by `Plugin/Derivative/SearchApiStatsBlock` (one per `Index::loadMultiple()`). Block settings:
`num_phrases` (default 8), `path` (default `search`), `param_name` (default `search`). Output
is themed by `search_api_stats_block` (`templates/search-api-stats-block.html.twig`) as a list
of `<path>?<param_name>=<keyword>` links with counts; rendered uncached (`max-age = 0`).
