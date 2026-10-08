<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure LDAP SSO

Settings form `LdapSsoAdminForm` at route **`ldap_sso.admin_form`** →
`/admin/config/people/ldap/sso` (also a local task under the LDAP servers collection, requires core
permission `administer site configuration`). It edits the single config object **`ldap_sso.settings`**
(schema `config/schema/ldap_sso.schema.yml`, defaults in `config/install/ldap_sso.settings.yml`).

The bulk of the work is in the web server: NTLM/Kerberos (or Basic) auth must be configured to set
the chosen server variable — at minimum for the path `/user/login/sso`. See the module README for an
Apache `mod_auth_sspi` example.

## Config keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `seamlessLogin` | bool | `false` | Turn on *automated* SSO. When on, an anonymous request is redirected to `/user/login/sso` by the boot subscriber (see events/sso.md). When off, SSO only happens when a user visits `/user/login/sso` directly. |
| `ssoVariable` | string | `REMOTE_USER` | Name of the `$_SERVER[...]` entry the web server populates with the authenticated user. Commonly `REMOTE_USER` or `REDIRECT_REMOTE_USER`. |
| `ssoSplitUserRealm` | bool | `true` | If the identity arrives as `user@realm`, split on `@` and keep `user` (realm kept aside, unused). Default for `mod_auth_kerb`, not `mod_auth_sspi`. |
| `ssoRemoteUserStripDomainName` | bool | `false` | Strip domain from `user@domain` or `domain\user` before resolving, to avoid duplicate accounts vs. manual login. |
| `cookieExpire` | bool | `false` | Controls the `sso_stop` cookie lifetime on logout/failed login. `false` = session cookie (cleared when browser closes); `true` = expires immediately so a user can log straight back in via SSO. |
| `ssoExcludedPaths` | sequence(string) | `[]` | Internal paths that automated SSO must not act on. One per line in the form; `<front>` matches the front page. Beyond these, a hardcoded list always excludes `/user`, `/user/login`, `/user/login/sso`, `/user/logout`, `/admin/config/search/clean-urls/check`. |
| `ssoExcludedHosts` | sequence(string) | `[]` | Hostnames (matched against `$_SERVER['SERVER_NAME']`) on which automated SSO is skipped, for multi-hostname sites. |
| `redirectOnLogout` | bool | `true` | On logout, send the user to `logoutRedirectPath`. |
| `logoutRedirectPath` | string | `/user/login` | Internal path used by the logout redirect (validated as an internal path by the form). |
| `enableLoginConfirmationMessage` | bool | `true` | Show "You have been successfully authenticated" after an SSO login. |

## Form validation notes

- `validateForm()` rejects saving if any *enabled* `ldap_server` entity uses `bind_method` of `user`
  or `anon_user` — with SSO the user's password is never available, so the module cannot bind as the
  user. Configure the LDAP server with a service-account bind instead.
- If `redirectOnLogout` is on, `logoutRedirectPath` must be non-empty and a valid internal path
  (`Url::fromUserInput`).
- Excluded paths/hosts textareas are split with `LdapAuthenticationAdminForm::linesToArray()`.

## Set without the UI

Drush:

```bash
drush config:set ldap_sso.settings ssoVariable REMOTE_USER -y
drush config:set ldap_sso.settings seamlessLogin true -y
# excluded paths is a sequence — set an element by index:
drush config:set ldap_sso.settings ssoExcludedPaths.0 '/cron.php' -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('ldap_sso.settings')
  ->set('ssoVariable', 'REMOTE_USER')
  ->set('seamlessLogin', TRUE)
  ->set('ssoExcludedPaths', ['/cron.php', 'blog/*'])
  ->set('redirectOnLogout', TRUE)
  ->set('logoutRedirectPath', '/user/login')
  ->save();
```

`ldap_sso.install` update hooks `8001`–`8007` migrate these keys out of the old
`ldap_authentication.settings`, set `REMOTE_USER` as the default variable, add the logout-redirect and
confirmation-message keys, and normalize the boolean/`ssoSplitUserRealm` values.
