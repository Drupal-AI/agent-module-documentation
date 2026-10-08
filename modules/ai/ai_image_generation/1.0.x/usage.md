<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Image generation adds an admin UI that turns text prompts into images through OpenAI's DALL·E 2/3 API and stores the results in the Drupal media library.

---

The module exposes two admin forms behind `administer site configuration`: a settings form (`/admin/content/ai_image_generation_settings`) where the OpenAI Organisation ID and API key are entered, and a generation form (`/admin/content/ai_image_generation`) where an editor writes a prompt, picks the model (dall-e-2/dall-e-3), size, count, and DALL·E 3 style/quality, then generates images via an AJAX call. Generated images come back base64-encoded (`response_format=b64_json`), are previewed inline, and the ones the editor checkbox-selects are decoded and written to `public://` as JPEG files wrapped in `image` Media entities. A third public route (`/ai_image_generation/AIusage`) renders a static DALL·E pricing table.

Operational notes: the request runs server-side with Guzzle over HTTPS to `https://api.openai.com/v1/images/generations`; each call costs money per OpenAI's pricing, so access to the generation form should stay limited to trusted admins. The API key and Organisation ID are stored in plain module configuration (`ai_images_api.settings`), not in a Key entity, and the settings form renders the key in a plain textfield — treat the config export as sensitive. Generated image bytes are held transiently in the PHP session between generate and save. The public pricing route only shows hard-coded numbers, so it leaks no key or usage data.

---
- Enter an OpenAI Organisation ID and API key on the settings form
- Restrict who holds `administer site configuration` to control API spend
- Generate one or more images from a text prompt
- Choose between DALL·E 2 and DALL·E 3 models
- Pick image resolution (256x256 up to 1792x1024)
- Set DALL·E 3 style (vivid/natural) and quality (standard/HD)
- Request 1–4 images at once with DALL·E 2
- Preview generated images inline before saving
- Select specific generated images to keep via checkboxes
- Save chosen images as `image` Media entities in the media library
- Link saved media to the current user as owner
- View the OpenAI pricing structure in an off-canvas dialog
- Jump to the OpenAI usage dashboard via the provided link
- Reuse saved AI images anywhere the media library is referenced
- Diagnose API errors (e.g. 429 rate limits) surfaced in the form
- Store the API credentials centrally in site config
- Audit AI image requests/responses in the Drupal log (dblog)
