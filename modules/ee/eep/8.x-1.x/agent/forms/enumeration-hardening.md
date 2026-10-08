<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eep — how the register and password-reset forms are normalized

Wiring: `eep_entity_type_alter()` (in `eep.module`) uses `\Drupal::classResolver(EepManager::class)` to
read the enable flags and, when set, replaces the `user` entity's `register` form handler with
`Form\RegisterForm` and its `reset_password` handler with `Form\UserPasswordForm`. Additionally
`EventSubscriber\EepRouteSubscriber::alterRoutes()` sets the `user.pass` route's `_form` default to
`Form\UserPasswordForm` when `isPasswordResetEnabled()` is true (subscribed to `RoutingEvents::ALTER`,
priority -1000).

## Registration — `Form\RegisterForm` (extends core `user\RegisterForm`)

- `flagViolations()`: when the current user lacks `access user profiles`, it iterates violations on the
  `mail` and `name` fields and, for any `UniqueFieldConstraint`, calls `$violations->remove($offset)` and
  sets `$form_state` value `eep_event_occour = TRUE`. This drops the core "email/username already taken"
  validation error so submission does not fail visibly.
- `buildEntity()`: if `eep_event_occour` is set it does not build a new user; it loads the existing user by
  the submitted `mail` (`loadByProperties(['mail' => $mail])`) and returns it.
- `save()`: if `eep_event_occour` is set it skips `parent::save()` (no account is created), calls
  `EepManager::sendCustomResetMail($this->entity)`, then adds the **same** status message core would show
  for a normal registration — either the admin-approval variant (when `user.settings` `register` is
  `REGISTER_VISITORS_ADMINISTRATIVE_APPROVAL`) or "A welcome message with further instructions has been
  sent to your email address." — and redirects to `<front>`. To an outsider the response is identical to a
  fresh registration.

## Duplicate-email notification — `EepManager::sendCustomResetMail()`

Builds `subject`/`message` params by running `subject_user_register` and `email_user_register` through the
`token` service (`Token::replace(...)` with `['user' => $user]`, `callback` `user_mail_tokens`,
`clear => TRUE`, current langcode) and sends via `mailManager->mail('eep', 'eep_reset_password', <user
mail>, ...)`. `eep_mail()` (`hook_mail`) fills the message: `from` = `system.site` mail, subject/body from
the params.

## Password reset — `Form\UserPasswordForm` (extends core `user\Form\UserPasswordForm`)

- `validateForm()`: enforces core's IP flood limit (`user.password_request_ip`) first, then loads the
  account by mail and falls back to name. If an active account is found it applies the per-user flood limit
  (`user.password_request_user`) and stores the account in `$form_state` value `account`. Crucially it
  **never calls `setErrorByName()` for a missing/blocked account**, so no "not recognized" error is emitted.
- `submitForm()`: if `account` is set it sends the standard reset mail via `_user_mail_notify('password_reset',
  ...)` and logs it; otherwise it logs "Password reset requesto from non existing email". In **both** cases
  it shows `eep.settings` `message_password_reset` via `messenger()->addStatus()` and redirects to
  `user.page` — one uniform outcome for known and unknown identities.

## Not covered

- Only the two account forms above are altered. The `user.login`, JSON:API/REST user-collection, and other
  account-touching endpoints are unchanged and follow core behavior.
- `src/Controller/EepController.php` (extends `UserController`, overrides `getResetPassForm()`) is present
  but unreferenced by any route and points at a non-existent `Form\UserPasswordResetForm`; it is not part
  of the active flow.
