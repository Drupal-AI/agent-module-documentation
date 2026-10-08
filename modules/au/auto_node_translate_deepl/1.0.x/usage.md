<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Node Translate Deepl is a provider plugin for the [Auto Node Translate](https://www.drupal.org/project/auto_node_translate) module that machine-translates node content field values through the DeepL API using the official `deeplcom/deepl-php` library.

---

The module registers a single `AutoNodeTranslateProvider` plugin (`id: auto_node_translate_deepl`) whose `translate($text, $from, $to)` method instantiates `DeepL\Translator` with the configured API key and calls `translateText()` with HTML tag handling and format preservation on, so rich-text field markup survives translation. It adds a settings form at `/admin/config/regional/deepl` (route `auto_node_translate_deepl.settings`, permission `administer site configuration`) storing the DeepL `apikey` and an optional `glossary_id` in `auto_node_translate_deepl.settings`, plus a language-mapping form at `/admin/config/regional/deepl/mapping` that maps each Drupal langcode to a DeepL source/target language code (stored per-key as `source_<id>`/`target_<id>` in `auto_node_translate_deepl.language_mapping`). The language-mapping form pulls the live list of DeepL-supported source and target languages from the API to populate its selects. When a Drupal langcode has no explicit mapping the raw langcode is passed to DeepL as-is; an optional glossary id is forwarded when set. All translation activity is driven by the parent Auto Node Translate module (its buttons/permissions/workflow decide when nodes are translated); this module only supplies the DeepL backend. There is no config schema shipped and no permissions of its own beyond the core `administer site configuration` gating its two config forms.

---

- Machine-translate node fields into other languages with DeepL from within Auto Node Translate.
- Configure a DeepL API key (free or pro) as the translation backend for a multilingual site.
- Preserve HTML markup in rich-text fields during translation (tag handling = html).
- Apply a DeepL glossary to enforce consistent terminology across translations.
- Map a Drupal language (e.g. `pt`) to a specific DeepL variant (e.g. `PT-PT` vs `PT-BR`).
- Map source languages separately from target languages for DeepL's asymmetric codes.
- Translate a node's title and body in one action via the parent module's translate button.
- Auto-populate a newly created translation with DeepL output as a starting draft.
- Bulk-translate content into several languages using DeepL as the provider.
- Swap the translation backend to DeepL without changing the Auto Node Translate workflow.
- Restrict translation configuration to site administrators (`administer site configuration`).
- Fall back to the raw langcode when a language has no explicit DeepL mapping.
- Populate the language-mapping selects from DeepL's live supported-language list.
- Leave the glossary empty to translate without a glossary.
- Use DeepL's high-quality neural translation for European-language content.
- Provide editors machine-translated drafts they can post-edit before publishing.
