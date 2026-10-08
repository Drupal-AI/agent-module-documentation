<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confirmation flow, token, mail & REST

## Confirmation URL & token

- Token **`[user:registrationpassword-url]`** (defined in `user_registrationpassword.tokens.inc`,
  `restricted` = TRUE) → `user_registrationpassword_confirmation_url($account)`.
- It builds an absolute one-time URL for route **`user_registrationpassword.confirm`**, path
  `user/registrationpassword/{uid}/{timestamp}/{hash}`, where `hash = user_pass_rehash($account,
  $timestamp)` — the same rehash core uses for one-time login links.
- The route's controller `RegistrationController::confirmAccount()` validates the hash/timestamp and
  logs the user in (respecting `registration_ftll_expire` / `registration_ftll_timeout`).

## The mail

- `hook_mail()` key `register_confirmation_with_pass` renders subject/body from
  `user_registrationpassword.mail`, running tokens through `user_registrationpassword_mail_tokens()`
  (which adds the registrationpassword-url token on top of core `user_mail_tokens`).
- `_user_registrationpassword_mail_notify($op, $account, $langcode = NULL)` sends it, gated by
  `user_registrationpassword.settings:notify.<op>`.

## Registration form alterations

`hook_form_user_register_form_alter()`:
- In "Visitors, administrator approval required" + `with-pass`: adds a required `password_confirm`
  field and a submit handler that saves the chosen password.
- In "Visitors, no approval required" + `with-pass`: forces the new account blocked + no core
  notification, suppresses the core "pending approval" status message, and sends the module's
  confirmation email instead.

## Password-reset resend

`hook_form_user_pass_alter()` swaps the reset form's validate/submit handlers so that a
never-logged-in, blocked account (status 0, `login` 0, `access` 0) gets the activation email resent
instead of a normal reset — letting users re-trigger confirmation after a link expires.

## REST resource (headless registration)

`\Drupal\user_registrationpassword\Plugin\rest\resource\RegistrationPasswordResource`
(`@RestResource id = "user_registrationpassword"`), `create` URI **`/user/registerpass`**,
serialization class `Drupal\user\Entity\User`. Enable it like any REST resource (e.g. via the REST
UI / `rest.resource.*` config) to accept POSTed user registrations that follow the same
password-on-registration + activation-mail flow.
