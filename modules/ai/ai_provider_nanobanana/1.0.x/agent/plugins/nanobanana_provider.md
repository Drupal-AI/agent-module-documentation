<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `nanobanana` AI provider plugin

`src/Plugin/AiProvider/NanoBananaProvider.php` — `#[AiProvider(id: 'nanobanana', label: 'NanoBanana')]`,
extends `AiProviderClientBase` and implements `TextToImageInterface` and `ImageToImageInterface` (uses
`ImageToImageTrait`).

## Wiring

`create()` pulls the `nanobanana.api` service (the `NanoBanana` client) and `entity_type.manager` into
the plugin. `setAuthentication($key)` forwards the key to `NanoBanana::setApiKey()`. A `__destruct()`
deletes any temporary File entities the plugin tracked in `$temporaryFiles`.

## Models & capabilities

- `getConfiguredModels()` returns `gemini-2.5-flash-image` ("Fast, low-latency") and
  `gemini-3-pro-image-preview` ("High quality, 4K support") for `text_to_image` / `image_to_image`
  (or when no operation type is given).
- `getSupportedOperationTypes()` → `['text_to_image', 'image_to_image']`.
- `isUsable()` is false until `ai_provider_nanobanana.settings:api_key` is set.
- `getModelSettings()` removes the `imageSize` option for `gemini-2.5-flash-image` (Pro-only).
- `requiresImageToImageMask()`/`hasImageToImageMask()` → false; `requiresImageToImagePrompt()` → false;
  `hasImageToImagePrompt()` → true.
- `getApiDefinition()` reads `definitions/api_defaults.yml`.

## `textToImage()`

Normalizes `TextToImageInput` to its text, calls `NanoBanana::generateImage($prompt, $model_id,
$this->configuration)`, and wraps each returned binary in an `ImageFile($binary, 'image/png',
"nanobanana_<i>.png")`. Returns a `TextToImageOutput`. Errors are re-thrown as
`AiResponseErrorException`.

## `imageToImage()`

Requires an `ImageToImageInput`. If it is the module's `MultiImageToImageInput`, all images
(`getAllImages()` → binaries) go to `NanoBanana::generateImageFromImages(...)`; otherwise the single
image goes to `generateImageFromImage(...)`. Returned binaries are wrapped as `ImageFile` PNGs in an
`ImageToImageOutput`.

## `MultiImageToImageInput`

`src/OperationType/MultiImageToImageInput.php` extends the AI module's `ImageToImageInput` with an
`$additionalImages` array: `addAdditionalImage()`, `setAdditionalImages()`, `getAdditionalImages()`,
and `getAllImages()` (main image + additional). Flash supports 1 main + 2 additional; Pro supports 1
main + 13 additional.

See [`../api/client.md`](../api/client.md) for the HTTP client and the AI API Explorer integration.
