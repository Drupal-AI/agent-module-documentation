<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMSAPI (smsapi) — agent index

Drupal integration with the **SMSAPI.com** SMS gateway. Wraps the official `smsapi/php-client`
SDK behind one injectable service plus an admin UI. Package `SMSAPI`. Core `^10.2 || ^11`,
**PHP 8.3**. License GPL-2.0-or-later. Version dir 1.3.x.

- **Config form, config object/schema, keys, regions, environments** →
  [config/settings.md](config/settings.md)
- **The `smsapi.service` API (send / bulk / template / MFA / profile / callback)** →
  [api/service.md](api/service.md)
- **The `smsapi_sms_template` config entity + admin send forms + routes/permissions** →
  [entities/sms-template.md](entities/sms-template.md)

## Dependencies

- Composer: **`smsapi/php-client:^3.0`** (required; `hook_requirements` errors at install if the
  `Smsapi\Client\SmsapiClient` interface is missing).
- No Drupal module dependencies. No submodules.

## What it provides (from source)

- **1 service** `smsapi.service` → `Drupal\smsapi\Services\SmsapiService` (public, autowired) —
  `sendSms`, `sendMultipleSms`, `sendSmsWithTemplate`, `sendMultipleTemplateSms`,
  `sendVerificationCode`, `checkVerificationCode`, `getSenders`, `getProfileData`,
  `checkIfConnected`, `writeCallbackIntoLogs`. Backed by helper service
  `smsapi.template_service` (`SmsapiSmsTemplateService`) and two private services
  `smsapi.core` (`Smsapi\Client\Curl\SmsapiHttpClient`) and `smsapi_mfa_bag` (`CreateMfaBag`).
- **1 config entity type** `smsapi_sms_template` (`src/Entity/SmsapiSmsTemplate.php`,
  `ConfigEntityBase`) with list builder + add/edit/delete forms. Admin permission
  **`administer smsapi sms templates`**. An `auth_code` template is created in `hook_install`.
- **1 config object** `smsapi.settings` (schema in `config/schema/smsapi.schema.yml`, defaults in
  `config/install/smsapi.settings.yml`). Settings route id **`smsapi.configuration`**.
- **1 permission** `administer smsapi sms templates` (`smsapi.permissions.yml`).
- **1 theme hook** `smsapi__profile` (`smsapi_theme` in `.module`), template
  `templates/smsapi--profile.html.twig`, library `smsapi/profile` (css only).
- **Routes** (`smsapi.routing.yml`): admin menu `/admin/smsapi/*` (configuration, send-sms,
  send-sms-with-template, profile) all `_permission: administer site configuration`; the SMS
  template entity routes under `/admin/structure/smsapi-sms-template`; and the delivery-report
  endpoint `smsapi.callback` at `/smsapi/callback` (GET) →
  `SmsapiController::createSmsLogs`.

## Operate

1. `drush en smsapi` (Composer pulls `smsapi/php-client`).
2. Visit `/admin/smsapi/configuration`, pick region, paste OAuth token (validated live against the
   gateway on save), save.
3. Send from `/admin/smsapi/send-sms`, or inject `smsapi.service` in code — see
   [api/service.md](api/service.md).
