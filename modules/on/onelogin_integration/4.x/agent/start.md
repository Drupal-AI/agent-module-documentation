<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OneLogin Integration (onelogin_integration) — agent index

Turns Drupal into a **SAML 2.0 Service Provider** against OneLogin or any SAML IdP, using the
official **`onelogin/php-saml`** v3 toolkit (`OneLogin\Saml2\Auth`). Package `OneLogin`, core
`^11`, license GPL-2.0-or-later, version 4.x (installed 4.0.0). No OIDC/OAuth path — SAML only.

- **Config object, schema, admin form, every setting** → [config/settings.md](config/settings.md)
- **Routes, controller, services, auth/login flow, hooks, DB table, permission** →
  [flows/saml.md](flows/saml.md)

## Dependencies

- Composer: `onelogin/php-saml:^3` (installed **3.1.0**) and `easyrdf/easyrdf:^1.1` (used to scrape
  the IdP cert when "on-the-fly" is enabled). No Drupal module dependencies in `.info.yml`.
- Runtime: OpenSSL required, Gettext recommended (`onelogin_integration_requirements()` in
  `.install`).

## What it provides (from source)

- **Routes** (`onelogin_integration.routing.yml`, all under `/onelogin_saml/*`, all
  `_access: 'TRUE'` except the admin form): `.sso`, `.acs`, `.slo`, `.sls`, `.metadata`, `.user`
  (overrides `/user` to optionally force IdP login), and `.admin_form`
  (`/admin/config/system/onelogin_integration`, `_permission: 'administer site configuration'`).
- **Controller** `OneLoginIntegrationController` — `singleSignOn`, `assertionConsumerService`,
  `singleLogOut`, `singleLogOutService`, `metadata`, `forceUserLogin`.
- **Services** (`onelogin_integration.services.yml`): `SAMLAuthenticatorFactory` (builds the
  `Auth` instance from config, caches it), `AuthenticationService` (matches/creates the user, syncs
  roles, finalises login), `UserService` (creates the blocked account). Plus a raw
  `OneLogin\Saml2\Auth` service via factory.
- **Config** object `onelogin_integration.settings` (schema in `config/schema/`, partial defaults
  in `config/install/`). One **permission**: `administer onelogin integration settings`
  (`.permissions.yml`) — note the admin route actually uses `administer site configuration`.
- **DB** table `onelogin_authmap` (`hook_schema` in `.install`) mapping which uids authenticate via
  SAML; drives the password-field hiding / "Remove Onelogin integration" hooks.
- **Hooks** (`.module`): `hook_help`, `hook_user_logout`, `hook_form_alter` +
  `hook_form_user_login(_block)_alter` (adds the SAML link, blocks password login for SAML users,
  hides password/e-mail fields).

## Key facts

- SP endpoints are anonymous by design (an IdP must POST to `/acs` unauthenticated). All SAML
  response processing is delegated to `php-saml`; the module reads NameID/attributes only after
  `processResponse()` and an empty `getErrors()` on the **same cached `Auth` object**.
- Account matching defaults to **e-mail** (`account_matcher` unset → email branch in
  `AuthenticationService::processLoginRequest()`). Auto-provisioned users start **blocked**
  (`status => 0`) and are unblocked only if role sync assigns at least one mapped role.
- SAML validation strictness, signing and encryption are **admin-configurable** and should be set
  per your IdP's requirements — see [config/settings.md](config/settings.md) for each key and its
  install default.
