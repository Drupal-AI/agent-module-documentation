<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `moonshot` AI provider plugin

`src/Plugin/AiProvider/MoonshotProvider.php` — `#[AiProvider(id: 'moonshot', label: 'Moonshot AI')]`,
extends `Drupal\ai\Base\AiProviderClientBase`, implements `ChatInterface`, uses `ChatTrait`.

## Operations

`getSupportedOperationTypes()` → `['chat']` only. `isUsable()` returns FALSE until an `api_key`
is configured.

### chat()

- Normalizes a `ChatInput`: optional system message from `$this->chatSystemRole`, then each
  message becomes `{ role, content: [ { type: text, text }, ... ] }`. Images from
  `$message->getImages()` are appended as `{ type: image_url, image_url: { url: <base64 data
  URL> } }` via `ImageFile::getAsBase64EncodedString()`.
- Messages with role `tool` are collapsed to `{ role: tool, content: <text> }`. `tool_call_id`
  and `tool_calls` are carried when present.
- Payload = `model` + `messages` + `$this->configuration`.
- Tools: if `getChatTools()` is set, renders `payload['tools']` with `function.strict = FALSE`.
- Structured output: if `getChatStructuredJsonSchema()` is set, adds
  `response_format = { type: json_schema, json_schema: ... }`.
- Calls `client->chat()->create()->toArray()` (no streaming). Decodes any
  `tool_calls` into `ToolsFunctionOutput`. Returns a `ChatOutput` wrapping a `ChatMessage`.

## Models

`getConfiguredModels('chat')` returns a fixed list combined into `id => id`:
`kimi-k3`, `kimi-k2.7-code`, `kimi-k2.7-code-highspeed`, `kimi-k2.6`. Any other operation type
returns `[]`. `getModelSettings()` returns the general config unchanged.

## Setup data

`getSetupData()` → `key_config_name: api_key`; default models:
`chat` → `moonshot-lite`; `chat_with_image_vision`, `chat_with_complex_json`,
`chat_with_tools`, `chat_with_structured_response` → `moonshot-pro`. (Note these default names
differ from the `kimi-*` model ids returned by `getConfiguredModels()`.)

## Client / auth

`setAuthentication($key)` stores the key and nulls the client. `loadClient()` lazily loads the
key via `loadApiKey()` (Key module) if not set, reads `host` from config, and builds the OpenAI
client with the injected Drupal `httpClient` (see [../config/settings.md](../config/settings.md)).
`getConfig()` → `ai_provider_moonshot.settings`.

The commented-out `getApiDefinition()` references a `definitions/api_defaults.yml` that this
project does not ship; as shipped the plugin does not override `getApiDefinition()`, so the base
class's default API definition applies.
