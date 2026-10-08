<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Phrase TMS Translator (tmgmt_memsource) — agent index

TMGMT translator plugin (`id: memsource`, class `MemsourceTranslator`, label "phrase") that pushes
Drupal job items to Phrase TMS / Memsource as XLIFF (and optionally attached Office files) and pulls
translations back. Configured as a TMGMT *Provider* entity, not a global settings form. Depends on
`tmgmt` + `tmgmt_file`. Provides config schema; no permissions of its own, no Drush.

- **Set up the provider, every setting key, routes/webhook, cron pulling, file translation** →
  [configure/translator.md](configure/translator.md)

Key facts:
- Configure route: `entity.tmgmt_translator.collection` (Configuration → Regional and language →
  Translation Management → Providers). The plugin UI lives in `MemsourceTranslatorUi`.
- The plugin implements `ContinuousTranslatorInterface` and declares `files = TRUE`
  (`src/Plugin/tmgmt/Translator/MemsourceTranslator.php`).
- Settings live on the `tmgmt_translator` config entity's `settings` map (schema
  `tmgmt.translator.settings.memsource` only covers `auto_accept`, `url`, `client_id`,
  `client_secret`; the UI actually stores `service_url`, `memsource_user_name`,
  `memsource_password`, `enable_file_translation`, `memsource_update_job_status`,
  `memsource_cron_*`, `memsource_connector_token`). Module-level config
  `tmgmt_memsource.settings` ships only `debug: false`.
- API token is cached in Drupal `state` under `tmgmt_memsource.token.<translator_id>`; password is
  hex-obfuscated with the `MEMSOURCE_V2___` prefix (reversible, not encryption). The token is sent
  in an `Authorization: ApiToken <token>` header; requests go through Guzzle `http_client`
  (`sendApiRequest()` → `request()`) with auto re-login + retry on HTTP 401.
- Routes: `/tmgmt_memsource_callback` (webhook, `_access: 'TRUE'`), `/no_preview` (static text,
  `_access: 'TRUE'`), `/pull_all_remote_translations` (gated by
  `administer tmgmt` + `accept translation jobs`).
- Services: `memsource.cron_task` (`Cron\PullTranslationsTask`, tagged `cron`, also force-run from
  `tmgmt_memsource_cron()`) queues `PullTranslationsWorker` (`@QueueWorker`
  `pull_translations_queue_worker`) to pull completed translations inside the configured
  start/end-hour window.
- Remote state is tracked per item in `tmgmt_remote` RemoteMapping entities keyed by project uid
  (`remote_identifier_2`) + job-part uid (`remote_identifier_3`), with `remote_data` such as
  `TmsState`, `isFile`, `source_fid`, `datakey`, `target_fid`.
