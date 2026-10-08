<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `x` AI provider plugin

`src/Plugin/AiProvider/XProvider.php` — `#[AiProvider(id: 'x', label: 'X')]`, extends
`AiProviderClientBase` and implements `ChatInterface` and `EmbeddingsInterface` (uses `ChatTrait`).

## Endpoint & client

Two clients are used:

- **Main path:** `loadClient()` builds an `OpenAI\Client` via `\OpenAI::factory()`
  `->withApiKey($this->apiKey)->withBaseUri('https://api.x.ai/v1')->withHttpClient($this->httpClient)->make()`.
  The base URI is hard-coded (not admin-settable) and the transport is the injected Drupal
  `http_client` (Guzzle). Auth is `Authorization: Bearer <key>` handled by the OpenAI client.
- **Raw path:** `getCustomClient()` / `loadCustomClient()` return `Drupal\ai_provider_x\XClient`
  (service `ai_provider_x.api`), a thin Guzzle wrapper with base URL `https://api.x.ai/v1/` used only
  for the `moderations` endpoint (`XClient::moderation()`), setting the Bearer header and a 120s
  connect/read timeout.

`setAuthentication($key)` stores the key and nulls the client so the next call rebuilds it; the key is
resolved from the configured Key entity via the base class `loadApiKey()` when not already set.

## Models (`getModels()` / `getConfiguredModels()`)

Hard-coded, not fetched from the API:

| Operation | Models |
|---|---|
| `chat` | `grok-2-latest`, `grok-2-1212`, `grok-2-vision-1212` |
| `chat` + capability `ChatWithImageVision` | only `grok-2-vision-1212` |

`getSupportedOperationTypes()` returns `chat` and `chat_with_image_vision`. `isUsable()` returns false
until `api_key` is set. `getApiDefinition()` reads `definitions/api_defaults.yml`. `getModelSettings()`
passes general config through unchanged. `maxEmbeddingsInput()` returns a flat `1024`.

## `chat()`

Normalizes a `ChatInput` into OpenAI-style messages: an optional system role (`$this->chatSystemRole`),
then each message as `role` + a `content` array of `{type:text}` parts, appending
`{type:image_url, image_url:{url: <base64 data URI>}}` for every attached image
(`$image->getAsBase64EncodedString()`). Payload is `model` + `messages` + `$this->configuration`.

Notable: it wraps the call in `set_error_handler([$this,'errorCatcher'], E_ALL)` to convert a PHP
warning (from xAI's response keys differing from OpenAI's) into an `AiResponseErrorException`. When
`$this->streamed` is true it returns an `XChatMessageIterator` over `chat()->createStreamed()`;
otherwise it returns a `ChatMessage` from `choices[0].message`. Result is a `ChatOutput`.

## `embeddings()`

Sends `{model, input}` + `$this->configuration` to `embeddings()->create()` and returns an
`EmbeddingsOutput` built from `data[0].embedding`.

## Streaming — `XChatMessageIterator`

`src/XChatMessageIterator.php` extends `StreamedChatMessageIterator`; its `getIterator()` yields a
`StreamedChatMessage` per delta (`choices[0].delta.role` / `.content`), JSON-encoding any `metadata`.
