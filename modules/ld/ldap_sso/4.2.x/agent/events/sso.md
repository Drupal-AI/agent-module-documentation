<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SSO runtime mechanism

Two entry points drive SSO: an event subscriber that (optionally) triggers login automatically, and
the `/user/login/sso` route/controller that actually reads the identity and finalizes the session.

## Automated trigger — `LdapSsoBootSubscriber` (service `ldap_sso.boot`)

Subscribes to `KernelEvents::REQUEST` at priority **30** via `getSubscribedEvents()`; handler
`checkSsoLoad(RequestEvent)`. It returns early (no SSO) when any of these hold:

- running under CLI (`PHP_SAPI === 'cli'`) or the current user is already authenticated;
- `seamlessLogin` config is off;
- `checkExcludePath()` matches — the request path is in the hardcoded exclude list
  (`/admin/config/search/clean-urls/check`, `/user/login/sso`, `/user/login`, `/user/logout`,
  `/user`), or the host equals an entry in `ssoExcludedHosts` (compared to `$_SERVER['SERVER_NAME']`),
  or the path matches an entry in `ssoExcludedPaths` (`<front>` resolves to `system.site.frontpage`);
- the `sso_stop` cookie is present (user opted out).

If the `sso_login_running` cookie is already set, it logs and `exit(0)` (loop guard). Otherwise it
calls `transferSsoLoginController()`: builds `Url::fromRoute('ldap_sso.login_controller')` with
`?destination=<current redirect destination>`, sets a `sso_login_running` cookie, and sends a
`RedirectResponseWithCookie` (302) immediately, then `exit(0)`.

## Login route — `ldap_sso.login_controller` → `/user/login/sso`

`LoginController::access()` grants the route only to anonymous users (`AccessResult::allowed()` if
anonymous, else `forbidden()`); route option `no_cache: TRUE`. `LoginController::login(Request)`:

1. Reads the identity: `ServerVariableLookup::getAuthenticationNameFromServer($config->get('ssoVariable'))`
   returns `$_SERVER[$variable]` (default `REMOTE_USER`) or `NULL`. This service
   (`ldap_sso.server_variable`, `ServerVariableLookupInterface`) is the single point where the
   authenticated name is obtained; tests override it.
2. If a name is present and `ssoSplitUserRealm` is on, `splitUserNameRealm()` splits `user@realm`.
3. If a name is present → `loginRemoteUser()`: optionally `stripDomainName()` (handles `user@domain`
   and `domain\user`), then `validateUser()` calls `ldap_authentication`'s
   `ldap_authentication.login_validator_sso` (`LoginValidatorSso`): `setAuthname(Html::escape($name))`,
   `processLogin()`, `getDrupalUser()`. Only if that returns a real (non-anonymous) user does
   `loginUserSetFinalize()` call core **`user_login_finalize($account)`** and (if
   `enableLoginConfirmationMessage`) show the success message. Account resolution/provisioning and any
   role mapping belong entirely to `ldap_authentication`/`ldap_user` — this module does not create or
   look up accounts itself.
4. If no name, or the validator returns no user → an error message is set and the user is redirected
   to `user.login`; a `sso_stop` cookie is written (lifetime per `cookieExpire`) so automated SSO does
   not immediately retry.
5. On success, redirects to the `destination` query param (base-path-corrected via `Url::fromUserInput`)
   or `<front>`, clearing the `sso_login_running` cookie. Returns a `RedirectResponseWithCookie`
   (`src/RedirectResponseWithCookie.php`, a `RedirectResponse` that also emits cookies).

## Logout — `hook_user_logout` (`ldap_sso.module`)

`ldap_sso_user_logout()`: if `seamlessLogin` is on it sets the `sso_stop` cookie (immediate expiry
when `cookieExpire`, else a session cookie) so the just-logged-out user is not instantly re-logged-in
by automated SSO. If `redirectOnLogout` is on it sends a `RedirectResponse` to `logoutRedirectPath`.

## Cookies summary

| Cookie | Set by | Purpose |
|---|---|---|
| `sso_login_running` | boot subscriber (set) / login controller (clear) | Guards against a redirect loop while a login is in flight. |
| `sso_stop` | login controller on failure, `hook_user_logout` | Opts this browser out of automated SSO until it expires (session or immediate per `cookieExpire`). |
