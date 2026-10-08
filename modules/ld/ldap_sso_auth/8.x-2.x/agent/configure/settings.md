<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings form

One settings page, route `ldap_sso_auth.admin_form`, path `/admin/config/people/ldap/sso-auth`,
permission `administer site configuration`. Form class
`\Drupal\ldap_sso_auth\Form\LdapSsoAuthAdminForm` (`ldap_sso_auth_admin_form`), a `ConfigFormBase`
editing the single config object `ldap_sso_auth.settings`. It appears under the LDAP module's
config (menu parent `ldap.settings`; local task base route `entity.ldap_server.collection`).

## Config keys (`ldap_sso_auth.settings`)

| Key | Type | Default | Read at runtime? | Meaning |
|---|---|---|---|---|
| `ssoVariable` | string | `REMOTE_USER` | yes (`LdapSsoAuthAuthentication`, `LdapSsoAuthLoginName`) | Name of the `$_SERVER` entry that holds the pre-authenticated username. `LdapSsoAuthAdminForm::buildForm()` prints the current live value of `$_SERVER[ssoVariable]` (and of `REMOTE_USER`) under the field to help diagnose what the web server is setting. |
| `ssoSplitUserRealm` | boolean | `true` | yes | When set, a `user@realm` value is split into user + realm before lookup via `splitUserNameRealm()` (regex `^([A-Za-z0-9_\-\.]+)@([A-Za-z0-9_\-.]+)$`). The realm is captured but otherwise unused. |
| `ssoRemoteUserStripDomainName` | boolean | `false` | yes | When set, `stripDomainName()` removes a `@domain` suffix or `domain\` prefix before lookup (splits on `@` or `\`). |
| `ssoExcludedPaths` | sequence (string) | `{}` | yes | Newline-entered internal paths that the SSO provider ignores. `*` is a wildcard; `<front>` maps to the site front page. `/user/reset/*` is always appended in `checkExcludePath()`. |
| `ssoExcludedHosts` | sequence (string) | `{}` | yes | Hostnames (matched against `SERVER_NAME`) on which SSO is skipped — for multi-hostname sites. |
| `redirectOnLogout` | boolean | `true` | yes (`hook_user_logout`) | When set, redirect the user after logout to `logoutRedirectPath`. |
| `logoutRedirectPath` | string | `/user/login` | yes | Internal path used by the logout redirect. Validated with `Url::fromUserInput()` (internal only). |
| `seamlessLogin` | boolean | `false` | **no** | Form toggle labelled "Turn on automated single sign-on". Stored, but no runtime code reads it in 8.x-2.4 — the provider engages whenever the SSO variable is present regardless of this flag. |
| `cookieExpire` | boolean | `false` | **no** | Present only in config schema/install; neither the form nor any runtime code references it. |
| `enableLoginConfirmationMessage` | boolean | `true` | **no** | Form toggle; stored but not consulted by runtime code in this release (the standard core login message is produced by `user_login_finalize()`). |

## `validateForm()` behaviour (real checks)

- **Rejects SSO against incompatible LDAP servers.** It loads every enabled `ldap_server` entity and
  errors if any has `bind_method` of `user` or `anon_user`, because with SSO the user's password is
  never available for a per-user bind. Message names the server id and its formatted bind method.
- **Logout redirect path.** When `redirectOnLogout` is checked, `logoutRedirectPath` must be
  non-empty and must parse via `Url::fromUserInput()` (a `\InvalidArgumentException` becomes a form
  error). This keeps the logout redirect internal — an external URL is refused.

## `submitForm()`

Writes all nine form values back into `ldap_sso_auth.settings` and shows "The configuration options
have been saved." `ssoExcludedPaths` / `ssoExcludedHosts` are stored as arrays via
`explode(PHP_EOL, …)`.

## Notes an agent needs

- The excluded-path list is not just what the admin enters. `defaultPathsToExclude()` always
  excludes `/admin/config/search/clean-urls/check`, `/user/login/sso`, `/user/login`,
  `/user/logout`, `/user/password`, and `/user/reset/*` is appended in `checkExcludePath()`. SSO is
  never attempted on those paths.
- Enabling the internal Page Cache module is discouraged by the project README; the module ships a
  page-cache request policy to keep SSO-identified requests from being served cached pages
  (see api/authentication.md).
