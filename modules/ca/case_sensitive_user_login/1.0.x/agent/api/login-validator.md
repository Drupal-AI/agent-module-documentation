<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login case-sensitivity validator

All logic lives in `case_sensitive_user_login.module` (no classes, services, or config).

## Hook

`case_sensitive_user_login_form_user_login_form_alter(&$form, FormStateInterface $form_state, $form_id)`
appends one handler to the form's validate array:

```php
$form['#validate'][] = 'case_sensitive_user_login_user_login_form_validate';
```

Because it is **appended**, it runs *after* core's `UserLoginForm` validators
(`validateName`, `validateAuthentication`, `validateFinal`). It does not remove or replace any core
validator, so core's flood control and password verification are untouched.

## Validate handler

`case_sensitive_user_login_user_login_form_validate(&$form, FormStateInterface $form_state)`:

1. Reads the submitted username: `$username = $form_state->getValue('name');`
2. Runs a parameterized DB API query (no string concatenation):

   ```php
   $connection->select('users_field_data', 'u')
     ->fields('u', ['uid'])
     ->condition('u.name', $username, '=')
     ->execute()->fetchField();
   ```

3. If no `uid` is returned, it calls `$form_state->setErrorByName('name', ...)` with the generic
   message `Unrecognized username or password. <a href=":password">Forgot your password?</a>`.

The handler only ever **adds** a validation error; it never sets `uid`, never authenticates, and
never clears core errors. Net effect: an attempt whose username has no case-exact row is rejected in
addition to whatever core already decided.

## Behavior and limitations

- **Case enforcement is collation-dependent.** The `=` condition resolves at the database level, so
  on a case-insensitive collation (typical MySQL default, e.g. `utf8mb4_general_ci`) `name = 'Admin'`
  still matches the row `admin` and the handler adds no error — the module is effectively a no-op.
  Real enforcement requires a case-sensitive/binary collation on `users_field_data.name`.
- **No config surface:** nothing in `config/install`, no schema, no settings route, no permissions.
- **Scope:** only the interactive `user_login_form`. Registration, password reset, and programmatic
  authentication (`user_login_finalize`, external auth) are unaffected.
- **Uninstall** restores stock behavior since the module only adds a runtime validate handler.
