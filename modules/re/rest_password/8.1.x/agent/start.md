# rest password — agent index

Exposes Drupal's forgotten-password flow over REST for decoupled sites. Depends on core `rest`. No
own permissions (uses core `administer users` for the admin resend action), no Drush, no config
schema dir (it alters `user.mail` / `user.settings` schema via hook).

- **The endpoints (`/user/lost-password`, `/user/lost-password-reset`, modified `/user/login`),
  request/response shapes, the temp-password flow** → [api/rest.md](api/rest.md)
- **Enabling the REST resources, the route-subscriber effects, mail template + token-length config,
  custom tokens, the admin resend action** → [configure/setup.md](configure/setup.md)
- **`PasswordResetEvent` (PRE/POST reset)** → [hooks/events.md](hooks/events.md)

Key facts:
- REST resources: `lost_password_resource` → `POST /user/lost-password`; `lost_password_reset` →
  `POST /user/lost-password-reset`. Enable via REST UI / `rest.resource.*` config.
- `RestPasswordRouteSubscriber` strips `_permission`, `_csrf_request_header_token` and `_auth` from
  both POST routes (so anonymous can call them) and repoints `user.login.http` to
  `UserAuthenticationTempPassController::login` (accepts the temp password as `pass`).
- Temp password: `Crypt::randomBytesBase64(token_length)`, `token_length` =
  `user.mail.password_reset_rest.token` (default 10 bytes ≈ 80 bits); stored in the `rest_password`
  shared tempstore keyed by uid; compared with `hash_equals`; deleted on successful reset (but not
  on temp-password login).
- Admin action: route `rest_password.user.resend` = `/user/{user}/reset_password_mail`,
  permission `administer users`.
- Mail config lives under `user.mail.password_reset_rest.{subject,body,token}`; notify flag
  `user.settings.notify.password_reset_rest`. Installed defaults set in `rest_password_install()`.

Security note (reviewed, not a finding): endpoints are intentionally unauthenticated (a lost-password
flow must be), but the reset/login paths require the emailed 80-bit temp token (`hash_equals`,
active-account checks, flood control on `/user/login`) — no arbitrary-user takeover, and a new
password cannot be set without the token. Add rate limiting as with core `/user/password`.
