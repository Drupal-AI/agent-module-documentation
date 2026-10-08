<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Translate AI — endpoints & translator

## Routes (`canvas_translate_ai.routing.yml`)

Both POST, both require `_permission: 'translate canvas content'` (the parent's permission) **and**
`_csrf_request_header_token: 'TRUE'`, both `no_cache: TRUE`. They translate strings the editor
supplies and return suggestions; they never mutate stored content.

| Route | Path | Controller method |
|---|---|---|
| `canvas_translate_ai.translate` | `/canvas-translate/api/items/canvas_page/{canvas_page}/{langcode}/ai-translate` | `AiTranslateController::translate()` |
| `canvas_translate_ai.translate_config` | `/canvas-translate/api/config/{type}/{id}/{langcode}/ai-translate` (`{type} ∈ content_template\|page_region`) | `AiTranslateController::translateConfig()` |

**Request body:** `{ "items": [ { "key": "...", "format": "full_html"|null, "source": "..." }, ... ] }`
**Response:** `{ "values": { "<key>": "<translated text>", ... } }` (skipped/empty items absent).

### Access & guardrails (`AiTranslateController`)

- `translate()`: rejects unknown/source langcode (`validateTarget()`), then `$canvas_page->access('update')`
  → 403 otherwise. `translateConfig()`: validates `{type}`, loads the config entity,
  `$entity->access('update')` → 403 otherwise.
- Caps (constants): `MAX_ITEMS = 200` → 413 if exceeded; `MAX_SOURCE_LENGTH = 20000` chars per
  item → 413. Each item is one synchronous provider call, so these bound token cost / connection hold.
- Error handling: `AiTranslatorUnavailableException` → 422 with a setup message; any other provider
  exception is logged (message only, to `logger.factory`→`canvas_translate_ai`) and returned as a
  502 "AI translation failed. Please try again in a moment." — never a raw 500/stack trace.

## AiTranslator service (`src/AiTranslator.php`)

- Injected with `@ai.provider` (`AiProviderPluginManager`) and `language_manager`.
- `isAvailable()` — TRUE when a default provider exists for `translate_text` OR `chat`.
- `translate(array $items, string $src, string $target): array` —
  - Prefers `translate_text`: `$provider->translateText(new TranslateTextInput($source, $src, $target), $model_id)->getNormalized()`.
  - Falls back to `chat`: `$provider->chat(new ChatInput([system prompt, user=source]), $model_id)`.
    The system prompt (`chatSystemPrompt()`) instructs a professional translation from source→target
    language name, preserving HTML/entities/whitespace, output only.
  - Iterates items sequentially; skips empty source/key. Rich-text rows (non-null `format`) are sent
    verbatim so the provider can keep markup.
  - `getProvider()` resolves the site's **default** provider for the operation type via
    `getDefaultProviderForOperationType()`; a stale/missing default (uninstalled plugin) is treated
    as "no provider" (caught), not fatal.

## Notes for agents

- There is **no request-controllable provider id or endpoint URL** — the provider comes from the AI
  module's configured default for the operation. No SSRF surface here.
- This submodule performs **no** direct HTTP, TLS, or API-key handling; all of that is the AI
  module's provider plugin's responsibility. Only the source strings to translate are sent to the
  provider.
- The parent (`ApiTranslateController::aiAvailable()`) flips the editor's AI controls on purely by
  `moduleHandler()->moduleExists('canvas_translate_ai')` — so the parent keeps no dependency on the
  `ai` module.
