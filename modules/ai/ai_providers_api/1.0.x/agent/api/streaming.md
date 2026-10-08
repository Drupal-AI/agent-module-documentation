<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AiService, the `/ai/stream` endpoint, and the JS client

## AiService (server-side entry point)

Service `Drupal\ai_providers_api\AiService` (interface `AiServiceInterface`; autowired).

```php
public function __construct(protected AiServiceInterface $aiService) {}
$text   = $this->aiService->prompt('gemini', 'Summarise: …');
$stream = $this->aiService->streamPrompt('claude', $prompt, ['model' => 'claude-…']);
```

- `prompt(string $provider_id, string $prompt, array $options = []): string`
- `streamPrompt(string $provider_id, string $prompt, array $options = []): iterable`
- `createProvider()` (private): throws `AiException` if the provider id has no plugin
  definition; reads config `providers.<id>.configuration`; if `options['model']` is a
  non-empty string it overrides the configured `model`; then
  `providerManager->createInstance($id, $config)`.

Only the `model` option is honoured. `AiException` is thrown on unknown provider or HTTP
failure (Guzzle errors are caught in `AiProviderBase` and re-thrown via `error()`).

## The `/ai/stream` route (POST)

`Controller\AiResponseController` (`ai_providers_api.stream`, methods `[POST]`).

### Access — denied by default

`_custom_access: AiResponseController::access`. It JSON-decodes the request body and
invokes `hook_ai_stream_access($body, $account)` on every module:

- any result `isForbidden()` → returns that forbidden immediately;
- the first `isAllowed()` (with no forbidden seen) becomes the running result;
- final: `allowed` if some module allowed, otherwise **`AccessResult::forbidden()`**.

So with no implementing module the endpoint is **403**. An integrator module (e.g. LMS
AI) implements the hook, inspects the decoded body (it receives the full body so it can
check app-specific params), and decides. **The access decision is entirely delegated —
this module ships no open AI endpoint.**

### `stream()`

Reads JSON body keys: `provider` (plugin id), `prompt`, optional `model`. Runs
`hook_ai_providers_api_prompt_alter($prompt, $body)` (modules may rewrite the prompt or
read extra body params), then returns an `AiStreamedResponse` whose callback iterates
`aiService->streamPrompt($provider_id, $prompt, $options)`, echoing + `flush()`ing each
chunk. `AiException` is caught and its message echoed into the stream.

`AiStreamedResponse` (extends Symfony `StreamedResponse`) sets streaming-friendly headers
(`X-Accel-Buffering: no`, `Surrogate-Control: no-store`, `Cache-Control: no-cache`,
`Content-Type: text/plain; charset=UTF-8`) and flushes all PHP output buffers in
`sendContent()`.

## The JS client (`ai_streaming_api` library)

`js/ai_streaming_api.js` — `Drupal.behaviors.aiStreamingApi` attaches to any element with
`data-ai-integration-id`. The attribute value keys into `drupalSettings`:

```js
drupalSettings[integrationId] = {
  provider: 'ollama',              // required
  promptSourceId: 'my-input',      // required – element to read the prompt from
  replyTargetSelector: '#reply',   // required – where to stream the answer
  model: 'llama3.2:3b',            // optional
  extraParams: {},                 // optional – merged into the POST body
  includeHistory: false,           // optional – send prior {answer,feedback} pairs
};
```

On click it reads the prompt (`value` for INPUT/TEXTAREA, else `innerHTML`), POSTs JSON to
`<baseUrl><pathPrefix>ai/stream` with `credentials: 'same-origin'`, and streams the
`text/plain` response. Chunks are appended to the target via `textContent` (multi-word
chunks animate word-by-word; ≤2-word chunks append immediately). When `includeHistory` is
set, prior exchanges are kept in memory and sent as `history` on later calls.

Because responses are written with `targetEl.textContent` (not `innerHTML`), model output
is inserted as text, not markup.

## Hooks summary

- `hook_ai_stream_access(array $body, AccountInterface $account): AccessResultInterface`
  — gate the `/ai/stream` route (default-deny; implement to allow).
- `hook_ai_providers_api_prompt_alter(string &$prompt, array $body)` — mutate the prompt
  before dispatch.
- `hook_ai_providers_api_provider_info_alter(array &$definitions)` — alter plugin
  definitions (manager `alterInfo`).
