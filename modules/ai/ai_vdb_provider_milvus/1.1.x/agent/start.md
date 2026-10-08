<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Milvus/Zilliz VDB Provider — agent index

Registers a `milvus` **VdbProvider** plugin for the Drupal **AI** module so `ai_search` can store
and query embeddings in a self-hosted Milvus or Zilliz Cloud vector DB. Depends on `ai`, `ai_search`,
`key`. Experimental. No permissions of its own (config gated by AI's `administer ai providers`), no
Drush. One config object (`ai_vdb_provider_milvus.settings`) + one HTTP client service.

- **Connect to Milvus/Zilliz: config keys, the settings form, Key entity for auth, DDEV setup** →
  [configure/connection.md](configure/connection.md)
- **Programmatic use: the `milvus_v2.api` (`MilvusV2`) REST client and the `MilvusProvider` plugin** →
  [api/client.md](api/client.md)

Key facts:
- Config route `ai_vdb_provider_milvus.settings_form` → `/admin/config/ai/vdb_providers/milvus`
  (permission `administer ai providers`, defined by the `ai` module).
- Settings: `server` (full URL), `port` (int), `api_key` (**Key** machine name, not the raw secret).
- Provider plugin id `milvus` (`src/Plugin/VdbProvider/MilvusProvider.php`, extends
  `AiVdbProviderClientBase`); low-level REST client `MilvusV2` (`src/MilvusV2.php`, service
  `milvus_v2.api`) targets Milvus v2 endpoints under `<server>:<port>`.
- Auth header when a key is set: `authorization: Bearer <keyvalue>`; Milvus expects `username:password`.
- Zilliz Cloud auto-detected from host (`zillizcloud.com` / `cloud.zilliz.com`).
