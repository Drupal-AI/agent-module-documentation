<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — general settings

Form `Drupal\oidc\Form\SettingsForm` at route **`oidc.admin.settings`** (`/admin/config/people/oidc`,
tab "General"). Edits the single config object **`oidc.settings`**. `getFormId()` = `oidc_settings_form`.

## Config keys (`oidc.settings`)

| Key | Type | Default (install) | Effect |
| --- | --- | --- | --- |
| `generic_realms` | sequence of ids | `[]` | Derivative ids of the configured generic realms. Managed by the Realms form, not this one. |
| `login_path` | path or null | `null` | If set, replaces the core `/user/login` page: anonymous hits on `user.login` are redirected here by `RequestSubscriber`. Can be an OIDC login path (`/oidc/login/<realm>`) or any internal path. `null` = keep default login. |
| `redirect_403` | bool | `true` | When TRUE, anonymous 403 (access-denied) responses are redirected to the login page (`AccessDeniedSubscriber`). |
| `disable_user_routes` | bool | `true` | When TRUE, `AlterUserRoutesSubscriber` sets `_access: 'FALSE'` on `user.register` and `user.pass`, and `oidc_form_user_admin_settings_alter` hides the related e-mail/registration settings. |
| `show_session_expired_message` | bool | `true` | When TRUE, a "session expired" warning is shown when the remote session ends (`RequestSubscriber::logout`); FALSE destroys the session silently. |

Note: even when `login_path` overrides the login page, the built-in page stays reachable at
`/user/login?local` (the `local` query flag is honored by `RequestSubscriber::setRedirectForRoute`).
Saving the form calls `router.builder->rebuild()` because the register/pass route access can change.

## Set via drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('oidc.settings');
$config
  ->set('login_path', '/oidc/login/generic:ab12cd34')  // or NULL for the default page
  ->set('redirect_403', TRUE)
  ->set('disable_user_routes', TRUE)
  ->set('show_session_expired_message', TRUE)
  ->save();
\Drupal::service('router.builder')->rebuild();
```

```bash
ddev drush config:set oidc.settings redirect_403 1 -y
ddev drush config:set oidc.settings login_path '/oidc/login/generic:ab12cd34' -y
```

## Runtime behavior traced
- `RequestSubscriber` (kernel REQUEST, prio 100) clears any stale login state on non-OIDC routes,
  redirects `user.login` → `login_path` for anonymous users (unless `?local`), redirects
  `user.logout` → `oidc.openid_connect.logout` for OIDC-authenticated users, and — when the session
  carries live tokens — refreshes an expired access token via the refresh token or logs the user out.
- `AccessDeniedSubscriber` (kernel EXCEPTION, prio 100) turns anonymous 403s into a login redirect
  when `redirect_403` is on.
- `OidcServiceProvider::alter()` forces `session.storage.options.cookie_lifetime = 0` (session cookie).
