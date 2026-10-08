AI Translate adds one-click, AI-powered translation of content entities (and interface strings) by sending field text to an LLM through the `ai` module's provider abstraction and writing the result back as a Drupal translation.

---

The module overrides the core "Translate" tab on translatable content entities (via a route subscriber that swaps the `ContentTranslationController` for its own `ContentTranslationControllerOverride`) so each missing translation gets an "AI translate" link. Clicking it hits `ai_translate.translate_content` (`/ai_translate/translate/{entity_type}/{entity_id}/{lang_from}/{lang_to}`), which extracts translatable field text with pluggable **FieldTextExtractor** plugins, runs a Batch that calls the `ai_translate.text_translator` service once per field (using the AI module's default `translate_text` provider/model, or a per-language model override), then adds and saves the target-language translation. Translation prompts are stored as `ai.ai_prompt` config entities of prompt-type `ai_translate` (variables `sourceLang`, `sourceLangName`, `destLang`, `destLangName`, `inputText`); the settings form lets you pick a default prompt and per-language prompt/model overrides, choose published-vs-draft status for new translations, and opt into recursively translating referenced entities up to a configurable depth. It also provides AJAX-driven AI translation of interface (locale) strings on the translate-interface form, two Drush commands (`ai:translate-entity`, `ai:translate-text`), and a `text_extractor` plugin type so custom field types can define how their text is pulled out and put back. It requires the `ai` module (with a configured chat/translate provider such as OpenAI) and core `content_translation`; the actual LLM endpoint, model, and API key live in the AI provider config, not here.

---

- Add a French (or any language) translation of a node with one click from its Translate tab.
- Bulk-translate many entities from the command line with `drush ai:translate-entity node 16,18,20 en fr`.
- Translate an arbitrary string on the CLI with `drush ai:translate-text`.
- Machine-translate content into every enabled site language using an LLM instead of a human translator.
- Use a different AI model per target language (e.g. a stronger model for Japanese, a cheaper one for Spanish).
- Use a custom translation prompt per language to control tone/formality.
- Create new translations in draft/unpublished status so an editor can review before publishing.
- Keep the original entity's published status on the generated translation instead.
- Redirect straight into the edit form of the freshly created translation for quick correction.
- Automatically translate referenced entities (paragraphs, referenced nodes) along with the host entity.
- Limit how deep entity-reference translation recurses (1, 2, 5, 10, or unlimited).
- AI-translate interface (locale) strings from the Translate interface admin screen via an inline button.
- Provide AI translation as a framework/back-end for other translation tooling (e.g. AI TMGMT) by turning off the "Translate" tab takeover.
- Restrict who can generate content translations vs. interface translations vs. manage prompts with three separate permissions.
- Extend translation to a custom field type by writing a `FieldTextExtractor` plugin.
- Translate long text, text-with-summary, link, image (alt/title), and text fields out of the box.
- Tune the default translation prompt centrally and reuse it across all languages.
- Swap the underlying LLM provider (OpenAI, Anthropic, etc.) globally by changing the AI module's default `translate_text` provider — no change here.
- Translate title and other base fields that are marked translatable.
- Enforce a minimum prompt length so an empty/too-short prompt is rejected at config time.
- Generate translations programmatically by calling the `ai_translate.text_translator` service from custom code.
