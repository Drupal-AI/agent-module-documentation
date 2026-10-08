# MemoQ translator (tmgmt_memoq) — agent index

A **TMGMT translator plugin** (`tmgmt_memoq`) that sends translation jobs to a memoQ server's CMS API as
gzipped XLIFF and imports completed translations back. Depends on `tmgmt` + `tmgmt_file`. No standalone
config page (`configure` null) — settings live on a TMGMT `translator` entity. No permissions, no Drush.
Provides a config schema and two alter hooks.

- **Configure the memoQ translator: settings keys, language mapping, XLIFF options, connect test** →
  [configure/translator.md](configure/translator.md)
- **The request → order → callback/fetch flow and the outbound `request()` client** →
  [api/flow.md](api/flow.md)
- **`hook_tmgmt_memoq_order_info_alter` / `hook_tmgmt_memoq_job_info_alter`** → [hooks/alter.md](hooks/alter.md)

Key facts:
- Plugin: `src/Plugin/tmgmt/Translator/MemoQTranslator.php` (id `tmgmt_memoq`, UI
  `src/MemoQTranslatorUi.php`).
- Settings (schema `tmgmt.translator.settings.tmgmt_memoq`): `api_url`, `api_key`, `job_name_prefix`,
  `memoq_languages` (langcode→memoQ code), `xliff_processing`, `xliff_cdata`.
- Outbound auth header: `Authorization: CMSGATEWAY-API <api_key>` to `<api_url>/<path>`.
- Callback route `tmgmt_memoq.callback` → `/tmgmt/memoqcallback/{tmgmt_job}`; imports translation on
  `NewStatus == TranslationReady`.
