rest_password exposes Drupal's forgotten-password flow over REST for headless/decoupled sites: an anonymous client POSTs an email to get a temporary password mailed to them, then either sets a new password with that temp password or logs in directly with it via the JSON login endpoint.

---

The module adds two REST resource plugins — `lost_password_resource` (`POST /user/lost-password`) and
`lost_password_reset` (`POST /user/lost-password-reset`) — which you enable like any REST resource
(e.g. with REST UI). A route subscriber then **removes** the `_permission`, `_csrf_request_header_token`
and `_auth` requirements from those two POST routes so anonymous clients can call them, and rewrites
core's `user.login.http` (`/user/login?_format=json`) controller to also accept the temporary password.
`POST /user/lost-password` with `{"mail": …}` (optional `lang`) looks the account up by email and, if it
is active, generates a random temp password (`Crypt::randomBytesBase64`, length = `user.mail.password_reset_rest.token`,
default 10 bytes ≈ 80 bits), stores it in the `rest_password` shared tempstore keyed by the user id, and
emails it via the `password_reset_rest` mail (custom tokens like `[user:rest-temp-password]`,
`[user:mail-url-encode]`, `[user:name-url-encode]`). The response is always the same generic
"Further instructions have been sent" message so account existence is not disclosed. The temp password is
delivered only to the account's registered email. `POST /user/lost-password-reset` with
`{"name": …, "temp_pass": …, "new_pass": …}` reloads the user, compares the supplied temp password to the
stored one with `hash_equals`, and only then sets the new password (dispatching `PasswordResetEvent`
PRE/POST) and deletes the temp password. Alternatively, `POST /user/login` with the username and the temp
password as `pass` logs the user in directly (subject to core flood control); that path does not delete the
temp password. An admin (permission `administer users`) also gets a "Send reset password email" operation
on each user via `/user/{user}/reset_password_mail`. Mail subject/body/token-length are editable on the
Account settings page. The reset endpoint properly requires the emailed token — there is no arbitrary-user
takeover — but the endpoints are intentionally unauthenticated, so front them with rate limiting as you
would core's `/user/password`.

---

- Add a "forgot password" flow to a headless/decoupled (React/Vue/mobile) front end.
- Let an anonymous user request a password reset by POSTing their email to `/user/lost-password`.
- Email a temporary password to the user instead of a one-time login link.
- Let the client set a brand-new password with the temp password via `/user/lost-password-reset`.
- Let the user log in directly with the temporary password through `/user/login?_format=json`.
- Avoid disclosing whether an email is registered (uniform success response).
- Localise the reset email by passing a `lang` value in the lost-password request.
- Customise the reset email subject and body on the Account settings page.
- Insert the temp password into the email with the `[user:rest-temp-password]` token.
- Build a password-reset deep link using `[user:mail-url-encode]` / `[user:name-url-encode]` tokens.
- Set the temp-password length (entropy) via the "Token length" setting.
- Give admins a one-click "Send reset password email" action on the user list.
- React to a completed reset by subscribing to `PasswordResetEvent` (PRE/POST reset).
- Integrate password recovery into a Drupal-backed mobile app.
- Keep the reset flow behind the same email delivery/config as the rest of the site.
- Trigger a reset mail programmatically via `_rest_password_user_mail_notify('password_reset_rest', $account)`.
- Provide a decoupled account-recovery UX without exposing the Drupal login forms.
- Enforce active-account-only resets (blocked users get the generic response and cannot reset).
