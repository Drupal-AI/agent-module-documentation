<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Vertex (ai_provider_google_vertex) — agent index

An **AI provider plugin** that lets the Drupal **AI module** use **Google Vertex AI** models
(Gemini and other Model Garden models) for **chat, embeddings and text translation**. Version
**1.1.1**, version-dir `1.1.x`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Package *AI Providers*.

- **Dependencies:** `ai:ai` (`^1.1.0`), `key:key` (`^1.18`), and the Composer library
  `google/cloud-ai-platform` (`>=v1.9.0`, provides `Google\Auth\...` + gRPC classes).
- **Configure at:** route `ai_provider_google_vertex.settings_form` →
  `/admin/config/ai/providers/google_vertex` (permission **`administer ai providers`**), menu link
  under `ai.admin_providers`.

## What it provides

- **One provider plugin:** `VertexProvider` (id **`google_vertex`**) in
  `src/Plugin/AiProvider/VertexProvider.php`, extending `AiProviderClientBase` and implementing
  `ChatInterface`, `EmbeddingsInterface`, `TranslateTextInterface`. Supported operation types:
  `chat`, `embeddings`, `translate_text` (`getSupportedOperationTypes()`).
- **No predefined models** (`$hasPredefinedModels = FALSE`): models are added dynamically in the
  settings form (Project ID, Location, Vertex model id, optional datastore).
- **Config form:** `VertexConfigForm` (`src/Form/VertexConfigForm.php`), a `ConfigFormBase` editing
  config object `ai_provider_google_vertex.settings`.
- **Translation model enum:** `TranslationModels` (`src/TranslationModels.php`) — cases `TLLM`
  (Translation LLM) and `NMT` (Neural Machine Translation); each builds its own endpoint/payload.
- **Streaming iterator:** `GoogleVertexChatIterator` (`src/GoogleVertexChatIterator.php`), a
  `StreamedChatMessageIterator` wrapping a gRPC `ServerStream`.
- **API definition:** `definitions/api_defaults.yml` (chat input/authentication/`max_tokens`).
- **No permissions, no routes beyond the settings form, no Drush.** Provides config schema.

## Details

- Authentication + how credentials are stored and how the OAuth2 token is minted, config keys,
  routes, models table → [config/settings.md](config/settings.md)
- The provider plugin: chat, embeddings, translation, tools, images, endpoints →
  [plugins/provider.md](plugins/provider.md)
