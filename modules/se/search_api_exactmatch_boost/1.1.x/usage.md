<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API exact match boost is a Search API processor that pushes results whose indexed string field exactly equals the search keys to the top of the result list — useful when partial matching would otherwise rank an exact title the same as substring matches.

---

The module provides a single Search API **processor** plugin, `exactmatchboost` (`Exact match boosting`),
that runs in the `postprocess_query` stage. On each search it takes the original search keys and, for
each configured field, finds the result items that are an exact match and moves them to the front of the
result set. On the **Search API DB** backend and `string`-type fields it queries the field's DB table
directly (`condition('value', $search_keys)` as a bound parameter) so it can surface exact matches even
when they fall outside the current page; for other backends/field types it only scans the items already
in the current result page (case-insensitive, trimmed compare). It is configured per index on the
index's **Processors** tab (there is no global settings page): you pick which fields it acts on (limited
to `text`/`string`/`solr_text_custom` fields; the "all fields" option is hidden), and two options —
`remove_exacts` (remove the boosted items from their original position, string fields only) and
`disable_full_processing_level` (skip the processor on non-full processing contexts such as
autocomplete, for speed). Because it adds items to page 1 and may remove them from later pages, paged
displays can show differing per-page counts — the module's own README and form warn that it works best on
non-paged displays and may not play well with the Views "result summary" plugin. Config schema is
`search_api.fields_processor_configuration` plus a `remove_exacts` boolean.

---

- Rank an exact title match above partial/substring matches in a Search API view.
- Keep fuzzy/partial matching enabled while still surfacing exact hits first.
- Boost exact matches on a specific string field (e.g. product SKU or title).
- Show a searched-for term that exactly equals a field value at the top of results.
- Use the DB backend to promote exact matches found anywhere in the index, not just page 1.
- Optionally remove the boosted exact match from its original lower position (`remove_exacts`).
- Speed up autocomplete by disabling exact-match boosting on non-full processing levels.
- Limit boosting to selected textual fields rather than all indexed fields.
- Combine with the Transliteration processor so accented exact matches are recognised.
- Improve relevance ordering without writing a custom sort or Solr boost.
- Prioritise canonical entries (exact name) over descriptive content that merely mentions the term.
- Apply exact-match boosting to a `text` field while accepting page-1-only behaviour.
- Configure per index/field so different indexes can boost different fields.
- Provide "I know exactly what I'm looking for" UX where the exact record jumps to the top.
- Avoid re-indexing: it reorders at query time, not index time.
- Tune search relevance for autocomplete vs full search separately.
- Use on a DB-backed catalogue where a title should outrank body-text matches.
- Keep exact matches first even across pagination on string fields (with the DB query path).
