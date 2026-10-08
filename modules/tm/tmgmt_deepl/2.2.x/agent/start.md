<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL Translator (tmgmt_deepl) — agent index

Adds DeepL as a **TMGMT Translator**. Two translator plugins (`deepl_free`, `deepl_pro`) share a
settings form; you create a `tmgmt_translator` provider, enter a DeepL auth key, and translate
TMGMT jobs. Translation calls DeepL's API (needs a key); the provider + settings are Drupal config.

- **Create a DeepL translator provider, its settings keys, auth key storage** →
  [configure/translator.md](configure/translator.md)
- **The DeepL translator plugins + the cron queue worker** →
  [plugins/translators.md](plugins/translators.md)
- **Alter hooks + the DeeplReceivedDataEvent** → [hooks/hooks.md](hooks/hooks.md)

Submodule: `tmgmt_deepl_glossary` → `modules/tmgmt_deepl_glossary/2.2.x/`.

Key facts:
- Translator plugin ids: `deepl_free`, `deepl_pro` (TMGMT `@TranslatorPlugin`, ui
  `DeeplTranslatorUi`). Config entity: `tmgmt.translator.<name>`.
- Configure route `entity.tmgmt_translator.collection` = `/admin/tmgmt/translators`.
- Settings schema `tmgmt_deepl_settings` (keys: `auth_key`, `url`, `url_usage`, `formality`,
  `split_sentences`, `tag_handling`, `preserve_formatting`, `outline_detection`, `ignore_tags`,
  `(non_)splitting_tags`, `auto_accept`, `test_url`, `test_url_usage`).
- Cron queue worker `deepl_translate_worker`. Depends on `tmgmt`. No permissions, no Drush.
