<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the OpenAI Vector Store provider

## Install & enable

```bash
composer require drupal/ai_vdb_provider_openai
drush en ai_vdb_provider_openai -y
```

Composer pulls `drupal/ai ^1.4`, `drupal/ai_provider_openai ^1.2`, `drupal/ai_search ^1.3`,
`drupal/key ^1.22`. **Alpha / not production-ready.**

## Prerequisite: the OpenAI provider + key

This module has **no key or endpoint config of its own**. It obtains the OpenAI SDK client from the
`ai_provider_openai` provider, so first configure that provider with an OpenAI API key stored as a **Key**
entity (Key module). You must also have already created an **OpenAI Vector Store** (id like `vs_...`) in your
OpenAI account — the module references it, it does not create one.

## The only setting: per-server Vector Store ID

There is no admin settings form and no `ai_vdb_provider_openai.settings` route/schema. Configuration lives on
the **Search API server** backend form (`OpenAiVectorStoreProvider::buildSettingsForm()`):

- **OpenAI Vector Store ID** (`collection`, required textfield) — the `vs_...` store this index reads/writes.
  `validateSettingsForm()` calls `OpenAiVectorStoreClient::vectorStoreExists()` and rejects an ID the
  configured OpenAI provider cannot retrieve.
- `database_name` is a fixed hidden `'default'` value (the AI Search backend expects the key to exist).

Each Search API server can point at a different vector store.

## Wire up Search API

1. `/admin/config/search/search-api` → **Add server** → backend **AI Search**.
2. Select **OpenAI Vector Store** as the VDB provider and enter the **Vector Store ID**.
3. Add an **Index**. Use AI Search's field categorization: *Main Content* / *Contextual Content* become the
   uploaded Markdown; *Filterable Attributes* become OpenAI attribute filters.
4. Keep **Filterable Attributes ≤ 15** — `hook_form_search_api_index_fields_alter` warns above that because
   OpenAI allows 16 attributes per file and the provider reserves one for `index_id`.
5. Index content — items are uploaded to OpenAI and polled to completion synchronously.

## Storage & cron

- Mapping table **`ai_vdb_provider_openai_mapping`** (created by `hook_schema()`; update hooks
  `_update_11001`/`_11002` create/migrate it): tracks `index_id`, `item_id`, entity ref, `checksum`,
  `vector_store_id`, `provider_file_id`, `provider_item_ref`, `status`, `error`, `updated`. Unique key on
  (`index_id`, `item_id`).
- **`hook_cron`** delegates to the reconciler: retry up to 50 `delete_failed` rows, and (≤ once/day) sweep
  drift between the table and OpenAI — logging orphaned remote files and removing dangling local mappings
  (re-queuing those items for re-indexing). See [../api/provider.md](../api/provider.md).

## Optional: query rewriting

Enable the **`openai_rewrite_query`** Search API processor (*OpenAI Rewrite Query*) on the index to turn on
OpenAI's server-side `rewrite_query` — better recall at the cost of more tokens / latency. It only supports
indexes whose server backend is `search_api_ai_search` with database `openai_vector_store`.

## Operational notes

- Score threshold: if the `ai_search_score_threshold` processor is configured, its `minimum_relevance_score`
  is passed to OpenAI as the search `score_threshold`.
- Known alpha limits: no facet counts, no custom sort (relevance only), max 16 attributes/item.
- All secrets stay in the OpenAI provider's Key entity; this module logs errors to the
  `ai_vdb_provider_openai` channel, never the key.
