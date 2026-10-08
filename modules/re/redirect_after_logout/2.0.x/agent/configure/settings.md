# Configure — Redirect After Logout

## Config object: `redirect_after_logout.settings`

| Key | Type | Meaning |
|---|---|---|
| `destination` | path/string | Where to send the user after logout. Required in the form. |
| `message` | text | Optional one-time message shown after logout (tokens allowed, newlines → `<br>`). |
| `message_type` | string | Messenger type: `status`, `warning`, or `error`. |

Defaults (`config/install`) are all empty strings. Set via the UI, `drush cset`, or a
`settings.php` override (`$config['redirect_after_logout.settings']['destination'] = …`).

## Settings form

- Route `redirect_after_logout.settings` → `admin/config/system/redirect_after_logout`.
- Access: core permission **`administer site configuration`** (`restrict access: true`).
- Menu link under *Administration → Configuration → User interface*.
- `destination` accepts:
  - `<front>` — the site front page.
  - an internal path with a leading slash, e.g. `/node/1`.
  - a fully external URL, e.g. `http://example.com/` (off-site redirect is a supported feature).
  - a token, e.g. `[current-page:url]` (a leading `/` before a `[token]` is stripped).
- Validation (`RedirectLogoutSettings::validateForm`): token-replaces the value, calls
  `UrlHelper::stripDangerousProtocols`, requires internal paths to start with `/`, and checks
  validity/access via `PathValidator` (internal) or `UrlHelper::isValid` (external).
- Token help fieldset appears only when the `token` module is enabled.

## Permission that selects who is redirected

`redirect user after logout` (in `redirect_after_logout.permissions.yml`, not
`restrict access`). Only accounts holding it are redirected on logout — assign it to the
roles that should be sent to the destination.

## Runtime flow (for reference)

1. `hook_user_logout()` (`redirect_after_logout.module`): if the account has
   `redirect user after logout` (and it is **not** a Masquerade session), token-replaces
   `destination` and stores it in a `drupal_static`.
2. `RedirectAfterLogoutSubscriber::checkRedirection` (KernelEvents::RESPONSE): if the logout
   produced a `RedirectResponse` and a destination is stashed, builds a `Url`
   (`<front>` / external / `internal:`) and sends a new `RedirectResponse` to it. If a
   `message` is set and the target is local, appends `?logout-message=1`.
3. `RedirectAfterLogoutSubscriber::showMessage` (KernelEvents::REQUEST): when
   `logout-message=1` and the visitor is now anonymous, renders the message token-replaced
   and `Xss::filter`ed to allow only `<br>`, using `message_type`.

No Drush commands; no plugins.
