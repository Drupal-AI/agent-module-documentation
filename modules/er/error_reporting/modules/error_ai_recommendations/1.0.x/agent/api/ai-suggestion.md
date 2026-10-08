<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI suggestion endpoint & provider call — error_ai_recommendations

## Route

- `error_ai_recommendations.response` (`error_ai_recommendations.routing.yml`):
  - path `/ai-suggestion/response`
  - `_controller: \Drupal\error_ai_recommendations\Controller\AiSuggestionController` (invokable)
- Called by the parent template's `fixErrorWithAI()` JS via `fetch('/ai-suggestion/response',
  {method:'POST', body: JSON.stringify({code: code_list[0], error_msg: ...})})`.

## Controller (`src/Controller/AiSuggestionController.php`)

`AiSuggestionController` is `final`, extends `ControllerBase`.

- `__invoke(Request $request): JsonResponse`
  - `$encoded = $request->getContent()`; empty → logs via `logError()` and returns
    `errorResponse('No encoded string provided')` (HTTP 400).
  - `json_decode($encoded)`; on `json_last_error()` → `errorResponse('Invalid JSON provided')`.
  - Extracts `code.content`, `code.file`, `code.line`, `error_msg` (all default to `''`).
  - Returns `new JsonResponse(['response' => getAiResponse(...)])`.
- `getAiResponse($codeLines, $error, $lineNumber, $filePath): string`
  - `$defaults = \Drupal::service('ai.provider')->getDefaultProviderForOperationType('chat')`.
  - If `provider_id` or `model_id` is empty → throws `Exception('No default AI provider/model
    configured.')`.
  - `$provider = ai.provider->createInstance($defaults['provider_id'])`.
  - Builds `ChatInput` with a `system` message ("You are a Drupal pro developer. Fix the following
    error…") and a `user` message interpolating `$error`, `$lineNumber`, `$filePath`, `$codeLines`.
  - `$output = $provider->chat($messages, $defaults['model_id'])`; returns
    `$output->getNormalized()->getText()` via `formatResponse()`.
- `formatResponse($responseText)`: `str_replace` of ```` ```php ```` →
  `<pre id='response-code-html'><code class='language-php'>` and ```` ``` ```` → `</code></pre>`
  (turns fenced code blocks into HTML). The parent JS renders the returned string as HTML in the
  modal (showdown).
- `logError($message)`: `\Drupal::logger('lnweb')->error($message)`.

## Notes

- No API key handling in this module — the key/credential is resolved and used entirely inside the
  `drupal/ai` provider plugin that `ai.provider` returns. TLS, auth and key storage are the ai
  module's responsibility, not this module's.
- The AI call depends on `drupal/ai` having a default chat provider + model configured; otherwise
  the controller throws.
