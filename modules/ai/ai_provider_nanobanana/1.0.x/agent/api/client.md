<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NanoBanana Gemini client & explorer integration

## The `NanoBanana` client (`src/NanoBanana.php`, service `nanobanana.api`)

Constructed with `@http_client` (Guzzle), `@config.factory`, `@key.repository`. In the constructor it
reads `ai_provider_nanobanana.settings:api_key` and, if set, resolves the Key entity value via
`$keyRepository->getKey($key)->getKeyValue()`. `setApiKey()` overrides it at runtime.

- **Base URL:** `https://generativelanguage.googleapis.com/` (hard-coded).
- **Default model:** `gemini-2.5-flash-image`.

### Generation methods

- `generateImage($prompt, $model_id, $options)` — text-to-image. Builds
  `{contents:[{parts:[{text:$prompt}]}], generationConfig}`.
- `generateImageFromImage($imageBinary, $prompt, $model_id, $options)` — image-to-image. Base64-encodes
  the input, detects its MIME with `finfo`, sends it as an `inline_data` part plus optional text.
- `generateImageFromImages(array $imageBinaries, $prompt, $model_id, $options)` — multi-image; one
  `inline_data` part per image plus optional text.

All three POST to `v1beta/models/{model_id}:generateContent` and return the output of
`extractImagesFromResponse()`.

### `buildGenerationConfig()`

`responseModalities` is `['TEXT','IMAGE']` for `gemini-3-pro-image-preview`, else `['Image']`. Adds
`imageConfig.aspectRatio` when set, and `imageConfig.imageSize` (uppercased) only for Gemini 3 Pro.

### `extractImagesFromResponse()`

JSON-decodes the body and, for each `candidates[].content.parts[]`, base64-decodes `inline_data.data`
(or the camelCase `inlineData.data`) into a raw image binary. Throws if no candidates / no image data.
**No URL is read or fetched from the response** — image bytes are returned inline, so there is no
server-side image-URL fetch.

### `makeRequest()`

Requires the API key (throws otherwise), appends it to the query string
(`$query_string['key'] = $this->apiKey`) — Google's documented Gemini auth mechanism — over the fixed
`https://generativelanguage.googleapis.com/` base via the injected Guzzle client. Sets `timeout: 180`,
`connect_timeout: 60`, `read_timeout: 180`, `http_errors: FALSE`, and `Content-Type: application/json`.
Throws on any 4xx/5xx with the response body.

## AI API Explorer integration (`ai_provider_nanobanana.module`)

`hook_form_ai_api_explorer_form_alter()` — only when the image-to-image explorer form is present and
the selected provider is `nanobanana` with a Gemini model — injects an **Additional Images** multi-file
upload (`#type: file`, `accept image/png,image/jpeg`, max 2 for Flash / 13 for Pro), attaches the
`ai_provider_nanobanana/image_preview` library, adds a validation handler
(`_ai_provider_nanobanana_validate_additional_images`, enforcing the per-model image count), and wraps
the submit AJAX callback with `_ai_provider_nanobanana_image_to_image_wrapper`.

The wrapper, on additional images, calls `_ai_provider_nanobanana_multi_image_response()`: it reads the
main image from the request and the additional uploads from `$_FILES` (the standard PHP upload temp
files), builds `ImageFile` objects, requires a prompt for true multi-image composition, calls
`$provider->imageToImage(...)`, saves each result binary to `temporary://ai-explorers/<md5>.png`, and
renders it via `#theme: image` plus a copy-paste PHP code example. This path runs inside the
permission-gated AI API Explorer (admin tooling); the only files read are the operator's own uploads.
