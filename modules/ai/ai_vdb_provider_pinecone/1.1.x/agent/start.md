<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pinecone Serverless VDB Provider — agent index

Registers Pinecone as a vector-database backend for the Drupal AI module's AI Search (Search API).
Experimental. Depends on `ai`, `ai_search`, `key`, `search_api`, and the `scotteuser/pinecone-php`
(`Probots\Pinecone\Client`) SDK. No permissions of its own; config route requires `administer ai providers`.

- **Settings form (Key-based API key), the `pinecone` VdbProvider plugin, the `pinecone.api` client
  service and its methods** → [configure/pinecone.md](configure/pinecone.md)

Key facts:
- Config object `ai_vdb_provider_pinecone.settings`: `api_key` (a **Key entity id**, not the raw key),
  plus `hostname`, `region`, `cloud_provider`. Schema in `config/schema/`.
- Config form `PineconeConfigForm` at `/admin/config/ai/vdb_providers/pinecone` uses a `key_select`
  element; on validate it resolves the key via `key.repository` and lists indexes to test the connection.
- Provider plugin `PineconeProvider` (id `pinecone`, `#[AiVdbProvider]`) extends
  `AiVdbProviderClientBase`; `getClient()` reads the key name from config, resolves the value from Key,
  and hands it to the `Pinecone` wrapper.
- Wrapper service `pinecone.api` (`src/Pinecone.php`): `getClient`, `listIndexes` (cached per
  hashed API key), `describeIndex`, `getIndexStats`, `insertIntoNamespace`, `deleteFromNamespace`,
  `deleteAllFromNamespace`, `fetch`, `query`. Index host is resolved per call from Pinecone's own
  describe/list response.
- Outbound HTTP targets Pinecone's own API (host from Pinecone's response, not user input); the API key
  is held as a Key entity.
