# Configuration

All of this module's behavior is driven from its settings form, which is
available to users with the **`administer native search enhancements`**
permission. The options fall into three groups: what content to include or
exclude, how taxonomy terms appear in results, and how results are ranked.

## Open the settings

Log in as a user with the **administer native search enhancements** permission
and open the module's settings form (reachable from the admin configuration area,
under the search settings). If you cannot see it, confirm the permission is
granted under **People → Permissions**.

## Content exclusions

Choose which **content types** should be left out of native search — both from
indexing and from results. Use this to keep utility or internal content types
(landing‑page fragments, system pages, and so on) from cluttering what visitors
find. Content types you do not exclude continue to be indexed and searched as
normal.

## Taxonomy term results

Turn on **taxonomy terms as independent search results** so that matching terms
appear alongside content in the results list. Related options let you fine‑tune
this behavior:

- **Exact vs. partial matching** — decide whether a term is returned only on an
  exact match or also on partial matches.
- **Canonical term links with alias support** — term results link to the term's
  canonical page, honoring any URL alias you have set.
- **Optional URL fragments** — append a fragment to taxonomy result links when you
  want them to jump to a specific spot.
- **Multilingual support** — term names are matched and displayed in the current
  language.

## Ranking

Tune how results are ordered:

- **Content title ranking** — set how much weight a match in a content item's
  **title** carries, so title hits can be pushed up the results.
- **Taxonomy term result influence** — set how strongly taxonomy results compete
  with content results in the ordering.

Adjust these gradually and re‑test real searches; small changes to ranking
weights can noticeably reorder results.

## Save and test

Save the form, then run a few representative searches. Confirm that excluded
content types no longer appear, that taxonomy terms show up (and link) the way you
intended, and that the ordering matches your ranking choices. If indexed content
seems stale, re‑run cron so core Search reindexes.
