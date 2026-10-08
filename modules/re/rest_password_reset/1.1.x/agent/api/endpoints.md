<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST endpoints

Three `@RestResource` plugins in `src/Plugin/rest/resource/`. Access is governed by core REST:
each must be enabled and permissioned via **REST UI** (`restful get <id>` / `restful post <id>`),
plus the chosen authentication (typically `cookie`) and format (`json`). Responses are a JSON
object with a single `message` key. All GET responses call `setMaxAge(0)` (uncacheable).

## 1. Request a reset link — `ResetLink` (`rest_password_reset_link`)

- **GET** `canonical = /api/user/reset/{mail}`. `get(string $mail)`.
- Validates `{mail}` with `email.validator`; invalid → `400` `Please provide a valid email address.`
- Loads users by `mail` (`loadByProperties(['mail' => $mail])`). Whether or not a match exists,
  the success path returns `200` `If there is an active user, an email with the reset link was sent.`
  (uniform, non-revealing message).
- **Flood control:** state key `rest_password_reset.last_link.<uid>`; if a link was requested for
  this account less than `300` seconds ago, it logs a warning and sends nothing (still `200`).
- On send it calls `mail_manager->mail('rest_password_reset', 'reset_mail', ...)` with subject/body
  from config `rest_password_reset.password_reset` (`reset_mail_subject` / `reset_mail_body`), token-
  replaced for the loaded `user` and current langcode, then records the timestamp in state. A mail
  failure (`$mail['send'] && !$mail['result']`) → `500` `Could not send email, please try again.`
- The email body's `[rest_password_reset:login_link]` token expands to the frontend reset URL
  (see [../config/settings.md](../config/settings.md)).

## 2. Retrieve username — `Username` (`rest_password_reset_username`)

- **GET** `canonical = /api/user/username/{mail}`. `get(string $mail)`. Same structure as ResetLink.
- Invalid email → `500` (note: this resource returns 500, not 400, for an invalid address).
- Uniform success message `200` `If there is an active user for this email address, an email with
  the username was sent.`; own flood key `rest_password_reset.last_username.<uid>` (300s).
- Sends `username_mail` with `name_mail_subject` / `name_mail_body`; the body token
  `[user:account-name]` yields the username.

## 3. Set a new password — `PasswordReset` (`rest_password_reset_password`)

- **POST** `create = /api/user/reset/password`. `post(Request $request)`.
- Body is JSON: requires `uid` (numeric), `timestamp` (numeric), `hash` (string),
  `new_password` (string). Missing/wrong-typed → logs a warning and `500`
  `Invalid parameter set send!`.
- Loads the user by `uid`; not found → `500` `Unable to load user.`
- **Expiry:** compares `time->getRequestTime() - timestamp` against
  `user.settings:password_reset_timeout` (core default 86400s); exceeded → `404`
  `Your one-time login link has expired.`
- **Token check:** `hash_equals($hash, user_pass_rehash($user, $timestamp))` — timing-safe,
  using core's own reset-hash algorithm (bound to the account's password hash + last-login, so a
  link stops working once the password changes). Mismatch → `404` `Invalid reset code.`
- On success: `$user->setPassword($new_password)` + `$user->save()`; `200`
  `Your password has been reset, you can now login with your new password.` No password-policy
  enforcement is done here (delegated to core / any password-policy module).

## Typical frontend flow

1. `GET /api/user/reset/{mail}` → Drupal emails the link
   `{fe_uri}[/langcode]{suffix}{uid}/{timestamp}/{hash}` pointing at your frontend.
2. The frontend page reads `uid/timestamp/hash` from that URL and collects a new password.
3. `POST /api/user/reset/password` with `{uid, timestamp, hash, new_password}` → password saved.
