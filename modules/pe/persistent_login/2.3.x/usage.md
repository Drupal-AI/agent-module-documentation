<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Persistent Login adds a "Remember me" checkbox to the Drupal login form and keeps those users signed in with its own long-lived, single-use cookie token — independently of the PHP session lifetime.

---

Ticking the box makes `persistent_login_user_login_form_submit()` call `TokenHandler::setNewSessionToken()`, which inserts a row into the module's own `persistent_login` table (uid, series, instance, created, refreshed, expires) and sets a cookie. The design is the classic *series + instance* scheme: the series identifies the login, the instance is single-use and rotated on every use, so a stolen-and-replayed cookie invalidates the series. Both values are stored **hashed** (`Crypt::hashBase64`, added by update 8106). `TokenHandler` is registered as a global `authentication_provider` with priority 1 — higher than `user.authentication.cookie` — so a returning visitor whose PHP session has expired is logged back in from the cookie; a `page_cache_request_policy` service (`PendingPersistentLogin`) makes sure such requests are not served from the internal page cache. Settings live in `persistent_login.settings` and are edited at `/admin/config/system/persistent_login` (`administer site configuration`): `lifetime` in days (0 = never expires), `extend_lifetime` (renew from last use instead of from creation), `max_tokens` per user (0 = unlimited), `login_form.field_label` (the checkbox text, translatable via config translation) and `cookie_prefix` (validated, `S`-prefixed on HTTPS, must not be `SESS`). Users can review their own persistent logins at `/user/{uid}/persistent-logins`, and the user edit form gains a "Logout all other devices" checkbox that clears the stored tokens when the password is changed. Tokens are also cleared on logout, on user cancel/delete, and expired rows are purged by `hook_cron()`. `hook_requirements()` raises an error unless `session.storage.options.cookie_lifetime` is `0` in `services.yml`.

---

- Add a familiar "Remember me" checkbox to `/user/login`.
- Keep editors signed in for 30 days without lengthening the PHP session cookie for everyone.
- Keep visitors logged in indefinitely by setting the lifetime to 0.
- Renew the remembered login on every visit by enabling "Extend lifetime when used".
- Limit each account to a fixed number of remembered devices with `max_tokens`.
- Force a single remembered device per user (`max_tokens: 1`).
- Reword the checkbox to "Stay signed in" or "Keep me logged in".
- Translate the checkbox label per language through config translation.
- Let a user see when each of their remembered logins was created and last used.
- Let a user log out all other devices by changing their password.
- Let an administrator clear another account's remembered logins from the user edit form.
- Revoke every remembered login site-wide by changing the cookie prefix.
- Avoid a cookie-name collision with another app on the same domain via `cookie_prefix`.
- Automatically drop all tokens when an account is cancelled or deleted.
- Purge expired tokens on cron instead of letting the table grow.
- Detect cookie theft: reusing an old instance invalidates the whole series.
- Keep the remembered-login cookie out of Varnish/reverse-proxy caching decisions.
- Satisfy a security review that forbids long PHP session lifetimes.
- Support a kiosk/shared-machine policy by leaving the box unticked by default.
- Reduce login friction on a members' site without weakening session security.
- Audit remembered logins per user before an account review.
- Programmatically issue a remembered login for a user via `persistent_login.token_manager`.
- Clear one user's tokens from code with `TokenManager::clearUsersTokens()`.
- Verify configuration health on the status report (session cookie lifetime must be 0).
- Migrate from a bespoke "keep me logged in" hack to a maintained implementation.
