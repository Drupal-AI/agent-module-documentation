<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LDAP SSO (ldap_sso) — agent index

Logs a Drupal user in from an identity the web server has already authenticated (Kerberos/NTLM
via `mod_auth_sspi`/`mod_auth_kerb`), resolved against LDAP — no Drupal login form. The identity is
read from a `$_SERVER` variable (default `REMOTE_USER`) that the web server sets, then handed to
`ldap_authentication` to resolve/provision the matching account and finalize the session.

Depends on `ldap:ldap_servers` and `ldap:ldap_authentication` (composer `drupal/ldap ^4.4`).
Core `^10.3 || ^11`. Configure route: `ldap_sso.admin_form` (`/admin/config/people/ldap/sso`).
No permissions, no Drush, no plugin types of its own. Provides config schema for `ldap_sso.settings`.

- **Configure SSO (which server variable, seamless mode, excluded paths/hosts, logout redirect)** →
  [configure/settings.md](configure/settings.md)
- **How SSO actually runs (event subscriber, `/user/login/sso` route, cookies, logout)** →
  [events/sso.md](events/sso.md)

Key facts:
- Config object **`ldap_sso.settings`**; keys: `seamlessLogin` (bool), `ssoVariable` (string, default
  `REMOTE_USER`), `ssoSplitUserRealm`, `ssoRemoteUserStripDomainName`, `cookieExpire`,
  `ssoExcludedPaths` (seq), `ssoExcludedHosts` (seq), `redirectOnLogout`, `logoutRedirectPath`
  (default `/user/login`), `enableLoginConfirmationMessage`.
- Routes: **`ldap_sso.login_controller`** → `/user/login/sso` (`_custom_access`
  `LoginController::access` — anonymous only; `no_cache: TRUE`); **`ldap_sso.admin_form`** →
  `/admin/config/people/ldap/sso` (`_permission: 'administer site configuration'`).
- Services: **`ldap_sso.boot`** (`LdapSsoBootSubscriber`, event_subscriber on
  `KernelEvents::REQUEST` priority 30), **`ldap_sso.server_variable`** (`ServerVariableLookup`,
  reads `$_SERVER[ssoVariable]`), `logger.channel.ldap_sso`.
- Login is finalized in `LoginController::login` via `user_login_finalize()` only after
  `ldap_authentication`'s `ldap_authentication.login_validator_sso` (`LoginValidatorSso`) returns a
  Drupal user.
- Runtime cookies: `sso_stop` (opt this browser out until it expires), `sso_login_running`
  (in-flight guard against a redirect loop).
