<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# InfomaniakProvider plugin

`src/Plugin/AiProvider/InfomaniakProvider.php` — `#[AiProvider(id: 'infomaniak', label: 'Infomaniak
AI')]`, extends `Drupal\ai\Base\OpenAiBasedProviderClientBase`, implements `ImageToImageInterface`.
Chat, embeddings, speech-to-text and moderation are inherited from the OpenAI-compatible base class;
this class adds the Infomaniak endpoint wiring plus custom `textToImage()` and `imageToImage()`.

## Model catalogue & usability

- `getModelDefinitions()` reads `ai_provider_infomaniak.models:definitions`.
- `getConfiguredModels($op)` filters that list by `operation_type` and returns `id => name`.
- `isUsable()` → FALSE unless an API key (or live authentication) **and** a `product_id` are
  configured; then checks the op is in `getSupportedOperationTypes()`.
- `$hasPredefinedModels = TRUE`.
- `getMaxInputTokens()` / `getMaxOutputTokens()` default to 8192 / 4096 unless overridden per model.

## Authentication & client

- `setAuthentication($auth)` accepts a string (api key) or an array (`api_key` + `product_id`), then
  resets the client.
- `loadClient()` loads authentication if needed, calls `setEndpoint(buildEndpointUrl())` and
  `createClient()` (base class); failures become `AiSetupFailureException`.
- `buildEndpointUrl()` → `{base_url}/{product_id}/openai/v1`.

## textToImage()

Builds a **one-time** OpenAI client against the v1 image endpoint
`https://api.infomaniak.com/1/ai/{product_id}/openai` via
`\OpenAI::factory()->withApiKey($this->apiKey)->withHttpClient($this->httpClient)->withBaseUri($endpoint)->make()`,
then `images()->create(['model'=>…, 'prompt'=>…] + $this->configuration)`. Each response item is
turned into an `ImageFile` from `b64_json`, or fetched from a returned `url`
(`file_get_contents($data['url'])`, wrapped in try/catch with an error log on failure). Throws
`AiResponseErrorException` if no image is produced.

## imageToImage()

Normalizes `ImageToImageInput` (or a file path), saves the image (and optional mask) to
`temporary://` via `fileSystem->saveData()`, opens file handles into an `images()->edit()` payload
(`model`, `image`, optional `prompt`/`mask`, plus `$this->configuration`), and maps the response the
same way as `textToImage()`. `requiresImageToImagePrompt()` = TRUE, `requiresImageToImageMask()` =
FALSE, `hasImageToImageMask()` = TRUE.

## Error handling

`handleApiException()` inspects the exception message and maps Infomaniak-specific patterns:
`product_id`/`invalid product` → `AiSetupFailureException`; `429`/`Too Many Requests`/`rate limit` →
`AiRateLimitException`; `quota`/`insufficient credits`/`billing` → `AiQuotaException`;
`401`/`Unauthorized`/`invalid api key` → `AiSetupFailureException`; otherwise delegates to the parent
OpenAI handler.

## getSetupData()

Returns `key_config_name = 'api_key'` and a `default_models` map (first configured model per op type
for chat, text_to_image, speech_to_text, image_to_image, embeddings), consumed by
`InfomaniakConfigForm` to seed provider defaults.
