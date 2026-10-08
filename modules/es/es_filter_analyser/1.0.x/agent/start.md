<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ElasticSearch Filter-Analyser Management (es_filter_analyser) — agent index

Manage ElasticSearch token filters and analysers as Drupal **config entities** and inject them into
Search API / Elasticsearch Connector indexes, field mappings and queries. Package `Search`. Version
**1.0.3** (stable). Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.

- Depends on `search_api:search_api` and `elasticsearch_connector:elasticsearch_connector`
  (composer `drupal/elasticsearch_connector: ^8.0 || ^9.0`). No submodules, no Drush, no `.module`/`.install`.
- One permission: **`administer es_filter_analyser`** (`restrict access: true`) — the effective admin
  permission for both entity types (their `admin_permission`).
- No config **schema** dir and no module settings route (`configure` = null). Ships three example
  config objects in `config/install/` (French text analyser + elision + lowercase filters).

## What it provides

- **Config entities & their forms/routes/list builders** → [config/entities.md](config/entities.md)
  - `es_filter` (`Entity\Filter`, config_prefix `filter`) — one native ES token filter + settings.
  - `es_analyser` (`Entity\Analyser`, config_prefix `analyser`) — a tokenizer + ordered filter list.
- **Search API processor `analyser_processor`** (per-field / global analyser picker) →
  [config/processor.md](config/processor.md)
- **`FilterType` plugin type** (31 filter plugins: stemmer, synonym, edge_ngram, stop, elision, ...) →
  [plugins/filter-types.md](plugins/filter-types.md)
- **Three Elasticsearch Connector event subscribers** that do the actual injection →
  [api/event-subscribers.md](api/event-subscribers.md)

## Mechanism in one line

Admin builds `es_filter` + `es_analyser` entities → enables `analyser_processor` on an index and maps
analysers to text fields → on index rebuild / query, `AddAnalyserInIndex`, `AddAnalyserInFields` and
`AddGlobalSearchAnalyserInQuery` read the processor config and translate the entities into ES
`analysis.filter` / `analysis.analyzer` settings, field `analyzer`/`search_analyzer`, and a query-time
`analyzer`.
