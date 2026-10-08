<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DeepL Translator (tmgmt_deepl) plugs the DeepL machine-translation API into the Translation Management Tool (TMGMT) so Drupal content and document jobs can be translated automatically by DeepL, using the official deepl-php SDK and a Key-module-stored API key.

---

The module provides a single TMGMT **Translator** plugin — `deepl_api` (`DeeplApiTranslator`,
extending the abstract `DeeplTranslator`) — that talks to DeepL through the `deeplcom/deepl-php`
library. You add a DeepL translation provider under TMGMT's translators list (route
`entity.tmgmt_translator.collection` at `/admin/tmgmt/translators`), pick "DeepL API", and select a
**Key entity** of type `deepl_api_key` (the module's own `DeepLApiKeyType` KeyType plugin, which
validates the key against DeepL on save). The API key is never stored in the translator config —
only the Key entity id (`auth_key_entity`) is. Provider settings (schema `tmgmt_deepl_settings`)
map onto DeepL request options: `model_type`, `formality`, `split_sentences`, `preserve_formatting`,
`tag_handling` + `tag_handling_version` + the XML tag lists, `enable_context`, `translate_documents`
+ `enable_document_minification`, `omit_partner_id`, `log_api_requests`, `max_queries`, plus
`auto_accept`. Manual UI submits run through a Batch API (`DeeplTranslatorBatch`); cron/CLI and
continuous jobs run through the `deepl_translate_worker` queue worker, which also polls DeepL
document translations across cron runs. A pre-flight quota check rejects a job before any content is
sent when the account's DeepL quota is exhausted. The module exposes alter hooks
(`hook_tmgmt_deepl_checkout_settings_form_alter`, `hook_tmgmt_deepl_build_configuration_form_alter`,
`hook_tmgmt_deepl_has_checkout_settings_alter`, `hook_tmgmt_deepl_translate_options_alter`). The
`tmgmt_deepl_glossary` submodule adds DeepL multilingual glossary management. The classic
`deepl_free` / `deepl_pro` translators of earlier versions are gone; update hooks migrate existing
providers to `deepl_api` and their inline keys to Key entities.

---

- Machine-translate Drupal content into DeepL's supported languages through TMGMT.
- Add a single "DeepL API" translation provider that works for both DeepL API Free and Pro keys.
- Store the DeepL API key in a Key entity (`deepl_api_key` type) instead of translator config.
- Validate a DeepL API key against DeepL automatically when the Key entity is saved.
- Translate uploaded documents (docx, pptx, PDF, etc.) via DeepL's document endpoint.
- Use DeepL document minification for large documents when enabled.
- Set DeepL formality (more/less/prefer_more/prefer_less) per translation provider.
- Choose the DeepL translation model (`latency_optimized` or `prefer_quality_optimized`).
- Preserve HTML/XML formatting with `tag_handling` (xml/html) and `tag_handling_version` (v1/v2).
- Control sentence splitting via `split_sentences` and the splitting/non-splitting tag lists.
- Exclude specific XML/HTML tags from translation with `ignore_tags`.
- Provide extra translation context per job (`enable_context`) that DeepL uses but does not translate.
- Auto-accept returned translations so jobs complete without manual review (`auto_accept`).
- Process long or continuous jobs through the `deepl_translate_worker` cron queue.
- Tune how many texts are sent per DeepL request with `max_queries` (5–50).
- Reject a job before any content leaves the site when the DeepL quota is exhausted.
- See live DeepL usage (characters/documents) on the provider form and the status report.
- Omit the DeepL partner ID from API requests when desired (`omit_partner_id`).
- Optionally log each DeepL API request/retry for diagnosing rate limits (`log_api_requests`).
- Alter the DeepL translate options before a request via `hook_tmgmt_deepl_translate_options_alter()`.
- Add fields to the DeepL provider or checkout forms via the build/checkout alter hooks.
- Combine with the glossary submodule to enforce term translations per language pair.
- Migrate legacy `deepl_free`/`deepl_pro` providers to `deepl_api` automatically on update.
- Resume an interrupted document translation from its stored handle without a second DeepL charge.
