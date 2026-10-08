# Configure the memoQ translator

There is no module settings page. You create a **TMGMT translator** of type "MemoQ" at
`admin/tmgmt/translators` (or `admin/config/regional/tmgmt/translators`); its settings are stored on the
`tmgmt.translator.<id>` config entity under `settings` (schema
`tmgmt.translator.settings.tmgmt_memoq`). Form built by `src/MemoQTranslatorUi.php`.

## Settings keys

| Key | Form label | Meaning |
|---|---|---|
| `api_url` | CMS API URL | Base URL of the memoQ CMS API gateway. Every request is `"$api_url/$path"`. |
| `api_key` | CMS API key | Sent as header `Authorization: CMSGATEWAY-API <api_key>`. |
| `job_name_prefix` | Prefix for the MemoQ order name | Prepended to the order `Name`. |
| `memoq_languages` | (language mapping details) | Map of Drupal `langcode` → memoQ language code (select per site language; options come from memoQ's `languages` endpoint). |
| `xliff_processing` | Extended XLIFF processing | Bool. Mask HTML tags / process semantics instead of just escaping. Default `TRUE`. |
| `xliff_cdata` | XLIFF CDATA | Bool. Use CDATA for XLIFF import/export. Default `FALSE`. |

The language-mapping selects are `#required` once the translator reports available (api_url + api_key set),
and their options are fetched live from memoQ (`getSupportedMemoqLanguages` → `languages` endpoint), so the
credentials must be valid to populate them.

## Availability & connection test

- `checkAvailable()` returns yes only when both `api_key` and `api_url` are set (and reports if the `zlib`
  PHP extension is missing — required for gzip).
- The settings form has a **Connect** button; on save, `validateConfigurationForm()` calls
  `testConnection()` (`GET <api_url>/client`) and blocks saving on error.

## Per-job setting

At checkout each job gets a **Deadline** (`datetime`) field (`checkoutSettingsForm`), passed to the memoQ
order as `Deadline` (ISO-8601) when set.

## Credentials note

`api_key` is stored in the translator config like any TMGMT provider secret; override it per environment
via `$config['tmgmt.translator.<id>']['settings']['api_key']` in `settings.php` if you don't want it in
exported config.
