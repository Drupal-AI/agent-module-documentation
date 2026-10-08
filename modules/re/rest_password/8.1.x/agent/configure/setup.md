# Setup & configuration

No dedicated settings page (`configure` is null). Setup = enable the REST resources and (optionally)
edit the mail. Mail config is added to the core **Account settings** page.

## Enable the REST resources

The two resources are standard `@RestResource` plugins; enable them like any other (REST UI is the
easy path):

- `lost_password_resource` → `POST /user/lost-password`
- `lost_password_reset` → `POST /user/lost-password-reset`

In REST UI, set method POST and format `json`; the module's `hook_form_alter` replaces the
authentication selector with a dummy "Na" option (REST UI requires one) and shows inline how-to
help. **Clear caches after saving** (the module's help text stresses this) so the route alteration
applies. Config lands in `rest.resource.lost_password_resource` / `rest.resource.lost_password_reset`.

## What the route subscriber does (important)

`RestPasswordRouteSubscriber::alterRoutes()` mutates the generated routes:

- On `rest.lost_password_resource.POST` and `rest.lost_password_reset.POST`: removes
  `_csrf_request_header_token`, `_permission`, and the `_auth` option — making both endpoints
  **anonymous and CSRF-exempt** (a lost-password flow can't require an existing session; the reset
  path is instead gated by the emailed temp token — see [../api/rest.md](../api/rest.md)).
- On core `user.login.http`: swaps the controller to
  `UserAuthenticationTempPassController::login` so `/user/login?_format=json` also accepts the temp
  password.

Because these are unauthenticated, put rate limiting / WAF in front of them exactly as you would for
core `/user/password` (the module ships none).

## Mail configuration

Installed by `rest_password_install()` into `user.mail.password_reset_rest`:

| Key | Default | Meaning |
|---|---|---|
| `subject` | "Replacement login information for [user:display-name]" | email subject |
| `body` | temp-password body incl. `[user:rest-temp-password]` | email body (7-day expiry text is cosmetic) |
| `token` | *(unset → code default 10)* | **byte length** passed to `Crypt::randomBytesBase64` — the temp-password entropy |

Also sets `user.settings.notify.password_reset_rest = TRUE` (the mail is only sent when this notify
flag is on). Edit all three on **Account settings** (`/admin/config/people/accounts`) — the module's
`hook_form_alter` adds a "Rest Password recovery" section (Subject / Token length / Body) there when
the config exists.

### Custom mail tokens

Registered in `rest_password_mail_tokens()` for use in the body/subject:

- `[user:rest-temp-password]` — the generated temp password (also creates+stores it).
- `[user:one-time-login-url]`, `[user:cancel-url]` — core-style URLs.
- `[user:mail-url-encode]` — urlencoded email.
- `[user:name-url-encode]` — urlencoded username.
- `[user:name-url-encode-spaces]` — username with spaces as `%20`.

## Admin "Send reset password email" action

`rest_password_entity_operation_alter()` adds a **Send reset password email** operation to each user
row, linking to route `rest_password.user.resend` = `/user/{user}/reset_password_mail`, permission
**`administer users`**. It calls `_rest_password_user_mail_notify('password_reset_rest', $user)` and
redirects back. This is the only route the module itself gates by permission.

## Uninstall

`rest_password_uninstall()` deletes `rest.resource.lost_password_resource` config.
