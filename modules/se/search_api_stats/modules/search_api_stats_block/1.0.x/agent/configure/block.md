<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing and configuring the top-terms block

## The block plugin

`src/Plugin/Block/SearchApiStatsBlock.php` defines block base id **`search_api_stats_block`**
with `deriver = SearchApiStatsBlock`. The deriver
(`src/Plugin/Derivative/SearchApiStatsBlock.php`) calls `Index::loadMultiple()` and creates
**one derivative per Search API index**, so the placeable plugin id is
`search_api_stats_block:<index_machine_name>` with admin label
"Search API stats block: <index label>". **If the site has no Search API index, no derivative
exists and there is nothing to place.**

## Settings (blockForm)

| Setting | Key | Default | Meaning |
|---|---|---|---|
| Number of top search phrases to display | `num_phrases` | 8 | how many keywords to list (options 2-20, 25, 30) |
| Path of search page | `path` | `search` | path each keyword links to |
| Parameter name for the search phrase | `param_name` | `search` | query-string key in the link |

## What it renders

`build()` calls `getStats()`, which runs (server = the index's `server`, index = the
derivative id):

```sql
SELECT keywords, COUNT(*) AS num FROM search_api_stats
WHERE s_name = :s_name AND i_name = :i_name AND keywords != ''
GROUP BY keywords ORDER BY num DESC   -- limited to num_phrases
```

The result is passed to the `search_api_stats_block` theme hook, whose
`templates/search-api-stats-block.html.twig` prints an `<ul>` of links
`<a href="{{ path }}?{{ param_name }}={{ keyword }}">{{ keyword }} ({{ num }})</a>`. The build
sets `#cache['max-age'] = 0`, so counts are always live (never cached).

## Placing it

Use the core Block UI (`/admin/structure/block`) → *Place block* → pick "Search API stats
block: <your index>" → set num_phrases / path / param_name → choose a region. Or create a
`block.block.*` config entity with `plugin: search_api_stats_block:<index_id>` and those
settings. Requires the core `block` module and the `administer blocks` permission to place.
