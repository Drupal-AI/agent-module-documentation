<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Translator (ai_content_translator) — agent index

Machine translation of **content entities (incl. referenced Paragraphs), taxonomy terms and
interface strings** via any **OpenAI-compatible** chat API, **preserving human translations**.
Package `Multilingual`. Version **1.0.1**. Core `^11.1 || ^12`. PHP `>=8.3`. License
GPL-2.0-or-later. Depends on core **`language`**, **`content_translation`**, **`locale`**. No
composer requirements beyond core, no submodules, no Drush.

- **Settings form, config object, keys, schema, State token, permissions** → [config/settings.md](config/settings.md)
- **The translator service, routes, controllers, hooks, batch, fingerprinting** → [api/translator.md](api/translator.md)

## What it actually is

- One service: `AiContentTranslator` (`src/AiContentTranslator.php`, id
  `ai_content_translator.translator`) — `translate(ContentEntityInterface, $lang, $force)`,
  `translateInterface($lang)`, `requestTranslation(array $raw_data, $lang)`,
  `getTargetLanguages()`, `isTranslatable()`. It collects translatable text, calls the API once
  per entity/interface batch (a JSON payload, **not** per field), writes results back preserving
  text format, and fingerprints what it created.
- Two forms: `SettingsForm` (route `ai_content_translator.settings`,
  `/admin/config/regional/ai-content-translator`) and `RunForm` (route
  `ai_content_translator.run`, `/admin/config/regional/ai-content-translator/run`, bulk).
- Two controllers: `TranslateActionController::translate(NodeInterface $node, $target)` (route
  `ai_content_translator.node_translate`, `/node/{node}/ai-translate/{target}`) and
  `TranslationOverviewController` (extends core `ContentTranslationController` to add an "AI
  translation" column, wired in by `Routing\RouteSubscriber`).
- Hooks in `Hook\AiContentTranslatorHooks` (attribute `#[Hook]`): `help`, and
  `form_node_form_alter` adding the per-node "Translate with AI" box. Batch callbacks live in
  `ai_content_translator.module`.
- Two permissions: **`administer ai content translator`** (`restrict access: true`, settings) and
  **`translate content with ai`** (run/node-translate).

## Mechanism (from source)

- **Target languages** = every enabled language except the site default and locked
  (und/zxx) — no per-site config (`getTargetLanguages()`).
- **Human-translation protection:** `markMachineTranslated()` stores a SHA-256 `translationFingerprint()`
  of the generated translation in key-value collection `ai_content_translator.machine_translations`;
  `isTranslatable()` allows (re)generation only when there is no translation yet, or the stored
  fingerprint still `hash_equals()` the current one. Boolean legacy records are treated as
  protected. `$force = TRUE` (the bulk-form overwrite toggle) bypasses this.
- **API call:** `requestTranslation()` builds `prompt_template` (`@language` substituted) + optional
  glossary + a JSON dump of `{field => text}`, POSTs to the configured `api_endpoint` with
  `Authorization: Bearer <token>`, strips Markdown code fences, and `json_decode`s the model's
  reply back into `{field => translated}`. Optional `reasoning_effort`/`verbosity`/`temperature`
  are sent only when set.
- **Token storage:** `Settings::get('ai_content_translator.api_token')` (settings.php) takes
  precedence over `state->get('ai_content_translator.api_token')`; the token is never in config.
- **Run paths** all funnel through Batch API operations (`ai_content_translator_batch_node` /
  `_batch_term` / `_batch_interface`) → the service.

## Config keys (config object `ai_content_translator.settings`)

`api_endpoint` (default `https://api.openai.com/v1/chat/completions`), `api_model`,
`request_timeout` (120), `reasoning_effort`, `verbosity`, `temperature`, `prompt_template`,
`glossary`. The **API token is NOT here** — it lives in State / settings.php. Details in
[config/settings.md](config/settings.md).

## Notes

- Source text is sent to the endpoint you configure (data egress + per-request cost); run a local
  OpenAI-compatible model to keep content on-premise.
- Interface translation scans Twig under the default theme's path and `modules/custom` for
  `{{ 'string'|t }}` and registers/translates them via `locale.storage`.
- The README documents a theming caveat: a Twig template reading a referenced child entity
  directly (`item.entity.field.value`) shows the child's default language; prefer the
  language-aware render array or resolve the translation in `hook_preprocess_paragraph()`.
