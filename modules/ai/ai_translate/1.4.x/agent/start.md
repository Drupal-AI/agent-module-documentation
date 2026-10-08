# AI Translate — agent index

One-click AI translation of content entities and interface strings. Overrides the core Translate tab,
extracts field text via plugins, and translates each field through the `ai` module's `translate_text`
provider in a Batch. Depends on `ai:ai` and core `content_translation`. `configure` route =
`ai_translate.settings_form` (`/admin/config/ai/ai-translate`). The LLM endpoint/model/API key live in
the AI provider config, not here.

- **Settings form keys, config schema, prompt config entities, per-language model/prompt overrides,
  translation caching** → [configure/settings.md](configure/settings.md)
- **The 3 permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)
- **Services (`text_translator`, `text_extractor`, `translation_orchestrator`), routes, access, and the
  interface-translate callback** → [api/services.md](api/services.md)
- **The `text_extractor` (FieldTextExtractor) plugin type — implement one for a custom field** →
  [plugins/field_text_extractor.md](plugins/field_text_extractor.md)
- **AI agent integration: the `ai_translate:translate_entity` function call and the `ai_translate_tool`
  Tool API submodule** → [tools/agent_integration.md](tools/agent_integration.md)
- **Drush commands `ai:translate-entity`, `ai:translate-text`** → [drush/commands.md](drush/commands.md)

Key facts:
- Route `ai_translate.translate_content` creates + saves a translation for a content entity by ID. It
  requires a CSRF token (`_csrf_token: 'TRUE'`) and a `_custom_access` check
  (`AiTranslateController::checkAccess`) that verifies the `create ai content translation` permission,
  that the entity is translatable, the caller's `update` access on that entity, and the translation
  handler's `create` access.
- All three programmatic entry points (the content route controller, the `translate_entity` AI function
  call, and the `ai_translate_tool` Tool plugin) share one access gate:
  `EntityTranslationOrchestrator::checkTranslateAccess()`.
- Prompts are `ai.ai_prompt` entities of prompt-type `ai_translate`; default shipped as
  `ai_translate__ai_translate_default`. Variables: `sourceLang(Name)`, `destLang(Name)`, `inputText`.
- Field extractors shipped: text, text_with_summary, string/title, link, image, file, reference, layout builder.
- Optional translation caching (`cache_translations`) stores results in the `cache.ai_translate` bin,
  keyed by provider+model+language pair+text hash.
