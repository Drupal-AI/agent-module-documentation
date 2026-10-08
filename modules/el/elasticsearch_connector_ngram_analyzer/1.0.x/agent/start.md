<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch Connector Ngram analyzer (elasticsearch_connector_ngram_analyzer) — agent index

Adds n-gram (partial/substring) matching to **Elasticsearch Connector** indexes for Search API.
It ships a Search API data type **`text_ngram`** ("Text Ngram") and an ElasticSearch analyser
**`ngram_analyzer`**; three event subscribers inject the analyzer into index settings, map
`text_ngram` fields to an ngram-analyzed Elasticsearch `text` field, and normalise query strings.

- Package `Elasticsearch`. Version **1.0.0-alpha1**. Core `^10 || ^11`. License GPL-2.0-or-later.
- Depends on `elasticsearch_connector`; also requires `search_api` (used by the plugins/subscribers,
  though not declared in `.info.yml`).
- **No** config forms, routes, permissions, install hooks, config schema, or Drush commands.
  `.info.yml` and `.services.yml` only, plus `src/`.

## What it provides (from source)

- Plugin `TextNgram` (`src/Plugin/search_api/data_type/TextNgram.php`) — `@SearchApiDataType` id
  **`text_ngram`**, label "Text Ngram", `fallback_type = "text"`. The user-facing field type.
- Plugin `NgramAnalyzer` (`src/Plugin/ElasticSearch/Analyser/NgramAnalyzer.php`) —
  `@ElasticSearchAnalyser` id **`ngram_analyzer`**, extends `AnalyserBase`; defines the analyzer
  (`type: custom`, tokenizer `es_ngram`, filter `lowercase`) and tokenizer (`type: ngram`,
  `min_gram`/`max_gram` = 3, `token_chars` letter+digit).
- Service `elasticsearch_connector_ngram_analyzer.analyzer_service` (`AnalyzerService`) — thin
  wrapper over `plugin.manager.elasticsearch_connector.analyser` returning analyzer/tokenizer/filter
  definitions by plugin id.
- Three event subscribers (all in `src/EventSubscriber/`, registered in `.services.yml`).

## Solution docs

- **What each plugin/subscriber/service does, config keys, install & per-field enable, reindex** →
  [analyzer/ngram.md](analyzer/ngram.md)
