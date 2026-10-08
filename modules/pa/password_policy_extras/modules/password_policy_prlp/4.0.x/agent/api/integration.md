# API — PRLP integration internals

Source: `src/Routing/RouteSubscriber.php`, `src/Controller/PasswordPolicyPrlpController.php`,
`src/EventSubscriber/PasswordPolicyPasswordResetLandingPageEventSubscriber.php`,
`password_policy_prlp.module`, `password_policy_prlp.services.yml`.

## Route override + session token handling

`RouteSubscriber::alterRoutes()` sets the `_controller` of `user.reset.form` to
`PasswordPolicyPrlpController::getResetPassForm`. That controller extends core `UserController` and:

- On an XHR (AJAX) request, reads `pass_reset_hash` / `pass_reset_timeout` from the POST and stores them
  in the session; otherwise reads them back from the session.
- Calls `parent::getResetPassForm()` and adds them as hidden form fields (`pass_reset_hash`,
  `pass_reset_timeout`).

This keeps the one-time-login token valid across the AJAX status-table refresh (which would otherwise
lose the hash/timeout that core passes only via the URL).

## Event subscriber

`PasswordPolicyPasswordResetLandingPageEventSubscriber extends PasswordPolicyExtrasEventSubscriber`,
constructed with config factory, current user, route match, request stack, date formatter, time,
`password_policy.validator`, entity type manager. Subscriptions:

| Event | Method (priority) | Behavior |
|---|---|---|
| `PasswordPolicyExtrasEvents::CHECK_VISIBILITY` | `skipVisibility` (900) | On `user.reset.form`, forces visibility params off and loads the target user's roles by `uid` route param |
| `PasswordPolicyExtrasEvents::CHECK_VALIDATION` | `skipValidation` (900) | Sets `verify_email_before_password`/`is_route_without_password` from PRLP's `password_required` setting; loads user roles by `uid` |
| `PrlpEvents::PASSWORD_VALIDATE` | `resetPasswordValidation` (800) | Validates the submitted `pass` against `password_policy.validator->validatePassword()`; on errors calls `$form_state->setErrorByName('pass2', …)` |
| `PrlpEvents::PASSWORD_BEFORE_SAVE` | `resetPasswordUpdate` (800) | Sets `field_last_password_reset` = now, `field_password_expiration` = `0`, `field_pending_expire_sent` = `0` on the user |

## Form alter

`hook_form_user_pass_reset_alter()` — when a user is loaded by `uid` and
`tableShouldBeVisible()` is true, attaches libraries and inserts
`_password_policy_extras_status_item($password, $user, $roles)` as `password_policy_status` (weight -1),
always visible (its `#states` are unset). Hook ordering forced after Password Policy via
`hook_module_implements_alter`.
