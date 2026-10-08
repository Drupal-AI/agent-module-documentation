<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Phone Number — plugins it provides

Like its parent it implements core plugin types (no new plugin *types*), plus a TFA plugin and a
REST resource.

| Plugin | Kind | Id / class |
|---|---|---|
| SMS Phone Number | Field type | `sms_phone_number` — `Plugin/Field/FieldType/SmsPhoneNumberItem` (extends phone_number's `PhoneNumberItem`; default widget `sms_phone_number_default`, default formatter `sms_phone_number_international`, constraint `SmsPhoneNumber`). |
| SMS Phone Number widget | Field widget | `sms_phone_number_default` — `Plugin/Field/FieldWidget/SmsPhoneNumberWidget` (sends/validates codes). |
| International / Local / Country | Field formatters | `sms_phone_number_international`, `sms_phone_number_local`, `sms_phone_number_country`. |
| Verified | Field formatter | `sms_phone_number_verified` — `SmsPhoneNumberVerifiedFormatter` (shows verified status). |
| SmsPhoneNumber | Validation constraint | `Plugin/Validation/Constraint/SmsPhoneNumberConstraint` + validator. |
| sms_phone_number | Form element | `Element/SmsPhoneNumber`. |
| SMS Phone Number TFA | TFA validation + send plugin | `Plugin/TfaValidation/SmsPhoneNumberTfa` (implements `TfaValidationInterface`, `TfaSendInterface`; for the `tfa` module — SMS-based two-factor login using `sms_phone_number.util::verifyCode()`). |
| Request verification code | REST resource | `request_verification_code` — `Plugin/rest/resource/RequestVerificationCodeResource`, canonical URI `/sms-phone-number/request-code/{number}`. |
| SMS Phone Number | Feeds target | `Feeds/Target/SmsPhoneNumber`. |

## Implementing / using

- **Add a verifiable field:** create an `sms_phone_number` field with `verify` set
  (see [../configure/field-and-settings.md](../configure/field-and-settings.md)).
- **Enable SMS two-factor:** enable the `tfa` module, configure TFA to use the
  `SmsPhoneNumberTfa` plugin, and set `sms_phone_number.settings:tfa_field` to the user phone
  field.
- **Request a code over REST:** GET the `request_verification_code` resource at
  `/sms-phone-number/request-code/{number}` (needs the REST module + permission configured).
- **Change how SMS is sent:** implement
  `hook_sms_phone_number_send_sms_callback_alter()` (see
  [../api/util-and-hooks.md](../api/util-and-hooks.md)).
