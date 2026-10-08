# API — events, decorated manager & form helpers

Source: `src/PasswordPolicyExtrasEvents.php`, `src/Event/*.php`,
`src/EventSubscriber/PasswordPolicyExtrasEventSubscriber.php`,
`src/PasswordPolicyExtrasValidationManager.php`, `password_policy_extras.module`,
`password_policy_extras.services.yml`.

## Decorated validation manager

`password_policy.validation_manager` is overridden (in this module's `services.yml`) with
`PasswordPolicyExtrasValidationManager extends PasswordPolicyValidationManager`. It adds an event
dispatcher and reimplements:

- `tableShouldBeVisible()` — dispatches `CHECK_VISIBILITY`, then returns FALSE for anonymous users when
  `verify_email_before_password` and `is_route_without_password` params are true; otherwise TRUE if any
  password policy targeting the current user's roles has `show_policy_table = TRUE`.
- `validationShouldRun()` — dispatches `CHECK_VALIDATION`, same anonymous short-circuit, then TRUE if any
  policy targets the user's roles.

## The two events

`Drupal\password_policy_extras\PasswordPolicyExtrasEvents`:

| Constant | Event name | Dispatched by |
|---|---|---|
| `CHECK_VISIBILITY` | `password_policy_extras.skip_visibility` | `tableShouldBeVisible()` |
| `CHECK_VALIDATION` | `password_policy_extras.skip_validation` | `validationShouldRun()` |

Both carry a `CheckEvent` (`CheckVisibilityEvent` / `CheckValidationEvent`) whose `&getParameters()`
returns a **by-reference** array a subscriber populates with:
`verify_email_before_password` (bool), `is_route_without_password` (bool), `user_roles` (array).

Subscribe to influence visibility/validation for a specific route or integration:

```php
public static function getSubscribedEvents(): array {
  return [
    PasswordPolicyExtrasEvents::CHECK_VISIBILITY => [['mySkipVisibility', 900]],
    PasswordPolicyExtrasEvents::CHECK_VALIDATION => [['mySkipValidation', 900]],
  ];
}
public function mySkipVisibility(CheckVisibilityEvent $event): void {
  $params = &$event->getParameters();
  $params['user_roles'] = [...];              // roles to match policies against
  $params['verify_email_before_password'] = FALSE;
  $params['is_route_without_password'] = FALSE;
}
```

The built-in `PasswordPolicyExtrasEventSubscriber` (priority 1000) sets the defaults from
`user.settings:verify_mail`, the `user.reset` route check, and `currentUser->getRoles()`. The three
submodules subscribe at priority 900 to override for their forms.

## Reusable form helper functions (global, in `.module`)

- `_password_policy_extras_add_libraries_and_settings_to_form(&$form)` — attaches the JS libraries and
  `drupalSettings` (refresh delay, display options, failed-only/hide-suggestions libraries). Call from a
  `hook_form_FORM_ID_alter` when adding policy feedback to a custom password form.
- `_password_policy_extras_status_item($password, $user, $roles): array` — returns the render array for
  the `#theme => 'password_policy_status'` table (id `password-policy-status`), used by the PRLP
  submodule to inject the table into non-standard forms.
