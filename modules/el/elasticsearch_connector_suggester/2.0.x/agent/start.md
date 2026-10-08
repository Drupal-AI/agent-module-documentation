<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch Connector Suggester (elasticsearch_connector_suggester) — agent index

Adds an **Elasticsearch-native completion suggester** to **Search API Autocomplete** for indexes
served by the **Elasticsearch Connector** backend. Package `Elasticsearch`. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 2.0.1. (2.x targets Elasticsearch 8.x / Elasticsearch Connector 8.0.x.)

Depends on `elasticsearch_connector` and `search_api_autocomplete` (both hard deps in
`*.info.yml`); code also uses `search_api` classes and the `@search_api.fields_helper` service.
No routes, no permissions, no config schema, no Drush, no install file of its own.

## What it provides (all from source)

- **Suggester plugin** `elastic_live_results` ("Elastic display live results"),
  `src/Plugin/search_api_autocomplete/suggester/ElasticLiveResults.php`, extends
  search_api_autocomplete's `LiveResults`. Adds one `analyzer` setting; builds suggestions from the
  Elasticsearch `suggest` response (with per-item access checks).
- **Processor plugin** `elasticsearch_connector_suggester_tokenizer`
  ("Elasticsearch Connector Suggester Tokenizer"), `src/Plugin/search_api/processor/Tokenizer.php`,
  extends core Search API `Tokenizer`.
- **Four event subscribers** (`*.services.yml`) that map the field as ES `completion`, rewrite the
  autocomplete query into an ES `suggest` request, re-save the index on config save, and inject
  suggest options back as result items.
- **Three dispatched events** (`src/Event/`): `RouteNameEvent`, `FieldNameEvent`, `KeysEvent` —
  extension points for other modules.

## Solution docs

- **The suggester plugin, its `analyzer` setting, how it renders suggestions, and the tokenizer
  processor, plus enable/configure steps** → [plugins/suggester.md](plugins/suggester.md)
- **The event subscribers (field mapping → completion, query rewrite → suggest, config-save
  reindex, results injection) and the three alter events** → [api/events.md](api/events.md)
