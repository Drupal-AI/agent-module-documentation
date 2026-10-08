<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Lionbridge Content API translator

There is **no module settings page**. `tmgmt_contentapi.info.yml` sets
`configure: entity.tmgmt_translator.collection`, so configuration is a **TMGMT translator
entity** you create at `/admin/tmgmt/translators` (Configuration › Regional and language ›
Translation Management Tool › Providers). Choose the **"Lionbridge Content API Connector"**
plugin (`@TranslatorPlugin(id="contentapi")`). The form is built by
`Drupal\tmgmt_contentapi\ContentApiTranslatorUI::buildConfigurationForm()`.

The saved entity is `tmgmt.translator.contentapi` (id defaults to `contentapi`). All values
below live under its `settings` key. As of 9.5.x the module ships
`config/schema/tmgmt_contentapi.translator.schema.yml`, which declares
`tmgmt.translator.settings.contentapi` (extending `tmgmt.translator_base`) with the
`auto_bundle` and `continuous_settings` mappings; the credential/host keys below are still
carried under TMGMT's generic translator settings schema.

## Translator-level settings (`ContentApiTranslator::defaultSettings()` + UI)

| Setting key | Form label | Notes |
|---|---|---|
| `export_format` | Export to | Format plugin id, default `contentapi_xlf` (see [plugins/format.md](../plugins/format.md)). |
| `xliff_cdata` | XLIFF CDATA | Use CDATA on import/export; when on, `xliff_processing` is ignored. |
| `xliff_processing` | Extended XLIFF processing | Mask HTML tags instead of escaping. Default FALSE (back-compat). |
| `allow_override` | Allow export-format overrides | Enables per-job checkout settings (`hasCheckoutSettings`). |
| `one_export_file` | Use one export file for all items | Default TRUE. |
| `scheme` | Download method | Stream wrapper for exported files, default `public`. |
| `process_method` | Import Process | `0` = Quick Scan, `1` = Failsafe scan. |
| `transfer-settings` | Transfer all files as zip | Default FALSE. |
| `capi-settings.po_reference` | PO Number | Optional default PO. |
| `capi-settings.capi_username_ctt` | Client ID | **Required.** Lionbridge client id. |
| `capi-settings.capi_password_ctt` | Client Secret ID | **Required.** Lionbridge client secret. |
| `capi-settings.capi_host` | Host | **Required.** Default `https://contentapi.lionbridge.com/v2`; staging `https://content-api.staging.lionbridge.com/v2`. |
| `capi-settings.provider` | Provider configuration | Chosen from providers fetched live from the API. |
| `capi-settings.allow_provider_override` | Allow provider overrides | Let editors change provider per job. |
| `capi-settings.token` | (none) | OAuth bearer token cached into settings after validation. |
| `cron-settings.status` | Auto Import Job | Auto-import completed jobs on cron. |
| `code-analysis-settings.*` | Analysis Code | Optional Freeway SOAP integration (see bottom). |
| `auto_bundle.*` | Auto-Bundle | Set on the separate Auto-Bundle tab — see [auto-bundle.md](auto-bundle.md). |
| `continuous_settings.*` | Continuous / workflow gate | Required moderation states — see [auto-bundle.md](auto-bundle.md). |

> The `auto_bundle` and `continuous_settings` keys live on the same translator entity but are
> written by `AutoBundleForm`, not by the provider edit form. The module adds a submit handler
> (`_tmgmt_contentapi_translator_preserve_settings_*`) on the translator add/edit/clone forms
> precisely so re-saving the provider form does not drop those sibling keys.

Saving the form **validates the credentials**: `validateConfigurationForm()` calls
`TokenApi::generateNewToken(clientId, clientSecret)` against
`https://login.lionbridge.com/connect/token` (OAuth `client_credentials`) and then
`ProviderApi::providersGet($token)`. A bad Client ID/Secret sets an error on the credential
fields; a bad host sets an error on `capi_host`. The host is also mirrored into
`tmgmt.translator.contentapi` config as `settings.capi-settings.capi_host` while validating.

## Per-job checkout settings (`checkoutSettingsForm()`)

When `allow_override` is on, each job's checkout form adds: export format, PO reference,
description, expected due date (defaults to now + 14 days), task (`trans` = Translation),
provider (editable only if `allow_provider_override`), optional Analysis Code selects, and a
Quote checkbox (only if the selected provider `getSupportQuote()`).

## Set it via PHP/drush (no UI)

```php
$t = \Drupal\tmgmt\Entity\Translator::create([
  'name' => 'contentapi',
  'label' => 'Lionbridge Content API Connector',
  'plugin' => 'contentapi',
  'settings' => [
    'export_format' => 'contentapi_xlf',
    'allow_override' => TRUE,
    'scheme' => 'public',
    'one_export_file' => TRUE,
    'capi-settings' => [
      'capi_username_ctt' => getenv('LIONBRIDGE_CLIENT_ID'),
      'capi_password_ctt' => getenv('LIONBRIDGE_CLIENT_SECRET'),
      'capi_host' => 'https://contentapi.lionbridge.com/v2',
      'provider' => 'PROVIDER_ID',
      'allow_provider_override' => FALSE,
    ],
    'cron-settings' => ['status' => TRUE],
  ],
]);
$t->save();
```

Read one back: `\Drupal::entityTypeManager()->getStorage('tmgmt_translator')->load('contentapi')->getSetting('capi-settings')`.

## Analysis Code (Freeway) settings — optional

`settings.code-analysis-settings`: `freeway_auth_url`
(default `https://fwapi.lionbridge.com/Obvibundles/freewayauth.asmx`), `freeway_service_url`
(`.../freewayservice.asmx`), `analysis_code_username`, `analysis_code_password`, and
`level_1`/`level_2`/`level_3` visibility. If any level is selected, all four fields become
required. A "Test connection" AJAX button hits the Freeway SOAP API via
`tmgmt_contentapi.analysis_code_api`.
