<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `AiProvider` plugin type (Claude, Gemini, Ollama)

## Plugin type wiring

- Manager: `AiProviderManager` (service `plugin.manager.ai_providers_api_provider`,
  parent `default_plugin_manager`, config factory injected via `setConfigFactory`).
  Discovers `Plugin/AiProvider` classes carrying `#[AiProvider]`, interface
  `Plugin\AiProviderInterface`, alter hook `ai_providers_api_provider_info`, cache key
  `ai_providers_api_provider`.
- Attribute: `Attribute\AiProvider(string $id, TranslatableMarkup $label, ?string $deriver)`.
- `AiProviderManager::getEnabledDefinitions()` returns only providers whose
  `providers.<id>.enabled` config flag is TRUE.

## Base class contract (`AiProviderBase`)

Implements `AiProviderInterface`, injects `logger.channel.ai_providers_api` and core
`http_client`. Concrete `prompt()` / `streamPrompt()` live here; subclasses implement
five abstract hooks:

| Method | Purpose |
|---|---|
| `getEndpoint(bool $streaming): string` | API URL (per provider; may differ for streaming). |
| `getHeaders(): array` | Request headers (auth); call `error()` if a credential is missing. |
| `buildPayload(string $prompt, bool $streaming): array` | JSON request body. |
| `extractText(array $data): string` | Pull the answer from a non-streaming response. |
| `extractDelta(array $chunk): ?string` | Pull a text chunk from one streaming chunk. |

`prompt()` does a Guzzle `POST` (`headers` + `json`), decodes and returns `extractText()`.
`streamPrompt()` posts with `'stream' => TRUE` and iterates `readStream()` →
`extractDelta()`, yielding non-empty text. Stream readers: `readNdjsonStream()` (default,
one JSON object per line) and `readSseStream()` (SSE `data:` lines, stops at `[DONE]`).
`error()` logs to the channel and throws `AiException` (`never`-return).

Config form: `buildConfigurationForm()` adds a shared optional **API endpoint URL** field
(`#type url`, blank = provider default); `submitConfigurationForm()` saves it. Subclasses
call `parent::` and add their own fields.

## Shipped providers

### Claude (`id: claude`)

- Endpoint: `endpoint_url` override or `https://api.anthropic.com/v1/messages`.
- Headers: `x-api-key: <api_key>`, `anthropic-version: 2023-06-01` (errors if no key).
- Payload: `{ model, messages:[{role:user, content:$prompt}], max_tokens:8192, stream }`.
- Streaming: SSE (`readSseStream`); `extractDelta()` reads `content_block_delta` →
  `delta.text`. `extractText()` reads `content[0].text`.
- Config form: **API key** (`#type password`, blank-to-keep), **Model** (default
  `claude-sonnet-4-6`).

### Gemini (`id: gemini`)

- Endpoint: override or
  `https://generativelanguage.googleapis.com/v1beta/models/<model>:generateContent`
  (streaming: `:streamGenerateContent?alt=sse`). Errors if model unset.
- Headers: `x-goog-api-key: <api_key>` (errors if no key).
- Payload: `{ contents:[{role:user, parts:[{text:$prompt}]}] }`.
- Streaming: SSE; `extractDelta()`/`extractText()` read
  `candidates[0].content.parts[0].text`.
- Config form: **API key** (`#type password`), **Model** (default
  `gemini-2.5-flash-preview`).

### Ollama (`id: ollama`)

- Endpoint: override or `http://ollama:11434/api/chat` (local service; no API key).
- Headers: none. Payload: `{ model, messages:[{role:user, content:$prompt}], stream }`.
- Streaming: NDJSON (base default); `extractDelta()` returns `message.content` until
  `done` is true. `extractText()` reads `message.content`.
- Config form: **Model** only (default `llama3.2:3b`).

## Add your own provider

1. Class in `src/Plugin/AiProvider/` of your module, `extends AiProviderBase`.
2. Add `#[AiProvider(id: 'my_provider', label: new TranslatableMarkup('My Provider'))]`.
3. Implement the five abstract methods; add config-form fields (call `parent::`).
4. Add a `config/schema` entry
   `ai_providers_api.provider.my_provider: { type: ai_providers_api_provider_configuration, … }`.
5. Enable/configure it at `/admin/ai-providers/settings`.

To inject services (e.g. a different HTTP client) override `create()` and call
`parent::create()` first.
