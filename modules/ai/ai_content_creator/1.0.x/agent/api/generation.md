<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Creator — node-form panel & OpenAI service

## The node-form panel (`ai_content_creator.module`)

`ai_content_creator_form_alter(&$form, $form_state, $form_id)`:

1. Gets the form object; proceeds only if it is a `Drupal\node\Form\NodeForm`.
2. Loads the entity, reads `ai_content_creator.adminsettings:api_node_type`, and continues only if the node's
   bundle is in that list.
3. Calls `$form_state->setRebuild(TRUE)` and adds a `details` element `ai_content_creator` (group `advanced`,
   open, weight 1000) containing:
   - `keywords` — a `textarea` (title "Content prompt", `#maxlength => 2000`, not required);
   - `generate_content` — a `#type => button` with an `#ajax` callback
     `ai_content_creator_generate_content_callback`, attaching libraries `core/drupal.dialog.ajax` and
     `ai_content_creator/clipboardjs`.

Because the button is part of the node form, reaching the callback requires access to that node's add/edit form
(the form build and its token gate it) — there is no standalone route.

## The AJAX callback

`ai_content_creator_generate_content_callback(array $form, FormStateInterface $form_state)`:

- Reads `$form_state->getUserInput()['keywords']`, collapses whitespace with
  `trim(preg_replace('/\s\s+/', ' ', ...))`.
- If empty → returns an `AjaxResponse` with an `AlertCommand` asking for a prompt.
- Calls `\Drupal::service('ai_content_creator.openai_service')->generateContent($prompt)`.
- On `success === FALSE` → `AlertCommand($result['error'])`.
- On success → builds `$content_html` as
  `'<div ...>' . nl2br(htmlspecialchars($result['content'], ENT_QUOTES, 'UTF-8')) . '</div>'` and returns an
  `OpenModalDialogCommand('AI generated content', $content_html, $dialog_options)`. The generated text is therefore
  **HTML-escaped** before it is placed in the dialog markup. The dialog's "Copy to clipboard" button carries the
  raw text in a `data-clipboard-text` attribute wired to clipboard.js.

The result is shown only to the editor who clicked the button; it is **not saved to the node** — the author copies
it into fields manually.

## The OpenAI service (`Service\OpenAiService`)

Constructor args (from `ai_content_creator.services.yml`): `@http_client` (Guzzle `ClientInterface`),
`@config.factory`, `@logger.factory`.

`generateContent(string $prompt): array` returns `['success' => bool, 'content'|'error' => ...]`:

- Reads `api_key`/`api_model`/`api_max_token`/`api_temperature`/`api_url` from `ai_content_creator.adminsettings`;
  returns an error array if `api_key` is empty.
- **Chat vs completion:** `$is_chat_model = strpos($model,'gpt-3.5') !== FALSE || strpos($model,'gpt-4') !== FALSE`.
  For chat models it rewrites the URL to `.../chat/completions` and sends a `messages` payload
  (`role: user`); otherwise it sends a `prompt` payload. Both include `temperature` and `max_tokens`.
- Issues `POST $url` via `$this->httpClient->request()` with headers
  `Content-Type: application/json` and `Authorization: Bearer <api_key>`, `json => $payload`, `timeout => 30`.
  Uses the Guzzle client's default TLS verification (no `verify => false`).
- Decodes the JSON; on an `error` key or missing `choices` returns an error array (and logs the API error).
  Extracts `choices[0].message.content` (chat) or `choices[0].text` (completion), trims it, and returns it as
  `content`.
- Catches `RequestException` and maps status codes 401/429/500/502/503 to friendly messages; logs the detailed
  error (message + status) to the `ai_content_creator` channel.

`validateConfiguration(): array` — returns `['valid' => bool, 'errors' => []]` checking that `api_key`, `api_url`
and a positive numeric `api_max_token` are set. (Defined but not called from the form/callback in this release.)

## Operational notes

- Each click on "Generate content" is one billed OpenAI request; there is no caching or throttling, so generation
  volume tracks how often editors use the panel.
- The prompt is sent verbatim to the configured endpoint (external egress). Confirm this is acceptable for your
  data-handling policy and point `api_url` only at an endpoint you trust.
- AI output can be inaccurate or hallucinated and should be reviewed/edited before publishing; the module never
  auto-publishes or auto-fills fields.
