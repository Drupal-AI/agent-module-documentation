# AI Translate — agent index

One-click AI translation of content entities and interface strings. Overrides the core Translate tab,
extracts field text via plugins, and translates each field through the `ai` module's `translate_text`
provider in a Batch. Depends on `ai:ai` and core `content_translation`. `configure` route =
`ai_translate.settings_form` (`/admin/config/ai/ai-translate`). The LLM endpoint/model/API key live in
the AI provider config, not here.

- **Settings form keys, config schema, prompt config entities, per-language model/prompt overrides** →
  [configure/settings.md](configure/settings.md)
- **The 3 permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)
- **Services (`text_translator`, `text_extractor`), routes, and the interface-translate callback** →
  [api/services.md](api/services.md)
- **The `text_extractor` (FieldTextExtractor) plugin type — implement one for a custom field** →
  [plugins/field_text_extractor.md](plugins/field_text_extractor.md)
- **Drush commands `ai:translate-entity`, `ai:translate-text`** → [drush/commands.md](drush/commands.md)

Key facts:
- Route `ai_translate.translate_content` creates + saves a translation for an entity by ID, gated by
  the `create ai content translation` permission.
- Prompts are `ai.ai_prompt` entities of prompt-type `ai_translate`; default shipped as
  `ai_translate__ai_translate_default`. Variables: `sourceLang(Name)`, `destLang(Name)`, `inputText`.
- Field extractors shipped: text, text_with_summary, string/title, link, image, file, reference, layout builder.
