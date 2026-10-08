<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Elasticsearch VDB provider

## Install & enable

```bash
composer require drupal/ai_vdb_provider_elasticsearch
drush en ai_vdb_provider_elasticsearch -y
```

Composer pulls `drupal/ai ^1.2`, `drupal/key`, `drupal/search_api`, plus the vendor libraries
`elasticsearch/elasticsearch ^8.0` and `smalot/pdfparser ^2.12`. `hook_requirements()`
(`ai_vdb_provider_elasticsearch.install`) reports an **error** at `/admin/reports/status` if
`Elastic\Elasticsearch\Client` is missing, and a **warning** if `Smalot\PdfParser\Parser` is missing while
`search_api_attachments` is enabled.

## Settings form

`ElasticsearchConfigForm`, route `ai_vdb_provider_elasticsearch.settings_form` at
**`/admin/config/ai/vdb_providers/elasticsearch`**, permission **`administer ai providers`** (menu:
*AI → VDB Providers → Elasticsearch Configuration*). Writes config object
**`ai_vdb_provider_elasticsearch.settings`** (schema `config/schema/…schema.yml`).

| Config key | Form field | Meaning |
|---|---|---|
| `host` | Elasticsearch Host URL (required, `rtrim`'d of `/`) | Cluster endpoint, e.g. `https://cluster:9200` or `http://elasticsearch:9200`. |
| `api_key_id` | API Key (Key select) | Key entity holding the ES API token. **Takes precedence** over Basic Auth. |
| `username` | Basic Auth Username | Used only when no API key is set. |
| `password_key_id` | Basic Auth Password (Key select) | Key entity holding the Basic Auth password. |
| `index_prefix` | Index Prefix (required, default `drupal_`) | Namespace prefix prepended to every ES index name. |
| `similarity_metric` | Similarity Metric (default `cosine`) | `cosine` / `l2_norm` / `dot_product`; baked into the mapping at index creation. |
| `hybrid_search` | Enable Hybrid Search (checkbox `hybrid_search_enabled`) | Turn on kNN + BM25 + RRF (needs ES 8.8+). |
| `rrf_rank_constant` | RRF Rank Constant (number 1–100, default 20) | Balances kNN vs BM25 during Reciprocal Rank Fusion. |

Credentials are **never stored in this config object** — only the Key entity machine names are. The actual
API key/password are resolved from `key.repository` at connection time in the plugin's `initializeClient()`.

## Credential precedence & auth

`ElasticsearchClient::getConnection()`:
1. If an API key is present → `ClientBuilder::setApiKey()`.
2. Else if username **and** password present → `setBasicAuthentication()`.
3. Else → an unauthenticated client (documented for local dev clusters with security disabled).

Set the credentials as Key entities at `/admin/config/system/keys` first, then select them here.

## Wire up Search API

1. `/admin/config/search/search-api` → **Add server** → backend **AI Search (VDB)**.
2. Choose **Elasticsearch (Native kNN)** as the VDB provider; attach an embeddings AI provider.
3. Add an **Index**, map fields, index content. The ES index is created automatically on first use with the
   dimensions from your embedding model and the configured `similarity_metric`.

## Operational notes

- Only `administer ai providers` holders reach this form, so only they set the outbound cluster host/creds.
- Changing the similarity metric or embedding dimensions requires dropping and re-indexing (the mapping is
  fixed at creation).
- The module provides no permissions, Drush commands or hooks beyond the install-time requirements check.
