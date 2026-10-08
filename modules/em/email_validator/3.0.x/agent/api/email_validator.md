<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — validating an address programmatically

## Service `email_validator.eva`

Class `Drupal\email_validator\EVA` (extends `Drupal\Component\Utility\EmailValidator`). Constructor args: logger channel `email_validator`, `cache.default`, `config.factory`, `http_client`.

```php
$eva = \Drupal::service('email_validator.eva');
$ok = $eva->isValid('user@example.com'); // bool
```

`isValid($email, ?EmailValidation $validation = NULL)`:
1. Runs core syntactic validation first (`parent::isValid`).
2. If `protection.email_states` is non-empty (i.e. "Disable EVA" is off), calls the e-va.io API and returns `FALSE` unless the returned state is one of the allowed `email_states`.
3. On API error/no-credits, returns the `logs.system_down` policy value (fail-open if `1`, fail-closed if `0`).

Only a return of `TRUE`/`FALSE` is exposed; the raw API response is not returned.

## Service override

`EmailValidatorServiceProvider::alter()` replaces core's `email.validator` service class/arguments with EVA's **when** the current `email.validator` class is still core's `EmailValidator`. Effect: sitewide `\Drupal::service('email.validator')->isValid(...)` may perform the external check under the same config rules. Any other module that decorates `email.validator` first takes precedence (the override is skipped).

## Outbound request (reference)

- `GET https://e-va.io/api/email/validate/{email}` via `http_client` (Guzzle), HTTPS, default TLS verification.
- Headers: `api-key: <general.api_key>`, `CB-ACCESS-TIMESTAMP`, `user-agent`, `content-type: application/json`.
- Response JSON `status` (`ok`/`nok`) and `state` (`Safe`/`Unknown`/`Invalid`/`Risky`); state is mapped to int `0..3` and compared to allowed states. Successful `ok` responses are cached 1 hour.

Note: submitted email addresses are transmitted to the third-party e-va.io service — a data-egress/privacy consideration to confirm and disclose.
