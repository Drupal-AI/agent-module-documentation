<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API surface — AI Image generation

The module has no exported PHP/Drush API; it is driven entirely through the admin form `\Drupal\ai_image_generation\Form\AIImageGenerate`.

## OpenAI request
`fetchimagebyAPI($model, $prompt, $count, $size, $quality, $style)` builds a Guzzle POST to `https://api.openai.com/v1/images/generations` (HTTPS, TLS verification on by default):
- Headers: `Authorization: Bearer <apikey>`, `Content-Type: application/json`.
- Body: `model`, `prompt`, `size`, `n`, `response_format=b64_json`; dall-e-3 adds `style` and `quality`.
- Returns the raw Guzzle response; non-200 (e.g. 429) messages are surfaced in the form.

## Saving
On submit, `submitForm()` reads `new_ai_image` from the session, `base64_decode()`s each selected image's `b64_json`, writes `public://ai_image<N>_<uniqid>.jpg` via `file.repository`, and creates a `media:image` entity (`field_media_image`) owned by the current user.

Request/response bodies are logged verbatim to the `AI Image` logger channel — avoid enabling this on a site where dblog is broadly readable.
