<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SAML flow — routes, controller, services, hooks

SP-side SAML 2.0 built on `OneLogin\Saml2\Auth` (php-saml v3). All processing is delegated to the
toolkit; this module wires routes to it and does the Drupal-side account work.

## Routes (`onelogin_integration.routing.yml`)

All `/onelogin_saml/*` routes are `_access: 'TRUE'` (anonymous — an IdP must reach `/acs`
unauthenticated). The admin form is `_permission: 'administer site configuration'`.

| Route | Path | Controller method |
|-------|------|--------------------|
| `.sso` | `/onelogin_saml/sso` | `singleSignOn` — SP-initiated login |
| `.acs` | `/onelogin_saml/acs` | `assertionConsumerService` — consumes the SAMLResponse |
| `.slo` | `/onelogin_saml/slo` | `singleLogOut` — local logout + IdP logout |
| `.sls` | `/onelogin_saml/sls` | `singleLogOutService` — SLO callback (`processSLO()`) |
| `.metadata` | `/onelogin_saml/metadata` | `metadata` — SP metadata XML |
| `.user` | `/user` | `forceUserLogin` — redirect to `/onelogin_saml/sso` if `force_onelogin`, else `/user/login` |
| `.admin_form` | `/admin/config/system/onelogin_integration` | `OneLoginIntegrationAdminForm` |

## Controller (`OneLoginIntegrationController`)

- `singleSignOn()` — reads `?destination` / `?returnTo`; if already logged in, redirects to that
  target (via `Url::fromUri('internal:'…)`) or `/`. Otherwise calls
  `factory->createFromSettings()->login($target)` (target becomes RelayState) to redirect to the
  IdP.
- `assertionConsumerService()` — reads `RelayState` (POST) / `returnTo` / `destination` into
  `$target`, and `SAMLResponse` (POST). If a `SAMLResponse` is present it calls
  `processResponse()`, then `getErrors()` on the same cached `Auth`; on no errors it calls
  `AuthenticationService::processLoginRequest()`; on errors it shows them (plus
  `getLastErrorReason()` when debug is on). Finally redirects to `$target` (or `/`).
- `singleLogOut()` — `session_destroy()` then `Auth::logout(new RedirectResponse('/'))`.
- `singleLogOutService()` — `processSLO()`; `session_destroy()` on success.
- `metadata()` — returns `Auth::getSettings()->getSPMetadata()` as `text/xml`.
- `forceUserLogin()` — reads `force_onelogin` config (note: not exposed on the admin form).

## Auth factory (`SAMLAuthenticatorFactory`)

`createFromSettings(array $settings = [])` → `getAuth()`. Constructs and **caches** one `Auth`
instance from `onelogin_integration.settings` (see [../config/settings.md](../config/settings.md)
for the full config→php-saml mapping). Throws `MissingDependencyException` if
`\OneLogin\Saml2\Auth` is absent. When `x509cert_onthefly` is set it HTTP-GETs `entityid` with the
core `http_client` (Guzzle) and scrapes `ds:X509Certificate` via EasyRdf `XMLParser`; on any
exception the cert is silently left empty.

## Login processing (`AuthenticationService::processLoginRequest`)

Runs only after php-saml validated the response with no errors. Reads from the same cached `Auth`:

1. Requires a NameID (`getNameId()`), else error → redirect `/`.
2. Reads `getAttributes()`; picks `$username`/`$email` from the attributes named by the `username`
   and `email` config mappings (first value of each). If no e-mail attribute and the NameID
   contains `@`, uses the NameID as the e-mail. If `username_from_email`, derives the username from
   the e-mail.
3. Matches a Drupal user with an **access-checked** entity query on `name` (if
   `account_matcher == 'username'`) or on `mail` (**default**). Missing required value → error.
4. Existing user → `syncRoles()`; new user → `autocreateUser()`.
5. On a `UserInterface` result: `storeAuthUser()` (merge into `onelogin_authmap`),
   `user_login_finalize()`, set the `Drupal.visitor.onelogin_integration_login` cookie, redirect to
   `user/<uid>/edit`.

`syncRoles()` — splits the IdP `role` attribute by `onelogin_role_delimiter` (fallback `;`), builds
per-Drupal-role mappings from the `role_<machine>` config (comma = OR of groups, `|` = AND within a
group), assigns matched roles. **No mapped roles ⇒ `status = 0` (blocked)** and an error redirect.
`autocreateUser()` requires both username and e-mail, then `UserService::createUser()` creates the
account with a random password, English langcodes, and `status => 0`; role sync then unblocks it if
it earns a role.

## Hooks (`onelogin_integration.module`) & install

- `hook_form_alter` / `hook_form_user_login(_block)_alter` → `..._user_login_form_alter()`: adds the
  "Log in using SAML" link (when `saml_link`), and a validate handler
  `..._form_user_validation()` that **blocks password login** for any uid found in
  `onelogin_authmap` (`onelogin_integration_user_use_onelogin()`).
- `hook_form_user_form_alter` → `..._user_drupal_form_alter()`: for SAML-linked users, hides
  `pass` and (per config) `current_pass` / `mail`, and adds a "Remove Onelogin integration" submit
  that deletes the `onelogin_authmap` row.
- `hook_user_logout` clears the SSO cookie. `hook_help` describes the SP role.
- `.install`: `hook_install` revokes *change own username* from authenticated;
  `hook_schema` creates `onelogin_authmap` (`aid` serial PK, `uid` int, index on `uid`);
  `hook_requirements` checks OpenSSL (error if missing) and Gettext (warning);
  `update_8001` back-creates the table.
