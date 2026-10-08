<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translator service, routes, controllers, hooks and batch

## Routes (`ai_content_translator.routing.yml`)

| Route | Path | Handler | Requirements |
|---|---|---|---|
| `ai_content_translator.settings` | `/admin/config/regional/ai-content-translator` | `SettingsForm` | `_permission: administer ai content translator` |
| `ai_content_translator.run` | `/admin/config/regional/ai-content-translator/run` | `RunForm` | `_permission: translate content with ai` |
| `ai_content_translator.node_translate` | `/node/{node}/ai-translate/{target}` | `TranslateActionController::translate` | `_permission: translate content with ai`, **`_csrf_token: 'TRUE'`**, `node: \d+` |

`node` is upcast to `entity:node`. The node-translate action is a GET but carries a CSRF token, so
the link built by the overview column (`Url::fromRoute(...)`) includes the token and off-site GETs
are rejected.

## Route subscriber

`Routing\RouteSubscriber::alterRoutes()` repoints `entity.node.content_translation_overview`'s
`_controller` to `TranslationOverviewController::overview` (priority -220, after
content_translation's -210). This is the only route alter; it does not change access requirements.

## `TranslationOverviewController` (extends core `ContentTranslationController`)

`overview()` calls the parent, then — only for users with `translate content with ai` and with the
`user.permissions` cache context added — appends an "AI translation" column. For each
target-language row without an existing translation it renders a `#type => link` "Translate (AI)"
button to `ai_content_translator.node_translate`. Rows for the source language, locked languages,
or languages that already have a translation get an empty cell (no regenerate-from-here path; that
requires the bulk form's overwrite toggle).

## `TranslateActionController::translate(NodeInterface $node, $target)`

Validates `$target` (must be an enabled, non-locked, non-source language); if the node already has
that translation it warns and redirects (no overwrite here). Otherwise it sets a Batch with one
`ai_content_translator_batch_node` operation (`$force = FALSE`) and returns
`batch_process()` back to the node's translation overview.

## `RunForm` (bulk)

`src/Form/RunForm.php` (`FormBase`) at `ai_content_translator.run`. Three independent sections,
each with its own submit handler:

- **Content** (`submitContent`) — pick a content type (or `*` = all); queries nodes with
  `getQuery()->accessCheck(TRUE)`, queues one `ai_content_translator_batch_node` per node.
- **Taxonomy** (`submitTaxonomy`) — pick a vocabulary; queries terms with `accessCheck(TRUE)`,
  queues `ai_content_translator_batch_term` per term.
- **Interface** (`submitInterface`) — queues `ai_content_translator_batch_interface` per language.

Each section has an **overwrite** checkbox → `$force`, and a language select (`''` = all target
languages, resolved by `resolveLangs()`). Being a POST `FormBase`, it carries Drupal's built-in
form CSRF token.

## Hooks (`Hook\AiContentTranslatorHooks`, attribute `#[Hook]`)

- `help` — the module help page.
- `form_node_form_alter` — for users with `translate content with ai`, adds a "Translate with AI"
  details box (group `advanced`) with a `checkboxes` of missing languages, and appends
  `nodeSubmit` to the node form's submit handlers. `nodeSubmit()` queues an
  `ai_content_translator_batch_node` for the selected languages (`$force = FALSE`) after the node
  saves.

## Batch callbacks (`ai_content_translator.module`)

`ai_content_translator_batch_node($nid, $langs, $force, &$ctx)`,
`_batch_term($tid, $langs, $force, &$ctx)`, `_batch_interface($lang, &$ctx)` load the entity and
call the service; `_batch_finished()` reports a plural status message. Non-force runs skip
languages that already have a translation.

## `AiContentTranslator` service (`src/AiContentTranslator.php`)

Service id `ai_content_translator.translator` (args: config.factory, state, language_manager,
entity_type.manager, keyvalue, locale.storage, http_client, its logger channel, theme_handler,
extension.list.theme).

### `translate(ContentEntityInterface $entity, $lang, $force = FALSE)`

1. Refuses source/locked/invalid target langs (logs a warning). If not `$force` and
   `!isTranslatable()`, returns (human-translation protection).
2. Gets or adds the `$lang` translation. **Pass 1:** iterates fields whose name is `name`/`title`/
   `body`/`field_*` (`isTranslatableFieldName()`): collects `string`/`text` values (and text
   `summary`) into `$raw_data`, copies field values into the translation, and for
   `entity_reference`/`entity_reference_revisions` to `paragraph` **recurses** into each referenced
   paragraph.
3. **Pass 2:** `requestTranslation($raw_data, $lang)`; writes returned values back. For text
   fields the value is stored as `['value' => translated, 'format' => $field->format ?: 'basic_html', ('summary' => ...)]`
   — so the translation renders through a text format (the source field's, else `basic_html`).
4. Copies `status` (or publishes taxonomy terms), `save()`s, then `markMachineTranslated()`.

### Human-translation protection

- `translationFingerprint()` = `hash('sha256', serialize($translatable_field_values))`.
- `markMachineTranslated()` stores `{fingerprint}` under key `type:id:lang` in key-value collection
  `ai_content_translator.machine_translations`.
- `isTranslatable()` → TRUE if no translation, or the stored fingerprint still
  `hash_equals()` the current translation's fingerprint. Legacy boolean records → treated as
  protected (FALSE). `$force` overrides everything.

### `translateInterface($lang)`

`getTwigStrings()` scans the default theme path and `modules/custom` recursively for
`{{ 'string'|t }}` (regex), registering unknown strings via `locale.storage->createString()`. It
skips strings that already have a non-empty translation (human or machine), sends the rest through
`requestTranslation()`, and `createTranslation()`s the results.

### `requestTranslation(array $raw_data, $lang)` — the API call

- Reads `api_endpoint`, `api_model`, and the token
  (`Settings::get(...) ?: state->get(...)`); logs an error and returns NULL if any is missing.
- Builds the prompt: `prompt_template` with `@language` substituted, optionally appends the
  per-language `glossary` (JSON), then appends `json_encode($raw_data)`.
- POSTs `{model, messages:[system, user], (reasoning_effort|verbosity|temperature when set)}` to
  the endpoint via `@http_client` with `Authorization: Bearer <token>`, `connect_timeout: 10`,
  `timeout: request_timeout`. **TLS verification uses Guzzle's default (enabled)** — no
  `verify => false`.
- Reads `choices[0].message.content`, strips ```` ```json ```` fences, `json_decode`s to an
  associative array, and returns it (NULL on request failure / invalid JSON, all logged to the
  `ai_content_translator` channel).

## Render/save sinks (how translated text is stored & shown)

- Content: text/body values are written **with a text format** (`$field->format ?: 'basic_html'`),
  so the model's output re-renders through that format's filters like any body field; `name`/
  `title`/`string` values render through core auto-escaping.
- Interface: translations are stored as locale strings and rendered by core's `t()` pipeline.
- No controller/form echoes the model output into raw markup.

## Operational notes

- One API call per entity (or per interface batch), not per field — cheaper and more context-aware
  than field-by-field translators.
- Long runs use the Batch API for a progress bar; `request_timeout` should be raised for large
  content or reasoning models (connect timeout is fixed at 10s).
- Bulk overwrite (`$force = TRUE`) is destructive: it regenerates human-authored translations too —
  the form labels it as such.
