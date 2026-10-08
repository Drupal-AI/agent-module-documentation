<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event subscribers — how entities reach ElasticSearch

All three subscribers are registered in `es_filter_analyser.services.yml`, each constructed with
`@entity_type.manager`, and extend `EventSubscriberBase` (`src/EventSubscriberBase.php`). They react to
Elasticsearch Connector events; the module has **no HTTP client of its own** — it only mutates the
settings/params arrays the connector then sends.

## EventSubscriberBase::getProcessorSettings($index, $processor_name)

Shared helper. Returns the `analyser_processor` configuration for an index, or `NULL` if the index is
empty, the processor is not a valid/enabled processor (`isValidProcessor`), or loading throws (logged to
the `es_filter_analyser` logger channel). All three subscribers call it with `'analyser_processor'`.

## AddAnalyserInIndex — `AlterSettingsEvent` → `alterSettingsEvent()`

Service `es_filter_analyser.index_subscriber`. Fires when the connector builds index settings.

1. Load the processor config; return if none.
2. Collect analyser ids referenced in `field_analysers` rows.
3. Load those `es_analyser` entities, gather all filter ids from their `filters` lists.
4. Load those `es_filter` entities; write each into `settings['analysis']['filter'][<id>] =
   $filter->getConfigData()`.
5. Write each analyser into `settings['analysis']['analyzer'][<id>] = $analyser->getConfigData()`,
   then `$event->setSettings($settings)`.

> **Known source bug (functional, not security):** the loop collecting analyser ids pushes
> `$data['index_analyser']` in **both** the index and the search branch (the search branch should push
> `$data['search_analyser']`). A field configured with a *search-only* analyser and no index analyser may
> therefore not have its analyser/filters emitted into the `analysis` settings. Work around it by also
> selecting the analyser as the field's Index Analyser (or referencing it from an indexed field).

## AddAnalyserInFields — `FieldMappingEvent` → `fieldMappingEvent()`

Service `es_filter_analyser.field_subscriber`. For the field being mapped, looks up
`field_analysers[<field_identifier>]` and sets `params['analyzer'] = index_analyser` and
`params['search_analyzer'] = search_analyser` (each only when non-empty), then `$event->setParam()`.
This writes the per-field `analyzer` / `search_analyzer` into the ES field mapping.

## AddGlobalSearchAnalyserInQuery — `QueryParamsEvent` → `addSearchAnalyser()`

Service `es_filter_analyser.query__subscriber`. At query time: load the processor config; read
`global_search_analyser`; return if it is empty or `body.query` is absent. Otherwise
`findQueryAndAddAnalyser()` walks the query tree recursively and sets `['analyzer' => <global analyser>]`
on `multi_match` / `query_string` clauses, and on the field sub-array of `match` / `match_phrase`
clauses; then `$event->setParams()`. The analyser name is admin-configured (an `es_analyser` id), not
end-user search input.

## Operating notes

- `analysis.filter` / `analysis.analyzer` settings and field mappings are only emitted while the index
  is (re)built — **rebuild the index** after changing filter/analyser/field config.
- Query-time analyser injection is applied live per search request (no rebuild needed).
