<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Node Translate adds an "Auto Translate" operation to translatable nodes that machine-translates a node's text, link and paragraph fields into other enabled languages using a pluggable translation-provider backend (MyMemory ships built in).

---

The module builds on core `content_translation`. A route subscriber registers `node/{node}/auto-translate-form` (`entity.node.auto_translation_add`) guarded by an `_access_auto_translation` check, and `hook_entity_operation` / a links preprocess add "Auto Translate" links to the node list and the translation-overview page. Access requires a core content-translation permission plus a per-bundle `auto translate {bundle} {entity_type}` permission (dynamically generated in `AutoNodeTranslatePermissions`); the settings pages are gated by `configure auto node translate`. The `TranslationForm` lets the editor pick target languages; the `Translator` service then walks the node's fields, translating string/text/`text_with_summary`/link titles (long text is chunked to respect field `max_length`), recursing into `entity_reference_revisions` paragraph fields, and creating or updating each translation. When `content_moderation` is present it can set the new translations to draft, published, or the source's state. Translation providers are annotation plugins (`@AutoNodeTranslateProvider`) resolved through `plugin.manager.auto_node_translate_provider`; the selected `default_api` (config `auto_node_translate.settings:default_api`) is instantiated per run. The bundled `MyMemoryTranslationApi` calls the fixed public endpoint `https://api.mymemory.translated.net/get` over `http_client`, splitting text into 400-byte chunks and optionally appending a configured `mm_email` (`auto_node_translate.my_memory_settings:mm_email`) to raise the free quota; the endpoint host is not configurable. `hook_auto_node_translate_translation_alter` lets other modules tweak each string before it is sent.

---

- Machine-translate a node's title and body into every enabled language in one click.
- Add an "Auto Translate" operation to the content admin list for editors.
- Translate paragraph (entity_reference_revisions) subfields recursively along with the node.
- Translate link-field titles as well as text fields.
- Choose which target languages to generate on the translation form.
- Select MyMemory as the translation provider out of the box.
- Register the free-quota-raising email for MyMemory to lift the word limit.
- Swap in a different translation backend by installing a contrib provider plugin.
- Write your own provider plugin implementing the `translate()` method for DeepL/Google/etc.
- Set new translations to Draft when content moderation is enabled, for editorial review.
- Set new translations to Published automatically where that workflow is acceptable.
- Keep translations at the source node's moderation state.
- Gate who can auto-translate each content type with per-bundle permissions.
- Restrict configuration of the module to trusted admins via a dedicated permission.
- Alter or annotate text before it is sent to the API with `hook_auto_node_translate_translation_alter` (e.g. append a suffix, skip glossary terms).
- Bulk-seed initial translations for a large multilingual site to be post-edited by humans.
- Regenerate ("Update automatic translation") an existing translation after the source changes.
- Preserve non-translated field values by copying them across to the translation.
- Truncate over-length machine output to fit `string`/`text` field max lengths automatically.
- Record an automatic-translation revision log message on each translated node.
- Attribute the translation revision to the current user with a fresh revision timestamp.
- Provide a consistent starting point for professional translators to refine.
- Translate content that mixes plain text, formatted text and summaries in one pass.
