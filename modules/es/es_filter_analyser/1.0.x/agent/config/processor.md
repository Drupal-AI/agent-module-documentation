<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API processor: analyser_processor

`src/Plugin/search_api/processor/AnalyserProcessor.php` —
`@SearchApiProcessor(id = "analyser_processor", label = "ElasticSearch Analyser")`,
`stages = { pre_index_save = 0, preprocess_query = 0 }`. This processor is the **glue** that tells the
event subscribers which `es_analyser` to use where; it does not itself write to ElasticSearch.

## Enable & configure

On an ElasticSearch-backed Search API index: *Manage → Processors* → enable **ElasticSearch Analyser**,
then set:

- **Global Search Analyser** — a select of all `es_analyser` entities (`getAnalyserOptions()` loads them
  via `entity_type.manager` storage `es_analyser`). Applied to every query unless a field overrides it.
- **Field analysers table** — one row per **text field** on the index (only `text`, `string`,
  `tokenized_text` field types pass `isTextField()`). Each row has an **Index Analyser** and a
  **Search Analyser** select (both listing the `es_analyser` entities, `- Default -` = none).

`defaultConfiguration()` = `['global_search_analyser' => '', 'field_analysers' => []]`.
`submitConfigurationForm()` drops rows where both selects are empty and stores
`field_analysers[<field_id>] = ['index_analyser' => ..., 'search_analyser' => ...]`. The config lives in
the index's own processor settings (no separate config object, no config schema shipped by this module).

## Config it exposes (read by the subscribers)

- `global_search_analyser` — analyser id or `''`.
- `field_analysers` — map of field id → `{ index_analyser, search_analyser }`.

Helper accessors (used programmatically, e.g. in tests / other code):
`getGlobalSearchAnalyser()`, `getFieldIndexAnalyser($field_id)`,
`getFieldSearchAnalyser($field_id)` (falls back to the global analyser),
`getFieldAnalysers()`, `getFieldAnalyserEntity($field_id, $operation = 'index'|'search')`.
`getFieldTypeLabel()` resolves the Search API data-type label via `plugin.manager.search_api.data_type`.

## How the config becomes ElasticSearch behaviour

The subscribers in [../api/event-subscribers.md](../api/event-subscribers.md) read this processor's
config off the index (`EventSubscriberBase::getProcessorSettings($index, 'analyser_processor')`) and:

1. **Index rebuild** — collect the referenced analysers + their filters and write them into
   `analysis.filter` / `analysis.analyzer` index settings.
2. **Field mapping** — set each field's `analyzer` (from `index_analyser`) and `search_analyzer`
   (from `search_analyser`).
3. **Query** — inject `global_search_analyser` as the `analyzer` on match/multi_match/query_string/
   match_phrase clauses.

After changing analyser/field config you must **rebuild the ElasticSearch index** for `analysis`
settings and field mappings to take effect (they are only emitted during index (re)creation).
