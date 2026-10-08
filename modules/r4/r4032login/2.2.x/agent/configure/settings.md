# Configure r4032login

All behavior is stored in the **`r4032login.settings`** config object (schema in
`config/schema/r4032login.schema.yml`). Edit via three tabbed forms or with
`drush cset r4032login.settings <key> <value>`. It exports/deploys as configuration.

## Routes (permission: `administer r4032login`)

| Route | Path | Form |
|---|---|---|
| `r4032login.settings.form` | `/admin/config/system/r4032login/settings` | General (`SettingsForm`) |
| `r4032login.anonymous_settings.form` | `/admin/config/system/r4032login/settings/anonymous` | Anonymous behavior (`AnonymousSettingsForm`) |
| `r4032login.authenticated_settings.form` | `/admin/config/system/r4032login/settings/authenticated` | Authenticated behavior (`AuthenticatedSettingsForm`) |

`configure` route = `r4032login.settings.form`. Menu link parent is `system.admin_config_system`.

## Settings keys — `r4032login.settings`

Defaults shown are from `config/install/r4032login.settings.yml`.

| Key | Default | Meaning |
|---|---|---|
| `user_login_path` | `/user/login` | Where anonymous users are redirected on 403 (include leading slash; may be external). |
| `redirect_to_destination` | `true` | Append the originally-requested page so the user returns there after login. |
| `destination_parameter_override` | `''` | Query param name to carry the return path (blank = Drupal's `destination`); set for CAS/Shibboleth/OAuth. |
| `display_denied_message` | `true` | Show an access-denied message to anonymous users on the login page. |
| `access_denied_message` | `Access denied. You must log in to view this page.` | The anonymous message text (filtered with `Xss::filterAdmin`). |
| `access_denied_message_type` | `error` | Message type for anonymous users: `error`, `warning`, or `status`. |
| `redirect_authenticated_users_to` | `''` | Redirect authenticated (already logged-in) users lacking access to this page; `<front>` allowed; blank = default access-denied page. |
| `throw_authenticated_404` | `false` | Instead throw a 404 to authenticated users (cancels `redirect_authenticated_users_to`). |
| `display_auth_denied_message` | `true` | Show an access-denied message to authenticated users on their landing page. |
| `access_denied_auth_message` | `Access denied. Check with your site administrator if you need assistance.` | The authenticated message text. |
| `access_denied_auth_message_type` | `error` | Message type for authenticated users: `error`, `warning`, `status`. |
| `default_redirect_code` | `307` | Redirect HTTP status: `307` (default), `302`, or `301`. 301/302 may be cached, so 307 is usually correct. |
| `add_noindex_header` | `false` | Add `X-Robots-Tag: noindex` to the redirect response. |
| `match_noredirect_pages` | `''` | Path patterns (one per line, `*` wildcard, `<front>`) to skip the redirect for. |
| `match_noredirect_negate` | `0` | `0` = skip redirect for listed pages; `1` = only redirect for listed pages. |
| `langcode` | `en` | Config language code. |

## How they combine (from `R4032LoginSubscriber::on403`)

- Only `html` requests are handled; the subscriber extends `HttpExceptionSubscriberBase`.
- If `match_noredirect_pages` matches (respecting `match_noredirect_negate`), no redirect happens.
- Anonymous users → redirect to `user_login_path`. Authenticated users → `redirect_authenticated_users_to`, unless `throw_authenticated_404` is set (then a `CacheableNotFoundHttpException`).
- When `redirect_to_destination` is on, the requested path is added as the `destination` (or `destination_parameter_override`) query param; for authenticated users the destination is stripped to avoid loops.
- Response is a `TrustedRedirectResponse` (external target) or `CacheableRedirectResponse` (internal), using `default_redirect_code` and any `add_noindex_header`.

## Permission

`administer r4032login` (in `r4032login.permissions.yml`) — "Allows a user to configure r4032login." Gates all three settings forms.

```
drush role:perm:add site_admin 'administer r4032login'
drush cset r4032login.settings default_redirect_code 302
```
