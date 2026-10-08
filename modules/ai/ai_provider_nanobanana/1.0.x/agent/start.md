<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NanoBanana Provider (ai_provider_nanobanana) — agent index

An AI-provider plugin (by acolono GmbH) that registers **Google Gemini image-generation models** with
the Drupal AI module and calls `https://generativelanguage.googleapis.com/v1beta`.

- **Version dir:** 1.0.x (packaged `1.0.0-beta1`) · **Core:** `^10.3 || ^11` · **Package:** AI Providers
- **Depends on:** `ai:ai`, `key:key`.
- **Provides:** one AI provider plugin `id: nanobanana` (`src/Plugin/AiProvider/NanoBananaProvider.php`).
- **Operation types:** `text_to_image`, `image_to_image`.
- **Models:** `gemini-2.5-flash-image`, `gemini-3-pro-image-preview`.
- **Config object:** `ai_provider_nanobanana.settings` (single key `api_key`, a Key-module key id).
- **Route / form:** `ai_provider_nanobanana.settings` at `/admin/config/ai/providers/nanobanana`
  (`NanoBananaConfigForm`), permission `administer ai providers`.
- **Service:** `nanobanana.api` → `Drupal\ai_provider_nanobanana\NanoBanana` (HTTP client for the
  Gemini `generateContent` endpoint), constructed with `@http_client`, `@config.factory`,
  `@key.repository`.
- **Extra input type:** `src/OperationType/MultiImageToImageInput.php` — extends the AI module's
  `ImageToImageInput` to carry additional reference images.
- **Asset library:** `ai_provider_nanobanana/image_preview` (`js/image-preview.js`,
  `css/image-preview.css`) for thumbnail previews in the explorer.
- **Hook:** `ai_provider_nanobanana.module` implements `hook_form_ai_api_explorer_form_alter()` to
  inject the multi-image upload fields and a wrapper AJAX callback.
- **Menu link:** `ai_provider_nanobanana.settings` under `ai.admin_providers`.

## How images come back

Gemini returns image bytes **inline as base64** in `candidates[].content.parts[].inline_data.data`;
`NanoBanana::extractImagesFromResponse()` base64-decodes them into PNG binaries. The module does not
fetch any image URL from the response. The API base URL and model paths are fixed in code.

No permissions, Drush commands, entities or submodules of its own.

## Solution docs

- Configuration & key setup: [`config/settings.md`](config/settings.md)
- The `nanobanana` provider plugin (operations, models, options): [`plugins/nanobanana_provider.md`](plugins/nanobanana_provider.md)
- The Gemini client + multi-image explorer integration: [`api/client.md`](api/client.md)
