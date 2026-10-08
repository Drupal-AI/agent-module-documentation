<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Azure AI Search VDB provider

## Install & enable

```bash
composer require drupal/ai_vdb_provider_azure_ai_search
drush en ai_vdb_provider_azure_ai_search -y
```

Pulls in `ai`, `ai_search`, `key`, `search_api`. Experimental module.

## Prerequisites in Azure

Create the index in the **Azure AI Search** portal first (the module never creates one — see
`createCollection()` in `AzureAiSearchProvider.php`, a no-op). Add the fields the Search API / AI Search
pipeline populates (embedding `vector` field, `drupal_entity_id`, `drupal_long_id`, the metadata/content
fields, etc.). Then create an API key in the Azure service for authentication.

## Two configuration surfaces

There are **two** places settings live, both writing config object
**`ai_vdb_provider_azure_ai_search.settings`** (schema: `config/schema/…schema.yml`; install defaults empty):

1. **Module settings form** — `AzureAiSearchConfigForm`, route
   `ai_vdb_provider_azure_ai_search.settings_form` at
   **`/admin/config/ai/vdb_providers/azure_ai_search`**, permission **`administer ai providers`**
   (menu: *AI → VDB Providers → Azure AI Search Configuration*). It exposes just the **API Key**
   (`key_select`, stored as the Key entity's machine name in `api_key`). (Its field help text mistakenly
   mentions Pinecone; it is the Azure key.)

2. **The Search API server backend form** — `AzureAiSearchProvider::buildSettingsForm()` (rendered inside
   the AI Search "Vector Database" backend). This is where you actually set:
   - **Url** (`#type url`, required) → saved to `url`. Your Azure service endpoint, e.g.
     `https://<service>.search.windows.net`.
   - **API-version** (`select`, default `2023-11-01`) → saved to `api_version`. Options range
     `2020-06-30` … `2024-05-01-preview`.
   - **API Key** (`select` over `key.repository` key names) → saved to `api_key`.
   - **Index Name** (the framework's `database_name` field, relabelled) → the existing Azure index to use.
   - The **collection** and **metric** fields are hidden/removed — Azure needs neither.

`submitSettingsForm()` writes `url`, `api_version`, `api_key` to the config object. `validateSettingsForm()`
requires an index name and a successful `ping()` (a `listIndexes()` call) before saving.

## Config object keys

| Key | Meaning |
|---|---|
| `api_key` | Machine name of the **Key** entity holding the Azure `api-key`. |
| `url` | Azure AI Search service base URL (HTTPS). |
| `api_version` | Azure REST Search Service API version string. |

## Wire up Search API

1. `/admin/config/search/search-api` → **Add server** → backend **AI Search (VDB)**.
2. Choose **Azure AI Search DB** as the Vector Database provider; fill Url / API-version / API Key /
   Index Name as above; attach an embeddings AI provider.
3. Add an **Index** to that server, map fields, and index content.

## Status page

The server view calls `viewIndexSettings()` → shows a **Ping** row (reachability) and, for the configured
index, **Index storage size** and **Total results count** from `AzureAiSearch::getIndexStats()`
(`GET /indexes('{index}')/search.stats`).

## Operational notes

- The API key is resolved at request time from the Key repository and sent as the `api-key` HTTP header, not
  in the URL/query string.
- Only holders of `administer ai providers` reach the settings form and thus control the outbound service
  URL/key.
- The module ships no permissions, no Drush commands, and no hooks.
