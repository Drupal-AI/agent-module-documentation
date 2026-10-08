<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API OpenSearch — agent index

Provides a **Search API backend plugin `opensearch`** so Drupal can index into and search an
OpenSearch cluster. Depends on `search_api` + an actual OpenSearch server and the
`opensearch-project/opensearch-php`, `makinacorpus/php-lucene`, Guzzle libraries. No module
`configure` route — you configure it on a Search API **server** entity.

- **Create the server, backend config, connectors (standard/basicauth), advanced settings,
  provided data types & processor** → [configure/backend.md](configure/backend.md)
- **The two plugin types it defines — OpenSearch connectors and analysers (how to add one)** →
  [plugins/plugin-types.md](plugins/plugin-types.md)
- **Dispatched events + `hook_index_param_value_alter()` for customising mappings/params** →
  [hooks/events.md](hooks/events.md)

Submodules (nested):
- `search_api_aws_signature_connector` — an `aws_signature` connector for Amazon OpenSearch.
- `search_api_opensearch_location` — a `location` (geo_point) Search API data type.

Key facts: backend id `opensearch`; connector plugin type `opensearch_connector` (ids
`standard`, `basicauth`, `aws_signature`); analyser plugin type `opensearch_analyser` (ids
`ngram`, `edge_ngram`); backend config = `connector` + `connector_config` (`url`,
`ssl_verification`, …) + `advanced` (`fuzziness`, `prefix`, `synonyms`). Grounding note: this
site has **no live OpenSearch cluster** — reason about config/backend plugin data, not query
results.
