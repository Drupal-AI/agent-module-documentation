<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a CKEditor 5 "AI Image" button that sends the author's prompt to a configured AI text-to-image provider and inserts the returned image.

---
The module wires the `drupal/ai` provider framework into the editor. In CKEditor the `AiImage` plugin collects a prompt (plus optional extra prompt text and a chosen provider/model) and POSTs it as JSON to `/api/ai-image/getimage`. The `AIImgController::getimage()` controller parses `provider__model`, falls back to the site's default `text_to_image` provider when none is chosen, and hands the prompt to the `ai_image.get_image` service. `GetAIImage::getImage()` builds provider-specific config (OpenAI DALL·E style, or Stable-Diffusion style with a baked-in negative prompt), lets other modules override it via the `ai_image_alter_config` hook, calls `$provider->textToImage()`, saves the first result as a public file (`public://generated_image.png`) and returns its absolute URL as JSON.

Operationally you need the `key` and `ai` modules, an AI provider configured with an API key (OpenAI or a Stable Diffusion provider), and the text format's toolbar set up with the Image and AI Image buttons. Generated images land in the public files directory.
---
- Add an "AI Image" button to a CKEditor 5 text format toolbar.
- Generate an illustration from a typed prompt while editing a node.
- Use OpenAI DALL·E as the text-to-image backend.
- Use a Stable Diffusion provider as the backend.
- Fall back to the site's default `text_to_image` provider automatically.
- Store the AI provider API key as a Key entity (`admin/config/system/keys`).
- Select provider and model per editor via the plugin settings.
- Append fixed "extra" prompt text to every generation.
- Override generation parameters with `hook_ai_image_alter_config()`.
- Insert the generated image URL directly into the editor body.
- Save generated images to the public files directory.
- Prototype AI art workflows inside the standard node form.
- Provide editors a one-click prompt-to-image affordance.
- Swap providers without changing editor configuration (default provider).
- Tune image size/quality via the provider config block.
- Add a negative prompt automatically for Stable Diffusion models.
- Log generation errors to the `ai_image` logger channel.
- Audit AI image spend by monitoring calls to the endpoint.
- Combine with the core Image button so authors mix uploaded and AI images.