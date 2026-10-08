<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Translator plugs Google's Translate service into the Translation Management Tool (TMGMT) as a machine translator, so TMGMT jobs can be translated automatically using a Google Cloud Translation API key.

---

The module adds a single TMGMT translator plugin, `google` (`GoogleTranslator`, implementing `ContinuousTranslatorInterface`), whose configuration lives on a `tmgmt_translator` config entity. Its settings are `api_key` (the Google Cloud Translation API key, required), `auto_accept`, and a `url` (a hidden override used only by automated tests). The plugin's UI (`GoogleTranslatorUi`) adds the API-key field to the translator provider form and validates the key by asking Google for its supported languages; `checkAvailable()` reports the translator as available only when an `api_key` is set. At job time it flattens the translatable data, batches source strings into chunks of five, and calls Google's Translate API v2 endpoint (`https://www.googleapis.com/language/translate/v2`) with `source`/`target`/`q` parameters, then unflattens and stores the returned translations on the job items; it also supports language detection and listing supported/remote languages. You use it by creating a TMGMT translator provider of type "Google", pasting a valid API key, mapping languages if needed, and then submitting TMGMT jobs to it (interactively or as continuous jobs).

---

- Machine-translate TMGMT content translation jobs with Google Translate.
- Add a "Google" translation provider to a Drupal site's TMGMT setup.
- Auto-translate nodes, taxonomy terms, and other entities via TMGMT job items.
- Configure automatic acceptance of Google translations with the auto_accept setting.
- Provide first-pass machine translations for human post-editing in TMGMT.
- Translate large content sets by letting TMGMT batch strings to Google in chunks.
- Support continuous translation jobs that translate new content automatically.
- Validate a Google Cloud Translation API key by fetching supported languages.
- Detect the source language of content through Google's detect action.
- List the languages Google supports as remote languages for mapping in TMGMT.
- Map Drupal langcodes to Google's remote language codes on the translator.
- Stand up a low-cost automated translation workflow before investing in human translators.
- Translate interface-adjacent content managed through TMGMT job items.
- Swap between translation providers (Google, DeepL, etc.) by adding multiple TMGMT translators.
- Restrict Google translation to specific language pairs via TMGMT job configuration.
- Bulk-translate a multilingual site's backlog using Google as the translator.
- Keep translation credentials in the translator config (api_key) rather than in code.
- Re-run rejected jobs after fixing an invalid API key reported by the provider.
- Combine Google machine translation with TMGMT's review/accept workflow.
- Use Google as a fallback provider for languages a human team does not cover.
- Preview translation availability per translator via checkAvailable().
- Integrate automated translation into an editorial pipeline built on TMGMT.
