<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — AI Image generation

## Credentials
1. Get an OpenAI API key and Organisation ID from https://platform.openai.com.
2. Go to `/admin/content/ai_image_generation_settings` (needs `administer site configuration`).
3. Enter **Organisation ID** and **API Key**. Both are required. Saved to config `ai_images_api.settings` as `orgid` / `apikey`.

Note: values are stored in plain configuration (not a Key entity) and the key field is a normal textfield — exclude `ai_images_api.settings` from any shared config export or treat it as a secret.

## Generating
- Visit `/admin/content/ai_image_generation`. The **Generate Image** button is disabled until an API key is saved.
- Fields: prompt (`imgtext`, max 255), model (`apimodel`: dall-e-2/dall-e-3), size (`imgsize`), count (`imgcount`, 1–4; forced to 1 for dall-e-3), and dall-e-3-only `d3_style` / `d3_quality`.
- Generation is an AJAX callback (`::aiImageGeneration`); results are previewed and stashed in the session key `new_ai_image`.
- Tick the per-image save checkboxes and press **Save Image** to write files to `public://` and create `image` Media entities owned by the current user.
