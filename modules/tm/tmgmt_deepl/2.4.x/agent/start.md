<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL Translator (tmgmt_deepl) — agent index

Adds DeepL as a **TMGMT Translator** using the `deeplcom/deepl-php` SDK. One translator plugin
(`deepl_api`) plus a shared settings form; you create a `tmgmt_translator` provider, select a **Key
entity** holding the DeepL API key, and translate TMGMT text + document jobs. Requires `tmgmt` and
`key`. Core `^11.4`, PHP `8.4`.

- **Create a DeepL provider, its settings, the Key entity + `deepl_api_key` KeyType** →
  [configure/translator.md](configure/translator.md)
- **The `deepl_api` translator plugin, client factory, batch + queue worker, usage/quota** →
  [plugins/translators.md](plugins/translators.md)
- **Alter hooks (config/checkout/options)** → [hooks/hooks.md](hooks/hooks.md)

Submodule: `tmgmt_deepl_glossary` → `modules/tmgmt_deepl_glossary/2.4.x/`.

Key facts:
- Translator plugin id: `deepl_api` (`Plugin/tmgmt/Translator/DeeplApiTranslator`, `files = TRUE`),
  extends abstract `DeeplTranslator`; ui `DeeplTranslatorUi`, logo `icons/deepl.svg`.
  `DeeplTranslator::DEEPL_TRANSLATORS = ['deepl_api']`. Legacy `deepl_free`/`deepl_pro` removed
  (update hooks migrate them to `deepl_api`).
- Config entity `tmgmt.translator.<name>`, settings schema `tmgmt_deepl_settings` (keys:
  `auth_key_entity`, `model_type`, `formality`, `split_sentences`, `preserve_formatting`,
  `tag_handling`, `tag_handling_version`, `outline_detection`, `splitting_tags`,
  `non_splitting_tags`, `ignore_tags`, `enable_context`, `translate_documents`,
  `enable_document_minification`, `omit_partner_id`, `log_api_requests`, `max_queries`,
  `auto_accept`). No `auth_key` in config — the key lives in a Key entity.
- KeyType plugin `deepl_api_key` (`Plugin/KeyType/DeepLApiKeyType`) validates the key vs DeepL.
- Services: `tmgmt_deepl.api` (`DeeplTranslatorApi`), `tmgmt_deepl.client_factory`
  (`DeepLClientFactory`), `tmgmt_deepl.language_support`, `tmgmt_deepl.translate_options`,
  `tmgmt_deepl.batch`, `tmgmt_deepl.failure_classifier`, `tmgmt_deepl.document_handle_store`,
  `tmgmt_deepl.client_logger` (`DebugSuppressingLogger`).
- Configure route `entity.tmgmt_translator.collection` = `/admin/tmgmt/translators`.
- Cron queue worker `deepl_translate_worker` (batch API for UI submits). `hook_cron` GC's stale
  document handles and rejects orphaned-batch jobs. `hook_file_download` access-checks translated
  document files. No permissions of its own, no Drush commands.
