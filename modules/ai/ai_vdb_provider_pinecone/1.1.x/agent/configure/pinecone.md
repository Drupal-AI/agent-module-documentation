<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Pinecone as an AI vector database

## 1. Provide the API key as a Key entity

The settings form stores only the **name of a Key entity**, never the raw secret. Create the key first
(env provider recommended), e.g.:

```
drush key:save pinecone_api_key --label='Pinecone API Key' --key-type=authentication \
  --key-provider=env --key-provider-settings='{"env_variable":"PINECONE_API_KEY"}' --key-input=none -y
```

## 2. Settings form

Route `ai_vdb_provider_pinecone.settings_form` → `/admin/config/ai/vdb_providers/pinecone`
(permission **`administer ai providers`**, provided by the `ai` module). Form `PineconeConfigForm`:

- `api_key` — a `key_select` element listing available Key entities.
- On **validate**, the selected key's value is fetched via `key.repository` and used to call
  `control()->index()->list()`; the form errors if the call fails or the account has no indexes.
- On **submit**, only the key name is written to config `ai_vdb_provider_pinecone.settings:api_key`.

Config object `ai_vdb_provider_pinecone.settings` (schema `config/schema/…schema.yml`):

| Key | Meaning |
|---|---|
| `api_key` | Key entity id/name holding the Pinecone API key |
| `hostname` | (schema string) optional host |
| `region` | (schema integer) |
| `cloud_provider` | (schema integer) |

Defaults (`config/install`): all empty strings.

## 3. Use it on an AI Search index

With `ai_search` + `search_api` enabled, create a Search API server that uses the AI Search backend and
select **Pinecone DB** as the vector database provider (plugin id `pinecone`). The provider then routes
index/vector operations to Pinecone.

## The `pinecone` provider plugin

`PineconeProvider` (`src/Plugin/VdbProvider/PineconeProvider.php`), attribute `#[AiVdbProvider(id:
'pinecone', label: 'Pinecone DB')]`, extends `ai`'s `AiVdbProviderClientBase` and implements
`DependentPluginInterface`. `getClient()` loads `api_key` from `getConfig()`, resolves the value from
the Key repository, and returns the wrapper preconfigured.

## The `pinecone.api` client service (`src/Pinecone.php`)

Thin wrapper over `Probots\Pinecone\Client` (`scotteuser/pinecone-php`). Methods:

| Method | Purpose |
|---|---|
| `getClient(string $api_key)` | Lazily build the SDK client. |
| `listIndexes()` | List indexes; cached under `pinecone:<hashBase64(apiKey)>` in `cache.default`. |
| `describeIndex($name)` / `getIndexStats($name)` | Index metadata / per-namespace vector counts. |
| `insertIntoNamespace($namespace, $data, $index)` | Upsert one vector (`id`, `values`, `metadata`); array metadata is stringified to satisfy Pinecone's "list of strings". |
| `fetch($namespace, $ids, $index)` | Fetch vectors by id. |
| `query($namespace, $index, $filter, $topK, $vector, $include_values, $include_metadata)` | Similarity/metadata query. |
| `deleteFromNamespace($namespace, $ids, $index)` / `deleteAllFromNamespace($namespace, $index)` | Delete by id / clear namespace (guarded by a `vectorCount > 0` check). |
| `clearIndexesCache()` | Drop the cached index list. |

`getClientForIndex()` resolves the target index's `host` from the describe/list response and calls
`setIndexHost('https://'.$host)` before data-plane calls — the host comes from Pinecone, not from user
input. Failures raise a warning message and log to the `ai_search` logger channel.
