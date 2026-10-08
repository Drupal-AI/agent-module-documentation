<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Huggingface Provider (ai_provider_huggingface) — agent index

An **AI provider plugin** that lets the Drupal **AI module** use the **Hugging Face Inference API**
for chat, embeddings, summarization, image classification and object detection. Version
**1.0.0-rc1**, version-dir `1.0.x`. Core `^10.2 || ^11`. License GPL-2.0-or-later. Package
*AI Providers*.

- **Dependencies:** `ai:ai` (`^1.3.x-dev@dev`), `key:key` (`^1.18`). No non-Drupal Composer libs.
- **Configure at:** route `ai_provider_huggingface.settings_form` →
  `/admin/config/ai/providers/huggingface` (permission **`administer ai providers`**), menu under
  `ai.admin_providers`.

## What it provides

- **One provider plugin:** `HuggingfaceProvider` (id **`huggingface`**) in
  `src/Plugin/AiProvider/HuggingfaceProvider.php`, extending `AiProviderClientBase` and implementing
  `ChatInterface`, `EmbeddingsInterface`, `ImageClassificationInterface`, `SummarizationInterface`,
  `ObjectDetectionInterface`. Supported operation types: `chat`, `embeddings`,
  `image_classification`, `summarize`, `object_detection` (each mapped to a Hugging Face pipeline
  tag: `text-generation`, `feature-extraction`, `image-classification`, `summarization`,
  `object-detection`).
- **No predefined models** (`$hasPredefinedModels = FALSE`): each model is added in the settings
  form with an **Endpoint** field (model name for serverless, or a full dedicated-endpoint URL).
- **API wrapper service:** `ai_provider_huggingface.api` → `HuggingfaceApi`
  (`src/HuggingfaceApi.php`), constructed with `@http_client`; wraps many HF task calls plus
  `chatCompletions()` / `chatCompletionsStreamed()` (SSE).
- **Config form:** `HuggingfaceConfigForm` (`src/Form/HuggingfaceConfigForm.php`), editing config
  object `ai_provider_huggingface.settings`.
- **Autocomplete controller:** `HuggingfaceAutocomplete::models`
  (`src/Controller/HuggingfaceAutocomplete.php`) at `/admin/ai/huggingface/autocomplete/models`.
- **Streaming iterator:** `HuggingfaceChatMessageIterator` (`src/HuggingfaceChatMessageIterator.php`).
- **Permission:** `autocomplete huggingface model list` (`.permissions.yml`). Provides config schema.
- **Install hook** migrates config from the older AI-core `provider_huggingface` submodule and
  uninstalls it.

## Details

- Install, config object + keys, routes & permissions, the models table and autocomplete →
  [config/settings.md](config/settings.md)
- The provider plugin + `HuggingfaceApi` wrapper: operations, endpoints, streaming →
  [plugins/provider.md](plugins/provider.md)
