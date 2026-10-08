<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Phrase TMS Translator (tmgmt_memsource) — agent index

TMGMT translator plugin (`id: memsource`, class `MemsourceTranslator`, label "phrase") that pushes
Drupal job items to Phrase TMS / Memsource as XLIFF (and optionally attached Office files) and pulls
translations back. Configured as a TMGMT *Provider* entity, not a global settings form. Depends on
`tmgmt` + `tmgmt_file`. Provides config schema; no permissions of its own, no Drush.

- **Set up the provider, every setting key, routes/webhook, cron pulling, file translation, preview** →
  [configure/translator.md](configure/translator.md)

Key facts:
- Configure route: `entity.tmgmt_translator.collection` (Configuration → Regional and language →
  Translation Management → Providers). The plugin UI lives in `MemsourceTranslatorUi`.
- The plugin implements `ContinuousTranslatorInterface` and declares `files = TRUE`
  (`src/Plugin/tmgmt/Translator/MemsourceTranslator.php`).
- Two authentication methods, chosen by `memsource_auth_method`:
  - `password` (default): user name + password → `/api2/v1/auth/login` returns an API token sent as
    an `Authorization: ApiToken <token>` header.
  - `platform_token`: a Phrase *Platform API Token* is exchanged via OAuth 2.0 token-exchange at the
    IDM endpoint (`/idm/oauth/token`) for a short-lived JWT sent as an `Authorization: Bearer <jwt>`
    header; the JWT's expiry is tracked and proactively refreshed ~5 min before it lapses.
- Settings live on the `tmgmt_translator` config entity's `settings` map (schema
  `tmgmt.translator.settings.memsource`, in `config/schema/tmgmt_memsource.schema.yml`, now covers
  the full key set: `service_url`, `memsource_auth_method`, `memsource_user_name`,
  `memsource_password`, `memsource_change_password`, `memsource_change_platform_token`,
  `memsource_update_job_status`, `enable_file_translation`, `memsource_webhook_token`,
  `memsource_cron_*`, `memsource_source_url_custom_field_uid`, `memsource_public_base_url`,
  `memsource_connector_token`, `project_template`, `due_date`, `group_jobs`, `force_new_project`,
  `memsource_export_workflow_step_uid`). Module-level config `tmgmt_memsource.settings` ships only
  `debug: false`.
- API token / JWT are cached in Drupal `state` under `tmgmt_memsource.token.<translator_id>` (JWT
  expiry under `tmgmt_memsource.token_expiry.<translator_id>`; a stored Platform API Token under
  `tmgmt_memsource.platform_token.<translator_id>`). The password is hex-obfuscated with the
  `MEMSOURCE_V2___` prefix (reversible, not encryption). Requests go through Guzzle `http_client`
  (`sendApiRequest()` → `request()`) with auto re-login + retry on HTTP 401.
- Routes: `/tmgmt_memsource_callback` (webhook, `_access: 'TRUE'`; the controller then validates an
  optional per-translator `memsource_webhook_token`), `/no_preview` (static text, `_access: 'TRUE'`),
  `/pull_all_remote_translations` (gated by `administer tmgmt` + `accept translation jobs`).
- Services: `memsource.cron_task` (`Cron\PullTranslationsTask`, tagged `cron`, also force-run from
  `tmgmt_memsource_cron()`) queues `PullTranslationsWorker` (`@QueueWorker`
  `pull_translations_queue_worker`) to pull completed translations inside the configured
  start/end-hour window. `tmgmt_memsource.preview_package_generator`
  (`PreviewPackage\PreviewPackageGenerator`) renders a Drupal entity preview for upload to Phrase.
- Remote state is tracked per item in `tmgmt_remote` RemoteMapping entities keyed by project uid
  (`remote_identifier_2`) + job-part uid (`remote_identifier_3`), with `remote_data` such as
  `TmsState`, `isFile`, `source_fid`, `datakey`, `target_fid`.
- Live Preview has two methods (`memsource_preview_method`): `legacy_connector` (a Phrase preview
  connector) or `preview_package` (render + upload a preview package at job creation, no Drupal
  credentials stored in Phrase).
