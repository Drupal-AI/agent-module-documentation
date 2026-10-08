# Google V3 Translator (tmgmt_google_v3) — agent index

One TMGMT **translator plugin** `google_v3` that sends TMGMT jobs to the Google Cloud
Translation **v3** API. Depends on `tmgmt` and the `google/cloud-translate` PHP library. No
settings page of its own (`configure: null`), no permissions, no Drush. All config lives on a
TMGMT **Translator** (provider) entity (`tmgmt_translator`) using this plugin.

- **Create/configure the Google V3 provider: the `tmgmt_translator` entity & its settings** →
  [configure/translator-config.md](configure/translator-config.md)
- **The `google_v3` TranslatorPlugin: how it translates, glossaries, chunking, availability** →
  [plugins/translator.md](plugins/translator.md)
- **Post-processing translated text: `PostTranslationEvent`** →
  [hooks/events.md](hooks/events.md)

Key facts: plugin id `google_v3` (`…\Plugin\tmgmt\Translator\GoogleV3Translator`, UI class
`GoogleV3TranslatorUi`). Settings keys on the translator: `location` (default `global`),
`api_project` (Google project id), `google_credentials` (managed JSON key file in **private://**),
`glossary_mappings` (per-langcode glossary id). Requires private file system enabled. Needs a
real Google API key for live translation — but the provider entity and its non-secret settings
(location, project id, glossary mappings) are ordinary config you can set without one.
