<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services

Two public services (`simplesamlphp_auth.services.yml`). All SAML crypto is delegated to the
`simplesamlphp/simplesamlphp` library; these classes wrap it and map to Drupal accounts.

## `simplesamlphp_auth.manager` — `SimplesamlphpAuthManager`

Wraps `\SimpleSAML\Auth\Simple` (auth source = config `auth_source`). Key methods:

- `isActivated(): bool` — config `activate`.
- `isAuthenticated(): bool` — the library's session check (the trust boundary).
- `externalAuthenticate()` — redirect to the IdP (`requireAuth`), ReturnTo = current URI.
- `getAttributes(): array` — all SAML attributes for the session.
- `getAttribute($name)` — first value of an attribute; **throws
  `SimplesamlphpAttributeException` if unset/empty** (used by the getters below).
- `getAuthname()` — `getAttribute(unique_id)`; the identity used for login/register.
- `getDefaultName()` / `getDefaultEmail()` — `getAttribute(user_name)` / `getAttribute(mail_attr)`.
- `allowUserByAttribute(): bool` — runs `hook_simplesamlphp_auth_allow_login`; any FALSE denies.
- `getStorage(): ?string` — SP `store.type` (login refuses if `phpsession`).
- `logout($redirect_path = base_path())` — library logout + redirect (SLO).

## `simplesamlphp_auth.drupalauth` — `SimplesamlphpDrupalAuth`

Bridges an authname to a Drupal account via `externalauth`. Key methods:

- `externalLoginRegister($authname)` — `externalauth->login()`, else `externalRegister()`;
  then `roleMatchSync()` if `role.eval_every_time`.
- `externalRegister($authname)` — the mapping logic: if a user with `name == $authname` exists,
  link it **only when `autoenablesaml`** is on (else abort with a message and SAML logout);
  otherwise, with `autoenablesaml` on, offer `hook_simplesamlphp_auth_existing_user` a chance to
  match; if still none and `register_users` is on, `externalauth->register()`; then
  `synchronizeUserAttributes(force)` and `userLoginFinalize()`.
- `synchronizeUserAttributes($account, $force = FALSE)` — copy SAML name/email onto the account
  (guarded by `sync.*` unless forced); logs a critical error on username collision.
- `roleMatchSync($account)` / `getMatchingRoles()` — apply the `role.population` rule string and
  `hook_simplesamlphp_auth_user_roles_alter`, add/remove non-locked roles.

Typical programmatic entry point is the route `/saml_login`
(`SimplesamlphpAuthController::authenticate`), not direct service calls.
