<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DeepL Translator (tmgmt_deepl) plugs the DeepL machine-translation API into the Translation Management Tool (TMGMT) so Drupal content jobs can be translated automatically by DeepL, using either the free or the pro DeepL API.

---

The module provides two TMGMT **Translator** plugins — `deepl_free` ("DeepL API Free") and
`deepl_pro` ("DeepL API Pro") — that extend a shared `DeeplTranslator` base and share the
`DeeplTranslatorUi` settings form. You add a DeepL translation provider under TMGMT's translators
list (route `entity.tmgmt_translator.collection` at `/admin/tmgmt/translators`), pick free or pro,
enter your DeepL `auth_key`, and tune options that map onto DeepL API parameters — stored on the
`tmgmt_translator` config entity's `settings` (schema `tmgmt_deepl_settings`): `formality`,
`split_sentences`, `tag_handling`, `preserve_formatting`, `outline_detection`,
`(non_)splitting_tags`, `ignore_tags`, `auto_accept`, and the API `url`/`url_usage` endpoints.
Once a provider exists you translate TMGMT jobs with it; long jobs can be processed by the
`deepl_translate_worker` cron queue. The module exposes several alter hooks
(`hook_tmgmt_deepl_checkout_settings_form_alter`, `hook_tmgmt_deepl_has_checkout_settings_alter`,
`hook_tmgmt_deepl_query_string_alter`) and a `DeeplReceivedDataEvent` to post-process translated
text. Actual translation calls DeepL's API and needs a valid auth key, but the translator
provider and all its settings are ordinary Drupal config. The `tmgmt_deepl_glossary` submodule
adds DeepL glossary management.

---

- Machine-translate Drupal content into 30+ languages via DeepL through TMGMT.
- Add a "DeepL API Free" translation provider for low-volume sites (500k chars/month).
- Add a "DeepL API Pro" provider for higher-volume or production translation.
- Set DeepL formality (formal/informal) per translation provider.
- Preserve HTML/XML formatting during translation with tag-handling options.
- Control sentence splitting behavior via `split_sentences` and splitting/non-splitting tags.
- Exclude specific XML tags from translation with `ignore_tags`.
- Auto-accept returned translations so jobs complete without manual review (`auto_accept`).
- Route long translation jobs through the DeepL cron queue worker.
- Configure the DeepL API endpoint (e.g. EU vs default) per provider.
- Translate nodes, taxonomy, menus, and other TMGMT-sources with DeepL.
- Post-process DeepL output with a `DeeplReceivedDataEvent` subscriber (e.g. fix attribute HTML).
- Alter the DeepL query before sending via `hook_tmgmt_deepl_query_string_alter()`.
- Add extra fields to the DeepL checkout settings form via the alter hook.
- Store the DeepL auth key securely (env var / Key) rather than plain config.
- Provide translators different DeepL settings per source/target workflow.
- Combine with the glossary submodule to enforce term translations.
- Use DeepL's outline detection for structured document translation.
- Set up automated multilingual content pipelines in an editorial team.
- Switch a site from a different TMGMT translator to DeepL by adding a provider.
