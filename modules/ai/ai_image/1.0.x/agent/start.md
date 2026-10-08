<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Image Generator Ckeditor (ai_image) — agent index

**CKEditor 5 plugin + JSON endpoint that generates an image from an author prompt using the `ai` module's text-to-image providers.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** `ai` (uses the `ai.provider` plugin manager); `key` (README) for the provider API key.
- **Route:** `ai_image.getimage` — `POST /api/ai-image/getimage` → `AIImgController::getimage()`, requirement `_permission: 'access content'`.
- **Service:** `ai_image.get_image` (`GetAIImage`) → `getImage($provider,$model,$prompt)`; saves `public://generated_image.png`, returns absolute URL.
- **Plugin:** `Plugin/CKEditor5Plugin/AiImage` (toolbar button + settings). Config override hook: `ai_image_alter_config`.

See [api/getimage-endpoint.md](api/getimage-endpoint.md).