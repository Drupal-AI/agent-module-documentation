<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API exact match boost — agent index

One Search API processor plugin (`exactmatchboost`) that moves exact-match results to the top of the
result list at query time (`postprocess_query` stage). Depends on `search_api`. No global config,
no permissions, no Drush. Configured per index on the Processors tab.

- **Enable & configure the processor, its options, backend behaviour and caveats** →
  [configure/processor.md](configure/processor.md)

Key facts:
- Plugin: `src/Plugin/search_api/processor/ExactMatchBoost.php`, id `exactmatchboost`, label
  "Exact match boosting", stage `postprocess_query` (weight 0). Extends `FieldsProcessorPluginBase`.
- Fields limited to `text`/`string`/`solr_text_custom`; the "all fields" toggle is hidden.
- Options: `remove_exacts` (bool, remove boosted item from its original slot — string fields only),
  `disable_full_processing_level` (bool, skip on non-`PROCESSING_FULL` queries e.g. autocomplete).
- DB backend + `string` field: queries `<backend>_<index>_<field>` table with a bound
  `condition('value', $search_keys)` — finds exact matches beyond the current page. Other
  backends/types: case-insensitive/trimmed compare over the current page only.
- Paged displays may show uneven per-page counts (adds to page 1, removes from later pages).
