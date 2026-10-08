# AI Translate — agent integration (function call & Tool API)

New in 1.4.x: entity translation is exposed to AI agents two ways. Both create+save a translation and
both enforce the same access gate as the web route
(`EntityTranslationOrchestrator::checkTranslateAccess()` — permission `create ai content translation`
plus the caller's `update` access on the entity plus translation-handler `create` access).

## AI function call: `ai_translate:translate_entity`

`src/Plugin/AiFunctionCall/TranslateEntity.php` — a `FunctionCall` plugin
(`function_name: ai_translate_translate_entity`, group `ai_translate`) implementing
`StructuredExecutableFunctionCallInterface`.

Context (arguments):

| Name | Required | Description |
|---|---|---|
| `entity_type` | yes | Content entity type, e.g. `node`. |
| `entity_id` | yes | Entity ID to translate. |
| `target_language` | yes | Target language code. |
| `source_language` | no | Source language code; defaults to the entity language. |

`execute()` validates the entity type exists, loads a content entity, checks it is translatable, runs
the access gate (returns `access_denied` if not allowed), then calls
`EntityTranslationOrchestrator::translateEntity()`. Output is both a readable summary and a structured
array: `status` (`success` / `skipped` / `failed` / `access_denied`), `message`, `entity_type`,
`entity_id`, `source_language`, `target_language`, `translated_entity_label`, `failures`.

## Tool API: `ai_translate_tool` submodule

`modules/ai_translate_tool/` — optional submodule, depends on `ai_translate` and the contrib
`tool` module (`drupal/tool`, suggested; require-dev). Provides
`TranslateEntityTool` (`#[Tool(id: 'ai_translate_tool:translate_entity', operation: ToolOperation::Write)]`).

- Inputs: `entity_type_id` (constrained `PluginExists` → a `ContentEntityInterface` type), `entity_id`,
  `target_language` and optional `source_language` (both constrained by a `Choice` callback listing the
  site's language codes).
- `checkAccess()` routes through `checkTranslateAccess()` (same gate); `doExecute()` calls
  `translateEntity()` and returns an `ExecutableResult` with `status`, `message`, entity + language ids,
  `translated_entity_label`, and `failures`.
- Operation is declared `Write`, matching an action that creates and saves a translation.

Enable with `drush en ai_translate_tool` once `drupal/tool` is installed.
