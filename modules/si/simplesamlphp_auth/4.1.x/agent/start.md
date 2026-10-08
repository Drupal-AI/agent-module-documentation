<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SimpleSAMLphp Authentication (simplesamlphp_auth) — agent index

**SAML single sign-on.** Delegates login to a remote IdP through a local SimpleSAMLphp SP
(library `simplesamlphp/simplesamlphp`) and Drupal `externalauth`. Version **4.1.x**,
core `^10 || ^11.3`. Requires the `externalauth` module and a working SimpleSAMLphp SP.
Config UI: `/admin/config/people/simplesamlphp_auth` (route `simplesamlphp_auth.admin_settings`).
Nothing happens until `activate` is turned on.

**Flow:** anon hits `/saml_login` → controller checks `activate` + storage ≠ `phpsession` →
library `isAuthenticated()` (all SAML crypto is the library's job) → `allowUserByAttribute()`
hook gate → authname = non-empty `unique_id` attribute → `externalauth` login/register →
optional role + attribute sync. Empty `unique_id` throws; existing-username linking happens
only when `autoenablesaml` is on.

- **Configure it** — settings keys, three admin tabs, attribute mapping, role rules, activate: [configure/settings.md](configure/settings.md)
- **Call it in code** — the two services and their methods: [api/services.md](api/services.md)
- **Hook into login** — allow/deny, user match, authname, roles, attributes: [hooks/hooks.md](hooks/hooks.md)
- **Permissions** — the two restricted perms: [permissions/permissions.md](permissions/permissions.md)

Also ships: block `simplesamlphp_auth_block` (auth-status/login link), a "Federated login" link on
the user login form, and per-user "Enable this user to leverage SAML authentication" checkbox.
No Drush, no plugin types, no submodules. Companion project: `simplesamlphp_custom_attributes`.
