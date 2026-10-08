<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — authentication provider, services, login flow

## Services (`ldap_sso_auth.services.yml`)

- `authentication.ldap_sso_auth` → `Authentication\Provider\LdapSsoAuthAuthenticationProvider`.
  Tagged `authentication_provider` with `provider_id: ldap_sso_auth_authentication_provider`,
  `priority: 210`. Constructor takes `@common.ldap_sso_auth`. It is a thin adapter: `applies()`,
  `authenticate()`, `cleanup()` (no-op) delegate to the common service; `handleException()` rewrites
  an `AccessDeniedHttpException` into `UnauthorizedHttpException('Invalid consumer origin.')`.
- `common.ldap_sso_auth` → `LdapSsoAuthAuthentication` (implements
  `LdapSsoAuthAuthenticationInterface`). Constructor args: `@config.factory`,
  `@entity_type.manager`, `@ldap_authentication.login_validator_sso`, `@ldap.detail_log`. This is
  where the flow lives.
- `ldap_sso_auth.page_cache_request_policy.ldap_sso_auth_login_name` →
  `RequestPolicy\PageCache\LdapSsoAuthLoginName`, tagged `page_cache_request_policy`. Constructor
  args: `@session_configuration`, `@config.factory`.

## The login flow (`LdapSsoAuthAuthentication`)

`applies(Request $request)` — returns FALSE (do not run) when the session already has
`uid > 0` **or** the request path is excluded (`checkExcludePath()`); otherwise returns TRUE when the
configured server variable is set on the request (read via `$request->server->get($ssoVariable)`;
`$request->server` is Symfony's wrapper over PHP `$_SERVER`).

`authenticate(Request $request)` — reads `$request->server->get($ssoVariable)` as `$remote_user`;
if `ssoSplitUserRealm` is on, splits `user@realm` via `splitUserNameRealm()`. If a non-empty
`$remote_user` results, calls `loginRemoteUser($remote_user, $realm)`; on a returned account calls
`user_login_finalize($account)` and returns it, else returns NULL (anonymous). All steps emit
`ldap.detail_log` entries under channel `ldap_sso_auth`.

`loginRemoteUser($remote_user, $realm)` — optionally `stripDomainName()` (when
`ssoRemoteUserStripDomainName`), then `validateUser($remote_user)`.

`validateUser($remote_user)` — the actual LDAP check is delegated to `ldap_authentication`:

```php
$this->validator->setAuthname(Html::escape($remote_user));   // LoginValidatorSso
$this->validator->processLogin();
return (bool) $this->validator->getDrupalUser()
  ? $this->validator->getDrupalUser()
  : FALSE;
```

So whether the name is a real directory user, and how the Drupal account is provisioned/mapped, is
decided by `ldap_authentication`'s `LoginValidatorSso`, not by this module. There is no password
handshake in this path — with SSO there is nothing for the module to bind with, which is why the
settings form refuses LDAP servers whose `bind_method` is `user`/`anon_user`.

`stripDomainName($remote_user)` — `preg_split('/[\@\\\\]/', …)`; supports `user@domain` and
`domain\user`, returns the user portion.

`splitUserNameRealm($remote_user)` — regex `^([A-Za-z0-9_\-\.]+)@([A-Za-z0-9_\-.]+)$`; returns
`[user, realm]`. The realm is captured for possible future use but not otherwise consumed.

`checkExcludePath($path = FALSE)` — resolves the path (uses `PHP_SELF` for non-`index.php`
entrypoints such as `cron.php`), returns TRUE if the path is in `defaultPathsToExclude()`, if
`SERVER_NAME` is in `ssoExcludedHosts`, or if the path matches the compiled pattern built from
`ssoExcludedPaths` (+ the always-appended `/user/reset/*`). Wildcards `*` → `.*`, `<front>` → the
site front page; the whole thing is `preg_quote`d then anchored.

`defaultPathsToExclude()` — `/admin/config/search/clean-urls/check`, `/user/login/sso`,
`/user/login`, `/user/logout`, `/user/password`.

## Page-cache request policy (`LdapSsoAuthLoginName::check()`)

If the request has **no** session and the configured server variable is not set on the request
(`$request->server->get($ssoVariable)`), returns `ALLOW` (serve from the internal page cache).
Otherwise returns `DENY`. This keeps the internal page cache from serving a cached anonymous page
when an SSO identity is present on the request.

## Hooks (`ldap_sso_auth.module`)

- `hook_help` — help text for `help.page.ldap_sso_auth` and the settings route.
- `hook_user_logout($account)` — when `redirectOnLogout` is set, builds a `RedirectResponse` to
  `Url::fromUserInput(logoutRedirectPath)` and `->send()`s it during logout.

## Calling from code

Resolve the service and reuse the parsing/validation helpers:

```php
$sso = \Drupal::service('common.ldap_sso_auth');   // LdapSsoAuthAuthentication
[$user, $realm] = $sso->splitUserNameRealm('jdoe@EXAMPLE.COM');
$account = $sso->validateUser($user);              // \Drupal\user\Entity\User|FALSE
```

Note `authenticate()`/`applies()` expect a real `Request` and read `$_SERVER`; they are meant to be
driven by core's authentication subscriber, not called ad-hoc.

## Config keys not wired to runtime

`seamlessLogin`, `cookieExpire`, `enableLoginConfirmationMessage` are stored by the form/schema but
no runtime class reads them in 8.x-2.4. Automatic SSO is effectively always active when the SSO
variable is present; the confirmation message is whatever `user_login_finalize()` produces.
