# Advanced Email Validation — the validator service

Service id **`advanced_email_validation.validator`**, class
`Drupal\advanced_email_validation\AdvancedEmailValidator` (interface
`AdvancedEmailValidatorInterface`). Injects `config.factory`. Wraps
`EmailValidator\EmailValidator` from the `stymiee/email-validator` composer library.

## Recommended call (2.1+)

```php
/** @var \Drupal\advanced_email_validation\AdvancedEmailValidatorInterface $v */
$v = \Drupal::service('advanced_email_validation.validator');
$result = $v->validateEmail($email, $configOverrides = [], $errorMessages = []);
if (!$result->isValid()) {
  // $result->errorCode  (int, EmailValidator::* code)
  // $result->message    (configured, translatable message string)
}
```

`validateEmail()` returns an `EmailValidationResult` (`src/EmailValidationResult.php`) with
public `errorCode` and `message` and an `isValid()` helper (valid ⇔ `errorCode ===
EmailValidator::NO_ERROR`).

- `$configOverrides` — when non-empty, replaces the settings-derived config passed to the
  library. The default config maps settings keys to library keys: `checkMxRecords`,
  `checkBannedListedEmail`, `checkDisposableEmail`, `checkFreeEmail`, `bannedList`,
  `disposableList`, `freeList`, `LocalDisposableOnly`, `LocalFreeOnly`.
- `$errorMessages` — override the per-code messages; otherwise messages come from
  `advanced_email_validation.settings:error_messages`.

## Deprecated methods (removed in 3.0.0)

`validate(string $email): int` and `errorMessageFromCode(int, array): string` still exist but
`@trigger_error` a deprecation. Use `validateEmail()` instead.

## Error codes

Mapped in `buildErrorMessage()`: `FAIL_BASIC` → `basic`, `FAIL_MX_RECORD` → `mx_lookup`,
`FAIL_DISPOSABLE_DOMAIN` → `disposable`, `FAIL_FREE_PROVIDER` → `free`, `FAIL_BANNED_DOMAIN` →
`banned` (constants from `EmailValidator\EmailValidator`).
