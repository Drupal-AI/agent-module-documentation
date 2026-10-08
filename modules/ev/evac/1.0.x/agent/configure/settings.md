# Configure evac + use its validators

Config form: route `evac.settings` → `/admin/config/evac`. Permission:
`administer evac configuration` (`restrict access: TRUE`). Config object: `evac.settings`.

## Settings keys (`evac.settings`, defaults from `config/install`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `replace` | bool | `true` | Replace core's `email.validator` with the chosen validation. Uncheck to leave core intact and only use the services in your own code. |
| `replacement` | string | `dns_check` | Which validation replaces core. One of `dns_check`, `spoof_check`, `message_id`, `no_rfc_warnings`, `multiple_with_and` (constrained by schema `Choice`). |
| `multiple_with_and` | map | dns_check + spoof_check on | Which sub-validations must ALL pass when `replacement = multiple_with_and`. Keys: `dns_check`, `spoof_check`, `message_id`, `no_rfc_warnings`, `rfc`; value `'0'` = off, anything else = on. |
| `log_errors` | bool | `false` | Log rejected addresses to the `evac` logger channel. |
| `log_warnings` | bool | `false` | Also log RFC warnings (only when `log_errors` is on). |

Not recommended for production logging (records submitted addresses).

## How the core service swap works

`EvacServiceProvider::alter()` (a `ServiceModifierInterface`) runs at container build:

```php
$def = $container->getDefinition('email.validator');
if ($def->getClass() === \Drupal\Component\Utility\EmailValidator::class) {
  $def->setClass(ReplacementSwitcher::class);
  $def->addArgument(new Reference('config.factory'));
}
```

So the swap is a no-op if another module already overrode `email.validator`. `ReplacementSwitcher`
reads `evac.settings`; `getReplacementValidator()` returns the configured validator service, or
`NULL` (→ core `EmailValidator`) when `replace` is false or the class can't be found. Rebuild the
container (`drush cr`) after enabling/changing the module for the swap to take effect.

## Available validator services

Each is a Drupal service implementing `Drupal\Component\Utility\EmailValidatorInterface` and wraps
the matching egulias `EmailValidation`:

| Service id | Class | egulias validation |
|---|---|---|
| `email.validator.dns_check` | `Utility\DNSCheckValidator` | `DNSCheckValidation` (TLD + MX) |
| `email.validator.message_id` | `Utility\MessageIDValidator` | `MessageIDValidation` |
| `email.validator.no_rfc_warnings` | `Utility\NoRFCWarningsValidator` | `NoRFCWarningsValidation` |
| `email.validator.spoof_check` | `Utility\SpoofCheckValidator` | `SpoofCheckValidation` (needs `intl`) |
| `email.validator.multiple_with_and` | `Utility\MultipleValidationWithAndValidator` | `MultipleValidationWithAnd` |

`rfc` maps to core's own `EmailValidator` (RFCValidation) and is only meaningful inside
`multiple_with_and`.

## Calling a validator from custom code

```php
// Direct use of a specific validation, independent of the core swap:
$ok = \Drupal::service('email.validator.dns_check')->isValid('user@example.com');

// Or just call the (possibly swapped) core service:
$ok = \Drupal::service('email.validator')->isValid($email);
```

Do NOT pass a second argument to `isValid()` — evac's validators throw `BadMethodCallException`
if `$emailValidation` is supplied (per https://www.drupal.org/node/2997196).
