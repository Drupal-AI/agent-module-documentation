<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Image generation module (ai_image_generation) — agent index

**Generates images from text prompts via the OpenAI DALL·E API and saves them as Media entities.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Depends:** drupal:media
- **Configure:** `ai_image_generation.settings` → `/admin/content/ai_image_generation_settings`
- **Routes:** `ai_image_generation.settings` (API creds form) and `ai_image_generation.generate` (generation form) both `administer site configuration`; `ai_image_generation.usage_page` (`/ai_image_generation/AIusage`) `access content`.
- **Key config:** `ai_images_api.settings` holds `apikey` + `orgid` (plaintext).
- **Sink:** `AIImageGenerate::fetchimagebyAPI()` POSTs to `https://api.openai.com/v1/images/generations` over HTTPS.

**Security:** both generation/credential forms are gated by `administer site configuration`; the anonymous `access content` pricing route (`APIUsage::usagePage`) returns only a hard-coded pricing table and leaks no key or usage data. Note: the OpenAI API key is stored in plain config and shown in a plain textfield, and every generation call incurs OpenAI cost — keep the admin permission tight.

See [configure/settings.md](configure/settings.md) and [api/generation.md](api/generation.md).
