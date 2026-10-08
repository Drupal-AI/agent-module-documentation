<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quant Cloud AI Provider (ai_provider_quant_cloud) — agent index

Connector that registers the Quant Cloud platform (QuantCDN / QuantGov Cloud) as a Drupal AI provider. Routes chat, embeddings, text-to-image and image-to-image to Quant's Dashboard API (`/api/v3/organisations/{orgId}/ai/...`, backed by AWS Bedrock: Claude, Nova, Titan, Cohere). Bearer auth over HTTPS, org-scoped, OAuth2 or manual-token.

- **Machine name:** `ai_provider_quant_cloud` · **Package:** AI · **Version dir:** 1.0.x (installed 1.0.0)
- **Core:** `^10.3 || ^11 || ^12` · **PHP:** `>=8.1` · **License:** GPL-2.0-or-later
- **Dependencies:** `ai:ai`, `key:key` (Composer: `drupal/ai:^1.0`, `drupal/key:^1.17`)
- **Configure route:** `ai_provider_quant_cloud.settings_form` → `/admin/config/ai/quant-cloud`

## Provides

- **AI provider plugin** `quant_cloud` — `Plugin/AiProvider/QuantCloudProvider` (attribute `#[AiProvider]`). Implements `ChatInterface`, `EmbeddingsInterface`, `TextToImageInterface`, `ImageToImageInterface`. Supported ops: `chat`, `embeddings`, `text_to_image`, `image_to_image`.
- **Streaming iterator** `QuantCloudChatMessageIterator` (extends AI `StreamedChatMessageIterator`) — parses SSE `data:` lines into `StreamedChatMessage`s.
- **Services** (see `ai_provider_quant_cloud.services.yml`):
  - `ai_provider_quant_cloud.client` → `Client/QuantCloudClient` (buffered chat/embeddings/image POST+GET)
  - `ai_provider_quant_cloud.streaming_client` → `Client/QuantCloudStreamingClient` (SSE chat/stream)
  - `ai_provider_quant_cloud.vectordb_client` → `Client/QuantCloudVectorDbClient` (direct VectorDB API)
  - `ai_provider_quant_cloud.auth` → `Service/AuthService` (OAuth URL, code→token exchange, org list, token validation)
  - `ai_provider_quant_cloud.models` → `Service/ModelsService` (model discovery, 1h cache, fallback list)
- **Config object:** `ai_provider_quant_cloud.settings` (schema in `config/schema/`). Keys: `platform`, `platforms.*.dashboard_url`, `auth.method`, `auth.access_token_key`, `auth.organization_id`, plus form-written `model.*` and `advanced.*`.
- **API definition:** `definitions/api_defaults.yml` (operation parameter schema for chat/embeddings/text_to_image/image_to_image), loaded by `getApiDefinition()`.
- **Routes** (`ai_provider_quant_cloud.routing.yml`): settings form + OAuth `connect` / `callback` / `disconnect`. All gated by core permission `administer site configuration`.
- **Submodule:** `ai_provider_quant_cloud_vdb` — AI Search / Search API vector-DB backend.

No custom permissions, no Drush commands, no new plugin types (it supplies plugin *instances* for AI's `AiProvider` / `AiVdbProvider` types).

## Solution docs

- [Configuration & authentication](config/settings.md) — settings form, config keys, OAuth flow, platforms, Key setup.
- [The quant_cloud provider plugin](plugins/provider.md) — operations, model/capability mapping, message & image formatting.
- [HTTP clients & services](api/clients.md) — client/streaming/vectordb clients, auth & models services, endpoints.
- [VectorDB submodule (ai_provider_quant_cloud_vdb)](submodules/vdb.md) — AI Search backend plugin `quant_cloud_vdb`.
