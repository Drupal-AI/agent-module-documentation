<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Stats Term Blocks adds a block that lists the most-searched keywords for a given Search API index, read from the log table that the parent search_api_stats module records.

---

This submodule of search_api_stats provides a single derivative block plugin (`search_api_stats_block`, deriver `SearchApiStatsBlock`) that produces **one block variant per Search API index** on the site (`Index::loadMultiple()`), labelled "Search API stats block: <index label>". When rendered, the block queries the `search_api_stats` table with a grouped `SELECT keywords, COUNT(*) ... WHERE s_name = :server AND i_name = :index AND keywords != '' GROUP BY keywords ORDER BY num DESC` limited to the configured number of phrases, so it shows the top keywords for that index's server. Each placed block has three settings: **number of top search phrases** (2-20, 25, 30; default 8), the **path** of the search page, and the **parameter name** used for the search phrase in the link. Its `search-api-stats-block.html.twig` template renders an unordered list of links of the form `<path>?<param_name>=<keyword>` showing `keyword (count)`, so visitors can click a popular term to re-run that search. The block sets `#cache max-age = 0` (uncached, always live counts). It has no permissions, config schema, routes or Drush of its own; placement and visibility use core Block UI.

---

- Show a "Popular searches" block listing the top keywords for a search index.
- Give visitors clickable shortcuts to the site's most common search phrases.
- Surface trending queries in a sidebar next to the search box.
- Display a separate top-terms block for each Search API index (multi-index sites).
- Limit the block to the top N phrases (e.g. top 10) via the block settings.
- Point the term links at a custom search page path (e.g. `/search`).
- Match the block's link query parameter to your search form's field name.
- Provide editors a live, always-fresh view of what visitors search for.
- Drive content ideas by advertising real popular searches to users.
- Encourage discovery by turning recorded searches into a navigational widget.
- Place the block only on the search results page via core block visibility rules.
- Offer a "people also searched for" style list beside results.
- Give each language/section its own popular-terms block using index scoping.
- Highlight seasonal or trending terms without any manual curation.
- Combine with the parent module's Views reports for both admin and public views of top terms.
- Show the search count beside each phrase so users see popularity.
- Add a top-searches block to the front page to guide new visitors.
- Reuse recorded search data as an auto-updating tag-cloud-like list.
- Restrict the block to authenticated users via core role visibility.
- Provide quick re-search links so users refine queries faster.
