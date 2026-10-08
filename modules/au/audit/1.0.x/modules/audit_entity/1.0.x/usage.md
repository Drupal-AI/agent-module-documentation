Scores content structure: volume per bundle, revision bloat, translation coverage, and revision-table size.

---

Registers the `entity` analyzer (`EntityAnalyzer`, weight 1). It counts content per entity type/bundle/language, flags empty bundles (fewer than `empty_bundle_threshold` entities), detects revision bloat (nodes over `revision_threshold_node` 100, paragraphs over `revision_threshold_paragraph` 50), reports translation coverage gaps, and measures revision-table sizes (flagging tables over `revision_table_size_threshold_mb` 100 MB via a parameterized `information_schema` query, MySQL only).

---

- Inventory content counts by entity type, bundle, and language.
- Detect empty content bundles (below `empty_bundle_threshold`).
- Flag revision bloat on nodes/paragraphs over configurable thresholds.
- Measure revision-table sizes and flag those over `revision_table_size_threshold_mb` (100 MB).
- Report translation-coverage gaps across bundles.
- Tune `revision_threshold_node` (100) and `revision_threshold_paragraph` (50).
- Run headless for reporting: `drush audit:run entity --format=json`.
- Weight 1 by default (lower influence on the Project Score).
