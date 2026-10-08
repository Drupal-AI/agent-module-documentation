<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Editor Actions — routes, endpoints & request flow

All in `ai_editor_actions.routing.yml`; controller `Controller\TransformController`.

## Endpoints

| Route | Path | Method | Permission (comma = OR) | Extra |
|---|---|---|---|---|
| `ai_editor_actions.transform` | `/ai-editor-actions/transform` | POST | `use ai editor actions,use ai plain text actions` | `_csrf_request_header_token: TRUE` |
| `ai_editor_actions.explain` | `/ai-editor-actions/explain` | POST | `use ai editor actions,use ai plain text actions,use ai explain selection` | `_csrf_request_header_token: TRUE` |
| `ai_editor_actions.transcribe` | `/ai-editor-actions/transcribe` | POST | `use ai editor actions,use ai plain text actions` | `_csrf_request_header_token: TRUE` |
| `ai_editor_actions.catalog` | `/ai-editor-actions/catalog` | GET | `use ai editor actions,use ai plain text actions` | — |
| `ai_editor_actions.settings` | `/admin/config/ai/editor-actions/settings` | GET/POST | `administer ai editor actions` | `SettingsForm` |
| `ai_editor_actions.dialog_add` | `/ai-editor-actions/dialog/add-action` | GET/POST | `_entity_create_access: ai_editor_action` | `Form\ActionCreateForm` (modal) |

The three AI-invoking POST routes require a `X-CSRF-Token` (from `/session/token`) via
`_csrf_request_header_token`; the front-end sends it. Each of these is a billed AI call, so it is
permission-gated, CSRF-guarded and rate-limited (below).

## `transform(Request)` → `{html}` / `{text}` / `{error}`

Body is JSON: `action` (id or the reserved `custom`), `text`, `instruction`, `plain` (bool).
Validation order:
1. Body must be an array; `action`/`text`/`instruction` must be strings if present (else 400).
2. `instruction` is run through `stripControlChars()` (removes C0/C7 control bytes).
3. Empty `text` is rejected unless the action is `EditorActionInterface::CUSTOM_ACTION_ID`
   (`custom`). Hard ceiling `MAX_TEXT_CHARS` = 100000 (400 if exceeded); then the configured
   `max_input_chars` soft cap truncates.
4. Custom action: needs a non-empty instruction ≤ `MAX_INSTRUCTION_CHARS` (1024); prefixed with
   "Apply this instruction to the text: ".
5. Named action: loaded via entity storage; if not an `EditorActionInterface`, disabled, or
   `access('view')` fails → **`NotFoundHttpException` (404, not 403)** so private ids stay unprobed.
   A supplied instruction is a temporary override ≤ `MAX_OVERRIDE_CHARS` (2000); else the stored
   instruction is used. The action's own `provider` is passed through.
6. Flood: when `transforms_per_hour` > 0, `flood->isAllowed(FLOOD_EVENT, limit, 3600, uid)` gates
   and registers; 429 on limit.
7. `TextTransformer::transform(instruction, text, provider, plain)` runs the chat call.
8. Response: plain fields get `{text: raw}`; the editor gets `{html: toHtml(result)}`.
   `toHtml()` returns the model's HTML if it already looks like markup, else escapes with
   `Html::escape()` and runs `filter_autop`.

## `explain(Request)` → `{html}` / `{error}`

Body: `text`. Same length caps. Result HTML is **cached** by `sha256(text)`
(`cache.default`, cid `ai_editor_actions:explain:…`, TTL `EXPLAIN_CACHE_TTL` = 3600s, tagged on the
settings config so a prompt edit invalidates it); a cache hit is served before the flood check.
Counts against the same per-user flood budget. `TextTransformer::explain()` produces the text;
`toSafeHtml()` runs `Xss::filter()` with a **formatting-only tag allowlist** (`p em strong b i u a
code pre blockquote ul ol li h2–h6 span table …`), extendable via
`hook_ai_editor_actions_explanation_allowed_tags_alter()`.

## `transcribe(Request)` → `{text}` / `{error}`

Multipart upload field `audio`. Guards: must be a valid `UploadedFile`, size > 0 and ≤
`MAX_AUDIO_BYTES` (20 MiB), client MIME must start `audio/` or `video/` (some browsers label an
audio clip `video/webm`). Same per-user flood budget. Reads the temp file bytes and calls
`TextTransformer::transcribe(bytes, mime, filename)`, which uses the `speech_to_text` provider
(`audio_provider` setting or site default) via `AiProviderPluginManager::getSetProvider()`; returns
`{text}`.

## `catalog()` → JSON

`ActionCatalog::build()` returns the current user's actions grouped by category, uncategorized
flat, plus `canCreate`, `selectionMenu`, `audioInput` (whether a usable `speech_to_text` provider
exists) and inline SVG `icons`. Only actions that are enabled and pass `access('view')` are
included. Injected into the CKEditor plugin config by
`Plugin\CKEditor5Plugin\AiEditorActions::getDynamicPluginConfig()`.

## Notes for integrators

- `TextTransformer` is the seam: bind `TextTransformerInterface` to a custom service to change how
  text is sent to the model. It uses `ai\OperationType\Chat\ChatInput` (with an optional
  `StructuredOutputSchema` when `structured_output` is on) and `SpeechToTextInput`.
- No route here fetches a request-supplied URL; the only external egress is the model call through
  `drupal/ai` (TLS + API key handled by the provider/Key layer, not this module).
