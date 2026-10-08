<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NanoBanana Provider registers Google Gemini's image-generation models as a provider for the Drupal AI module.

---

NanoBanana Provider (by acolono GmbH) adds a `nanobanana` AI-provider plugin that integrates Google
Gemini's image-generation models — **Gemini 2.5 Flash Image** and **Gemini 3 Pro Image (preview)** —
with the Drupal AI module. It supports the AI module's **text-to-image** and **image-to-image**
operation types, plus a module-specific **multi-image composition** input (up to 3 images on Flash, up
to 14 on Pro) for building composite scenes. Options include aspect-ratio control (ten ratios) and,
on Gemini 3 Pro, output size (1K/2K/4K). Gemini returns image data inline as base64, which the module
decodes to PNG binaries. The API key is stored via the Key module; the settings form is at
`/admin/config/ai/providers/nanobanana` gated by `administer ai providers`. It also augments the AI API
Explorer's image-to-image screen with dynamic additional-image upload fields. Depends on the AI module
and the Key module.

---

- Register Google Gemini image models as a provider in the Drupal AI module.
- Generate images from a text prompt (text-to-image).
- Transform or edit an existing image from a prompt (image-to-image).
- Compose a single image from multiple reference images (multi-image input).
- Combine up to 3 images with Gemini 2.5 Flash, or up to 14 with Gemini 3 Pro.
- Choose an output aspect ratio from ten options (1:1, 16:9, 9:16, 21:9, …).
- Request 1K / 2K / 4K output resolution on Gemini 3 Pro.
- Pick a fast, low-latency model (Flash) or a high-quality model (Pro).
- Store the Gemini API key as a Key entity, out of exported config.
- Configure the key at `/admin/config/ai/providers/nanobanana`.
- Restrict provider configuration to users with `administer ai providers`.
- Generate images from the AI API Explorer's Text-To-Image and Image-To-Image screens.
- Upload extra reference images directly in the Image-To-Image explorer (fields appear automatically).
- Get copy-paste PHP code examples for multi-image generation from the explorer.
- Save generated images as managed File entities (`getAsFileEntity()`).
- Save generated images as Media entities (`getAsMediaEntity()`).
- Call the provider programmatically via `\Drupal::service('ai.provider')->createInstance('nanobanana')`.
- Produce marketing/hero imagery, product mockups or illustrations for content.
- Build an editorial workflow that generates or edits images from node text.
- Back an AI Automator that fills an image field from a prompt.
