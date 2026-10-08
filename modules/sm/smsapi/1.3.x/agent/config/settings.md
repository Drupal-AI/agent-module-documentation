<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMSAPI configuration

Config object **`smsapi.settings`** (`config_object`). Form
`Drupal\smsapi\Form\ConfigurationForm` (extends `ConfigFormBase`), form id `smsapi_configuration`,
route **`smsapi.configuration`** at `/admin/smsapi/configuration`, permission
`administer site configuration`. Defaults in `config/install/smsapi.settings.yml`, schema in
`config/schema/smsapi.schema.yml`.

## Keys (schema + install defaults)

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `smsapi_service_region` | string | `PL` | Regional endpoint. `PL`→smsapi.pl, `COM`→smsapi.com, `SE`→`https://api.smsapi.se`, `BG`→`https://api.smsapi.bg`. Selected via `getService()` `match` in `SmsapiService`. Not free-text: chosen from a fixed select. |
| `smsapi_token` | string | `''` | SMSAPI **OAuth API token**. Passed to the SDK region service as the bearer credential. Empty token logs an error on service construction. |
| `smsapi_partner` | boolean | `true` | Whether to attach a Partner ID to outbound messages. |
| `smsapi_partner_id` | string | `XLEJ` | Partner code sent as `SendSmsBag::$partnerId` when partner is on (default supports the module authors). |
| `smsapi_environment_status` | boolean | `false` | `false`=PROD, `true`=DEV/Test. In DEV every send is forced to `smsapi_test_phone_number` / `smsapi_test_sender_name`. |
| `smsapi_test_sender_name` | string | `''` | Sender used in Test Environment. Options come live from `getSenders()`. |
| `smsapi_test_phone_number` | string | `''` | Recipient all Test-Environment sends are redirected to. |
| `smsapi_mock_mode` | boolean | `false` | When on (Test only), sets `$sms->test = TRUE` / `CreateMfaBag::$fast = FALSE` so SMSAPI validates but does not deliver/bill. |
| `smsapi_status_message` | boolean | `true` | Whether the service surfaces success/error `messenger` notices to the page. |

## Form behaviour (`ConfigurationForm`)

- Region is a select (PL/COM/SE/BG). Token is a plain textfield.
- `smsapi_test_sender_name` options are fetched from `SmsapiService::getSenders()` — the account's
  active (`ACTIVE`) sender names, or `['Test' => 'Test']` when not connected. The test sender /
  phone / mock fields are `#states`-hidden unless *Use the Test Environment* is checked.
- **`validateForm()`**: empty token → error; a non-empty token is verified live with
  `SmsapiService::checkIfConnected($token)` (a `ping` against the gateway) and rejected as "Wrong
  token" if unauthorized. In Test mode the test sender must be set and the test phone must be
  numeric.
- **`submitForm()`**: writes all keys; when Test Environment is off, `smsapi_test_sender_name`,
  `smsapi_test_phone_number` are cleared and `smsapi_mock_mode` forced false.

## Notes

- `SmsapiService::__construct()` reads every key from `smsapi.settings` and defensively coerces
  types (`is_string`/`is_bool`/`boolval`), so partial config never fatals — it degrades (e.g. empty
  token just logs an error and later sends fail through the SDK).
- `getService(?$token)` returns the correct SDK region service (`smsapiPlService`,
  `smsapiComService`, or `smsapiComServiceWithUri(...)` for SE/BG) built on the private
  `smsapi.core` `SmsapiHttpClient`.
