<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Phone Number — service & hook

## Service `sms_phone_number.util`

Interface `Drupal\sms_phone_number\SmsPhoneNumberUtilInterface` (class `SmsPhoneNumberUtil`,
extends phone_number's util). Constructor args: `@config.factory`, `@entity_field.manager`,
`@module_handler`, `@country_manager`, `@token`, `@flood`.

Key methods (in addition to everything on `phone_number.util`):

- `isSmsEnabled()` — whether an SMS sending callback is available (e.g. SMS Framework installed).
- `generateVerificationCode($length = 4)` — make a numeric code.
- `sendVerification(PhoneNumber $n, $message, $code, array $token_data = [])` — send a code by SMS.
- `registerVerificationCode(PhoneNumber $n, $code)` — persist a code for later checking.
- `verifyCode(PhoneNumber $n, $code, $token = NULL)` — validate a submitted code.
- `isVerified(PhoneNumber $n)` — whether the number is already verified.
- `getToken(PhoneNumber $n)` / `codeHash(PhoneNumber $n, $token, $code)` — token/hash helpers.
- `checkFlood(PhoneNumber $n, $type = 'verification')` — flood/rate-limit check
  (defaults: 5 verify attempts/hour, 1 SMS/minute).
- `sendSms($number, $message)` / `smsCallback()` — low-level send + the resolved callback.
- TFA: `isTfaEnabled()`, `getTfaField()` / `setTfaField($field_name)`, `tfaAccountNumber($uid)`.

Constants: `PHONE_NUMBER_VERIFY_NONE|OPTIONAL|REQUIRED`, `PHONE_NUMBER_VERIFIED` (1),
`PHONE_NUMBER_UNIQUE_YES_VERIFIED` (2), `PHONE_NUMBER_DEFAULT_SMS_MESSAGE`,
`VERIFY_ATTEMPTS_COUNT/INTERVAL`, `SMS_ATTEMPTS_COUNT/INTERVAL`.

```php
$util = \Drupal::service('sms_phone_number.util');
if ($util->isSmsEnabled()) {
  $code = $util->generateVerificationCode();
  $util->sendVerification($phoneNumber, $template, $code, $tokenData);
}
```

## Hook the module invites

Defined in `sms_phone_number.api.php`:

```php
/**
 * Set or alter the SMS callback used for verification (only ONE callback allowed).
 * Callback signature: fn(string $phone_number /* international */, string $message).
 * Defaults to 'sms_send' when SMS Framework is enabled.
 */
function hook_sms_phone_number_send_sms_callback_alter(&$send_sms_callback) {
  $send_sms_callback = 'my_sms_callback';
}
```

Implement this to route verification texts through your own gateway/provider.
