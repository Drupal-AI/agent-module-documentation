<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LDAP SSO Auth (ldap_sso_auth) — agent index

Logs Drupal users in from an SSO identity the **web server** has already established — typically
Kerberos (mod_auth_kerb), NTLM (mod_auth_sspi) or an SSO reverse proxy setting a `$_SERVER`
variable such as `REMOTE_USER` — and resolves that username against the servers configured by the
LDAP module. No password is exchanged with Drupal; the premise is that authentication happened at
the transport layer before Drupal saw the request. It registers a Drupal **authentication provider**
(`authentication.ldap_sso_auth`, priority 210) that, on a request with no logged-in session and a
path that is not excluded, reads the configured server variable, optionally splits `user@realm` /
strips a domain, hands the name to `ldap_authentication`'s SSO login validator
(`ldap_authentication.login_validator_sso` / `LoginValidatorSso`), and calls `user_login_finalize()`
when the LDAP server recognises the name.

The heavy lifting lives in the `common.ldap_sso_auth` service (class `LdapSsoAuthAuthentication`).
A page-cache request policy (`ldap_sso_auth.page_cache_request_policy.ldap_sso_auth_login_name`)
bypasses the internal page cache whenever the SSO variable is present so a cached anonymous page is
not served to an SSO-identified visitor. The only route is the settings form.

- Depends on: `ldap:ldap_servers`, `ldap:ldap_authentication` (Composer `drupal/ldap:^4.3`).
- Core: `^9 || ^10 || ^11`. Package: `Lightweight Directory Access Protocol`. Version **8.x-2.4**.
- Settings page: `configure: ldap_sso_auth.admin_form` at `/admin/config/people/ldap/sso-auth`,
  gated by the core permission `administer site configuration`. **No permissions of its own.**
- No drush commands, no plugin types, no field widgets/formatters. Provides a config schema.
- Hooks: `hook_help`, `hook_user_logout` (optional post-logout redirect to an internal path).
- **There is no `/user/login/sso` route in this release**, despite the help text naming it — the
  string appears only as a hard-coded entry in `defaultPathsToExclude()`. Login is what the
  authentication provider does automatically; there is no explicit SSO login URL to link to.

## What you'd do → where

- **Configure the SSO variable, realm/domain handling, excluded paths/hosts, logout redirect** →
  [configure/settings.md](configure/settings.md)
- **Understand the authentication provider, the login flow, the services, the page-cache policy and
  the logout hook / call it from code** → [api/authentication.md](api/authentication.md)

## Key facts (real machine names)

- Route: `ldap_sso_auth.admin_form` → `/admin/config/people/ldap/sso-auth`
  (`\Drupal\ldap_sso_auth\Form\LdapSsoAuthAdminForm`, form id `ldap_sso_auth_admin_form`).
- Menu link `ldap_sso_auth.admin_form` (parent `ldap.settings`); local task with base route
  `entity.ldap_server.collection`.
- Services: `authentication.ldap_sso_auth`
  (`Authentication\Provider\LdapSsoAuthAuthenticationProvider`, tag `authentication_provider`,
  `provider_id: ldap_sso_auth_authentication_provider`, `priority: 210`); `common.ldap_sso_auth`
  (`LdapSsoAuthAuthentication` implements `LdapSsoAuthAuthenticationInterface`);
  `ldap_sso_auth.page_cache_request_policy.ldap_sso_auth_login_name`
  (`RequestPolicy\PageCache\LdapSsoAuthLoginName`, tag `page_cache_request_policy`).
- Config object: `ldap_sso_auth.settings`. Keys: `ssoVariable` (default `REMOTE_USER`),
  `ssoSplitUserRealm` (default TRUE), `ssoRemoteUserStripDomainName` (default FALSE),
  `ssoExcludedPaths` (sequence), `ssoExcludedHosts` (sequence), `redirectOnLogout` (default TRUE),
  `logoutRedirectPath` (default `/user/login`), plus `seamlessLogin`, `cookieExpire`,
  `enableLoginConfirmationMessage` (present in schema/form but **not read by runtime code** in this
  release — see api/authentication.md).
- Key methods on `LdapSsoAuthAuthentication`: `applies()`, `authenticate()`, `loginRemoteUser()`,
  `validateUser()`, `stripDomainName()`, `splitUserNameRealm()`, `checkExcludePath()`,
  `defaultPathsToExclude()`.
- External symbol consumed: `Drupal\ldap_authentication\Controller\LoginValidatorSso`
  (`setAuthname()`, `processLogin()`, `getDrupalUser()`); detail logger `ldap.detail_log`
  (`LdapDetailLog`).
