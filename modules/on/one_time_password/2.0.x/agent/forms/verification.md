<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enrolment & OTP verification / login flows

Sources: `src/Form/PasswordSetupForm.php`, `src/UserLoginEnforce.php`, `src/Form/EntryForm.php`,
`src/EventSubscriber/OneTimeLoginEventSubscriber.php`, `src/Controller/UserAuthenticationController.php`,
`src/EventSubscriber/RouteSubscriber.php`, `src/OtpLoginTrait.php`, `one_time_password.routing.yml`.

## 1. Enrolment — `PasswordSetupForm`

Route `one_time_password.setup_form` → `/user/{user}/two-factor-auth`, requirement
`_entity_access: 'user.update'` (`_admin_route: TRUE`). Also exposed as a local task tab on the user
canonical page (`one_time_password.links.task.yml`).

- If the target user's `one_time_password` field is **empty**: shows enable instructions
  (`one_time_password_enable_instructions` theme) and an *Enable Two-Factor Authentication* submit whose
  handler `enableTwoFactorAuth()` calls `$user->one_time_password->regenerateOneTimePassword()` then
  `$user->save()`.
- If **set**: renders the QR code (a `data:` PNG from `endroid/qr-code` `PngWriter`, size 200, of the
  provisioning URI), setup instructions (`one_time_password_setup_instructions`), and a *Disable
  Two-Factor Authentication* danger button whose handler `disableTwoFactorAuth()` sets
  `$user->one_time_password = []` and saves.
- `$form['#cache']['max-age'] = 0`. Standard Drupal form → CSRF token present.

Because access is `user.update` entity access, a user manages their **own** 2FA, and any user who can edit
another account (e.g. holds *Administer users*) can enable/disable/reset 2FA on that account. There is no
step that requires the target user to prove possession of the code before it becomes active — enabling
immediately arms 2FA for the next login.

## 2. Standard login form — `UserLoginEnforce`

`hook_form_user_login_form_alter` adds a `one_time_password` textfield (size/maxlength 6) and appends
`UserLoginEnforce::validateOneTimePassword` to `$form['#validate']`. That callback runs **after** core's
authentication validator has set `$form_state->get('uid')`:

1. No uid (password failed) → return; core stops the login.
2. Load user; if `one_time_password` field empty → return (user hasn't opted in).
3. Flood check: `isAllowed(FLOOD_NAME_UID, 5, 3600, $uid)` **and** `isAllowed(FLOOD_NAME_IP, 5, 3600, $ip)`.
   If either is exhausted → error "too many incorrect one time passwords", stop (no verify attempted).
4. Load `OTPHP\TOTP` via `$user->one_time_password->getOneTimePassword()`. Read replay bound
   `one_time_password_totp_time_window` from `user.data` (default 1). With `$leeway = 10` and
   `$now = one_time_password.clock->now()`, reject when: code empty, **or** `now - 10 <= last_window`
   (replay/overlap), **or** `TOTP::verify($code, NULL, 10)` fails. On reject → error + `flood->register`
   both keys. On success → store `now + $one_time_pass->expiresIn()` as the new replay bound.

Failed guesses only register a flood entry when under the threshold, so a blocked user's continued
attempts don't extend their own lockout.

## 3. One-time-login (password reset) link — `OneTimeLoginEventSubscriber`

Runs on `KernelEvents::REQUEST` priority 31, only for route `user.reset.login`. For a user who **has** a
secret and is active:

1. Validates timeout and `hash_equals($hash, user_pass_rehash($user, $timestamp))` — same checks core
   uses; failure redirects to `user.pass`.
2. `sessionManager->regenerate()` — CWE-384 session-fixation protection.
3. Generates `Crypt::randomBytesBase64(55)` token into session `pass_reset_{uid}`.
4. Stores `otp-entry-uid = uid` in the `one_time_password` **private tempstore**.
5. Redirects to `one_time_password.entry` `/otp/{uid}/{hash}` where `hash` = `getLoginHash($user)`
   (`OtpLoginTrait`: `Crypt::hmacBase64(name:passwordHash:lastLogin, private_key . hash_salt)`), with query
   `pass-reset-token`.

So a valid reset link for a TFA user does **not** log them in directly; it hands off to the OTP entry form.

## 4. OTP entry form — `EntryForm`

Route `one_time_password.entry` `/otp/{uid}/{hash}`, `_user_is_logged_in: 'FALSE'`, `no_cache`,
`_maintenance_access: TRUE`, custom access `EntryForm::checkAccess`.

`checkAccess` (defense in depth against enumeration/forging):
- tempstore `one_time_password:otp-entry-uid` must exist, be numeric, and equal the route `uid`
  (otherwise "Invalid session.").
- user must load ("Invalid user."), must have a secret ("User does not have TFA enabled.").
- `getLoginHash($user)` must equal the route `hash` param ("Invalid hash value.").

The form reuses the **same** `validateOneTimePassword` logic (flood + replay + `TOTP::verify`) as the login
form. `submitForm` loads the user and calls `user_login_finalize($account)` — reached only if validation
added no error, so a wrong/absent OTP cannot finalize login. Honors an existing `destination`.

## 5. REST login — `UserAuthenticationController`

`RouteSubscriber::alterRoutes` re-points `user.login.http` `_controller` to
`Drupal\one_time_password\Controller\UserAuthenticationController::login` (extends core's controller).
Behavior: look up account by name; if it has **no** secret → delegate to `parent::login()` (normal REST
login). If it has a secret, require an `X-OTP` request header, then run the same window/replay/verify
checks before delegating to `parent::login()`; missing/invalid code → `BadRequestHttpException` with the
generic message `Sorry, unrecognized username or password.` On a 200 response it advances the replay
window in `user.data`.
