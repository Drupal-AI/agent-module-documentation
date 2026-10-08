<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Infomaniak AI Provider (ai_provider_infomaniak) — agent index

An **AI provider plugin** that lets the Drupal **AI module** use **Infomaniak's AI Tools** (Swiss,
OpenAI-compatible) for **chat, embeddings, text-to-image and image-to-image**. Version
**1.0.0-alpha1**, version-dir `1.0.x`. Core `^10.4 || ^11`. PHP `>=8.1`. License GPL-2.0-or-later.
Package *AI Providers*. (No stable security-advisory coverage yet.)

- **Dependencies:** `ai:ai` (`^1.2.4`), `key:key`, and the Composer library `openai-php/client`
  (`^0.7 || … || ^0.18`).
- **Configure at:** route `ai_provider_infomaniak.settings_form` →
  `/admin/config/ai/providers/infomaniak` (permission **`administer ai providers`**), menu under
  `ai.admin_providers`.

## What it provides

- **One provider plugin:** `InfomaniakProvider` (id **`infomaniak`**) in
  `src/Plugin/AiProvider/InfomaniakProvider.php`, extending
  `Drupal\ai\Base\OpenAiBasedProviderClientBase` and implementing `ImageToImageInterface` (plus
  chat/text-to-image/embeddings via the base). `getSupportedOperationTypes()` lists `chat`,
  `text_to_image`, `speech_to_text`, `text_to_speech`, `image_to_image`, `embeddings`, `moderation`
  (the models shipped only cover chat, embeddings and text_to_image; image_to_image is implemented in
  code). Capabilities: `StreamChatOutput`, `ChatFiberSupport`.
- **Predefined models** (`$hasPredefinedModels = TRUE`) from config object
  **`ai_provider_infomaniak.models`** (`config/install/…models.yml`) — chat, embedding and image
  models.
- **Two forms/routes:** `InfomaniakConfigForm` (main settings, `.settings_form`) and `ModelEditForm`
  (per-model tuning, `.edit_model`), both permission `administer ai providers`.
- **Config schema:** `ai_provider.infomaniak` (extends the AI module's `ai_provider` type) +
  `ai_provider_infomaniak.models`. Config object `ai_provider_infomaniak.settings`.
- **Permission:** `autocomplete infomaniak model list` is declared in `.permissions.yml` but no route
  currently uses it. No Drush.

## Details

- Install, credentials (API token + Product ID), config objects/keys, endpoints, routes, the models
  table and per-model editor → [config/settings.md](config/settings.md)
- The provider plugin: chat/embeddings (via OpenAI base), text-to-image, image-to-image, error
  handling → [plugins/provider.md](plugins/provider.md)
