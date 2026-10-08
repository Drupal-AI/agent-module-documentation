<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup & configuration

## Install / enable

```bash
composer require drupal/ai_provider_dxpr
drush en ai_provider_dxpr
```

Composer pulls `drupal/ai` (`^1.4`), `drupal/key`, `drupal/dxpr_builder` (>=2.7.5) and
`openai-php/client`. Get a free API key at dxpr.com and store it in a Key entity
(Configuration » System » Keys). `hook_install()` auto-selects any existing Key whose **label
contains "DXPR"** as the default `api_key` and logs a notice.

## Config form

`src/Form/DxprConfigForm.php` (`ConfigFormBase`, const `CONFIG_NAME = ai_provider_dxpr.settings`),
route **`ai_provider_dxpr.settings_form`** at `/admin/config/ai/providers/dxpr`, requirement
**`_permission: 'administer ai providers'`** (`…routing.yml`). Menu link `…settings_menu` under
`ai.admin_providers`.

Fields / behaviour:
- `api_key` — `#type: key_select`, stores the **Key entity id**.
- `host` — base URI override (default `kavya.dxpr.com/v1`).
- `ai_model`, `ai_provider_selection_mode` (automatic / manual override), and a draggable
  provider-priority table (Anthropic, Gemini, Mistral, OpenAI, xAI) shown for `kavya-m1`.
- `em_dash_mode` and per-language `em_dash_language_overrides`.
- A usage panel showing the account **credit balance** and **monthly usage**
  (`licenseService->getAiUsageData()`, rendered via `number_format()`).

`validateForm()` resolves the selected key
(`keyRepository->getKey(...)->getKeyValue()`), builds an openai client with that key + host, and
lists models to prove the key works (errors → `setErrorByName('api_key', …)`). `submitForm()`
saves the key, model, selection mode, provider order, em-dash mode/overrides, then runs
`DxprHelper::testRateLimit()` to warn about the free tier / exhausted quota.

## Config object

`ai_provider_dxpr.settings` (schema `config/schema/…schema.yml`, `type: config_object`):
- `api_key` (string) — Key entity id.
- `host` (string) — API base URI.
- `em_dash_mode` (integer, 0-3).
- `em_dash_language_overrides` (sequence of integer, keyed by langcode).

Install defaults (`config/install/…settings.yml`): empty `api_key`/`host`, `em_dash_mode: 3`,
empty overrides. `hook_update_10001()` back-fills the em-dash keys on existing sites.

## Services, hooks, libraries

- `ai_provider_dxpr.helper` → `DxprHelper` (`testRateLimit()` posts a tiny chat request with the
  Bearer key to detect the free tier / HTTP 402 and warns via messenger).
- `DxprProviderHooks` (OO hook service) — `#[Hook('form_ai_settings_alter')]`
  `aiSettingsFormAlter()` adds a warning on the AI settings page, linking to this form, when no
  `api_key` is configured.
- Asset libraries (`ai_provider_dxpr.libraries.yml`): `ai-providers` (provider-table drag/drop UI)
  and `em-dash-settings`.

## Operation

After configuring the key, select the **DXPR** provider in any AI module provider/model dropdown
for chat, translation and image operations. Request parameter defaults per operation live in
`definitions/api_defaults.yml`.
