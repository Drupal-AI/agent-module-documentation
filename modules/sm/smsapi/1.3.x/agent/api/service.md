<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `smsapi.service` API

Service id **`smsapi.service`** → `Drupal\smsapi\Services\SmsapiService` implements
`SmsapiServiceInterface`. Public + autowired (`smsapi.services.yml`). Inject it, don't instantiate:

```php
$sms = \Drupal::service('smsapi.service'); // or constructor-inject 'smsapi.service'
$sms->sendSms('48123456789', 'Hello World!', 'MySender');
```

Constructor deps: `@config.factory`, `@smsapi.core` (`SmsapiHttpClient`), `@smsapi_mfa_bag`
(`CreateMfaBag`), `@messenger`, `@smsapi.template_service`, `@logger.factory` (channel `smsapi`).

## Methods (interface `SmsapiServiceInterface`)

- `checkIfConnected(string $api_token = ''): bool` — `ping` against the gateway; returns
  `$result->authorized`. Used by the config form to validate the token.
- `sendSms(string $phone, string $message, string $sender = ''): ?Sms` — sends one SMS. Returns the
  SDK `Sms` object, or `NULL` on exception (error logged; optional messenger notice).
- `sendMultipleSms(array $phones, string $message, string $sender = ''): ?array` — bulk send via
  `SendSmssBag`.
- `sendSmsWithTemplate(string $phone, string $templateName, array $values, string $sender = ''): ?Sms`
  — loads the `smsapi_sms_template` entity, renders it with `$values`, sends.
- `sendMultipleTemplateSms(array $phones, string $templateName, array $values, string $sender = ''): ?array`
  — bulk templated send.
- `sendVerificationCode(string $phone, string $templateName = '', array $values = [], string $sender = ''): ?Mfa`
  — generates an MFA/OTP via `mfaFeature()->generateMfa()`. Default message
  `"Your verification code: [%code%]"`; a supplied template **must** contain the `[%code%]` token or
  it errors and returns `NULL`.
- `checkVerificationCode(string $code, string $phone): array` — verifies an OTP via
  `verifyMfa(new VerificationMfaBag(...))`. Returns `['status'=>true,'message'=>'valid']` on success,
  or `['status'=>false,'message'=>..,'code'=>..]` on `ApiErrorException`.
- `getSenders(): array` — active (`ACTIVE`) sender names as `[name=>name]`, or `['Test'=>'Test']`
  when not connected.
- `getProfileData(): ?Profile` — account profile (`profileFeature()->findProfile()`); `NULL` if not
  connected.
- `writeCallbackIntoLogs(Request $request): void` — parses a delivery-report request and writes it
  to the `smsapi` log channel (see below).

## Environment / mock behaviour (applies to every send)

Read once in the constructor from `smsapi.settings`:

- **DEV/Test env** (`smsapi_environment_status = true`): recipient is overridden to
  `smsapi_test_phone_number` and sender to `smsapi_test_sender_name`; if the test phone is empty the
  send is aborted with a warning (`NULL`). Bulk sends replace the whole recipient list with the
  single test number.
- **Mock** (`smsapi_mock_mode = true`): sets `$sms->test = TRUE` (SMSAPI validates without
  delivering); for MFA sets `CreateMfaBag::$fast = FALSE`.
- **Partner** (`smsapi_partner = true`): sets `$sms->partnerId = smsapi_partner_id`.
- Encoding is fixed `utf-8`. All sends are wrapped in try/catch → log `error` + optional messenger.

## Region routing

`getService(?$token)` (protected) picks the SDK service by `smsapi_service_region`:
`COM`→`smsapiComService`, `SE`/`BG`→`smsapiComServiceWithUri($token,'https://api.smsapi.se|bg')`,
default (`PL`)→`smsapiPlService`. Built on the private `smsapi.core` `SmsapiHttpClient` (cURL,
standard TLS verification).

## Delivery-report callback

Route `smsapi.callback` (`/smsapi/callback`, GET) → `SmsapiController::createSmsLogs()` calls
`writeCallbackIntoLogs()` when a `MsgId` query param is present, then returns `OK` (200).
`writeCallbackIntoLogs()` reads `MsgId,from,to,status,status_name` (each `is_string`-checked),
splits each on commas, and writes one `logger->info` row per id with `@`-escaped placeholders.
Configure SMSAPI to POST reports to `<site>/smsapi/callback` (per README).
