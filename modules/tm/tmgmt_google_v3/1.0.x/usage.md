Google V3 Translator is a TMGMT **translator plugin** (`google_v3`) that sends TMGMT translation jobs to the Google Cloud Translation **v3** API, with optional per-language glossary support.

---

The module adds one `@TranslatorPlugin` (id `google_v3`, class
`Drupal\tmgmt_google_v3\Plugin\tmgmt\Translator\GoogleV3Translator`) to Translation Management
Tools (TMGMT). You configure it by creating a TMGMT **Translator** (provider) config entity
(`tmgmt_translator`) that uses the `google_v3` plugin and supplies three settings: a **Location**
(default `global`), a Google Cloud **Project ID** (`api_project`), and a **Google API
Credentials** JSON key file uploaded as a managed file (stored in the **private** filesystem —
you must have private files enabled). An optional **Glossary mappings** fieldset lets you map each
Drupal language to a Google glossary id. Once configured, TMGMT routes jobs through this provider:
the plugin instantiates Google's `TranslationServiceClient` from the credentials file, flattens
the job's translatable data, calls `translateText()` per text segment (chunking anything over
20,000 characters), applies a glossary config when one is mapped for the target language,
dispatches a `PostTranslationEvent` so other modules can post-process each translated string, then
writes the translation back onto the job item. It implements `ContinuousTranslatorInterface`, so
it also works with TMGMT continuous jobs and marks items inactive on quota-exhausted
(`RESOURCE_EXHAUSTED`) responses. `checkAvailable()` requires location, project id and credentials
to be set; `getSupportedRemoteLanguages()` queries Google for the language list (used by the
form's "Connect" test button). The module has no admin settings page of its own (`configure:
null`), no permissions and no Drush — all configuration lives on the translator entity.

---

- Machine-translate Drupal content through Google Cloud Translation v3 inside TMGMT workflows.
- Add a "Google V3" translation provider (Translator) to a multilingual site.
- Translate nodes, taxonomy terms, and other entities via TMGMT jobs sent to Google.
- Configure a Google Cloud project id and location for the translation provider.
- Upload a Google service-account JSON key as the provider's credentials (private file storage).
- Use Google glossaries per target language for consistent domain terminology.
- Map each Drupal language to a specific Google glossary id.
- Run continuous TMGMT translation jobs against Google V3 (auto-translate on content changes).
- Post-process Google's output via the `PostTranslationEvent` (e.g. fix entities, tweak markup).
- Test connectivity/credentials with the translator form's "Connect" button (lists supported languages).
- Fetch the list of Google-supported remote languages for a translator.
- Handle very long fields by automatically chunking text over 20,000 characters per request.
- Gracefully mark job items inactive when Google returns a quota-exhausted error on continuous jobs.
- Reject and log a job with the API error when a translation request fails.
- Provide machine translation as a first pass before human review in TMGMT.
- Swap an older Google v2 TMGMT provider for the supported v3 API.
- Translate between languages whose local Drupal code differs from Google's model code (e.g. zh-hant variants) using per-language glossary/target mapping.
- Centralize translation credentials on a single provider entity reused across jobs.
- Support decoupled/continuous localization pipelines that push new strings to Google automatically.
- Combine with TMGMT's job/checkout UI to review and accept Google translations.
