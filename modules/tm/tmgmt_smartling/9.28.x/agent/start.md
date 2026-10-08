# Smartling Translator (tmgmt_smartling) — agent index

A TMGMT provider plugin (`smartling`) that uploads translatable Drupal content to the Smartling
platform (via `smartling/api-sdk-php` v5), optionally uploads visual context, and downloads finished
translations back into TMGMT jobs. Depends on `tmgmt`, `tmgmt_file`, `tmgmt_extension_suit`,
`serialization`. Providers configured under TMGMT (*Translation → Providers*); no top-level module
`configure` route. Provides permissions, config schema, alter hooks, and callback routes.

- **Provider (translator plugin) settings: Smartling credentials, formats, callbacks, context, cron/queues** →
  [configure/provider.md](configure/provider.md)
- **Permissions (`send context smartling`, `see smartling messages`) and the callback/action routes** →
  [permissions/tmgmt_smartling.md](permissions/tmgmt_smartling.md)
- **Alter hooks in `tmgmt_smartling.api.php` (context URL, file names, directives, XML import/export, lock fields)** →
  [hooks/api.md](hooks/api.md)

Key facts:
- Translator plugin: `Plugin/tmgmt/Translator/SmartlingTranslator.php` + UI `SmartlingTranslatorUi.php`.
- Uploads/downloads go through `tmgmt_extension_suit` `FlowScheduler::scheduleUpload/scheduleDownload`
  (cron/queues), or Smartling's callback.
- Callback routes: `POST /tmgmt-smartling-callback/{job}` and `/{job}/{file}` — Smartling calls these
  when a translation is ready, and they schedule a translation download for that job via
  `FlowScheduler::scheduleDownload`. Registered with Smartling only when a provider has
  `callback_url_use` enabled (default off).
- Submodules (present but not separately documented this pass): `tmgmt_smartling_acquia_cohesion`
  (hidden, needs `cohesion`), `tmgmt_smartling_context_debug`, `tmgmt_smartling_log_settings`
  (`configure: system.logging_settings`), `tmgmt_smartling_test` (hidden, test-only) and its nested
  `tmgmt_smartling_test_alter_filename`.
