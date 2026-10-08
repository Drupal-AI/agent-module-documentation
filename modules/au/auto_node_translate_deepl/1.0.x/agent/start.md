<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Node Translate Deepl — agent index

DeepL backend for the Auto Node Translate module. Registers one `AutoNodeTranslateProvider` plugin
(`id: auto_node_translate_deepl`) that translates text via the `deeplcom/deepl-php` library. Depends
on `auto_node_translate`. No permissions of its own, no Drush, no config schema.

- **API key + glossary settings, per-language DeepL code mapping, the provider plugin, config keys**
  → [configure/settings.md](configure/settings.md)

Key facts:
- Configure route: `auto_node_translate_deepl.settings` = `/admin/config/regional/deepl`
  (permission `administer site configuration`). Mapping form: `/admin/config/regional/deepl/mapping`.
- Config: `auto_node_translate_deepl.settings` (`apikey`, `glossary_id`);
  `auto_node_translate_deepl.language_mapping` (`source_<langcode>`, `target_<langcode>`).
- The plugin's `translate($text,$from,$to)` uses `DeepL\Translator::translateText()` with
  `TAG_HANDLING=html` and `PRESERVE_FORMATTING=1`; when/what to translate is controlled by the parent
  Auto Node Translate module.
