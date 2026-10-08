<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Translate AI (canvas_translate_ai) — agent index

Optional submodule of **Canvas Translate** that adds AI machine translation via the contrib **AI**
module. It returns AI-suggested target values for the editor's strings; the SPA applies them to the
pending translation draft. It never loads or writes Canvas content and never publishes. Package
`Canvas`. Core `^11.2`. License GPL-2.0-or-later. Version 1.0.0-alpha4.

- **Dependencies:** `canvas:canvas_translate` (parent), `ai:ai`.
- **Permission:** reuses the parent's `translate canvas content` on both routes (+ CSRF token).
- **No** permissions, config schema, plugin types, or Drush of its own.

## Solution doc

- **The two endpoints, the AiTranslator service, provider selection, and guardrails** →
  [api/ai-translate.md](api/ai-translate.md)

## What it provides (from source)

- **Controller** `\Drupal\canvas_translate_ai\Controller\AiTranslateController` (`src/Controller/`):
  `translate()` (page) and `translateConfig()` (content_template / page_region). Both validate the
  target language, check `access('update')`, enforce request caps, and return `{values: {key: text}}`.
- **Service** `\Drupal\canvas_translate_ai\AiTranslator` (`src/AiTranslator.php`, autowired,
  `$aiProvider: '@ai.provider'`): `isAvailable()` and `translate($items, $src, $target)`. Prefers the
  AI module's `translate_text` operation; falls back to `chat` with a translation system prompt.
- **Exception** `AiTranslatorUnavailableException` — thrown when neither a translate_text nor a chat
  provider is configured (→ 422 with a "set up a provider" message).
- **Routes** (`canvas_translate_ai.routing.yml`): POST
  `/canvas-translate/api/items/canvas_page/{canvas_page}/{langcode}/ai-translate` and POST
  `/canvas-translate/api/config/{type}/{id}/{langcode}/ai-translate`.

## Provider handling

All LLM access goes through the AI module's `ai.provider` plugin manager and the site's configured
**default** provider for the operation type — there is no request-controllable provider or endpoint
URL, and this submodule does no HTTP/TLS or key handling of its own (the AI module owns that). Only
the strings to translate are sent. See [api/ai-translate.md](api/ai-translate.md).
