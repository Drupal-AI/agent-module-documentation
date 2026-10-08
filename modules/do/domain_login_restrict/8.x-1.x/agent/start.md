<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Login Restrict (domain_login_restrict) — agent index

On a **Domain**-module multi-site (one Drupal install, one shared user table, several hostnames),
this module restricts which accounts may log in on which domain. When enabled, login succeeds only if
the **active domain** is present in the account's **Domain Access** field (`field_domain_access`), and
optionally only if the account holds one of a per-domain allow-list of roles. It also, optionally,
auto-affiliates newly created accounts with the current domain and grants them per-domain roles. The
`login to any domain` permission (marked `restrict access: true`) bypasses every check, for admins and
support staff.

The module has **no routes, no config entities and no settings form of its own** — all behaviour is
wired through `hook_form_alter` and stored in the **State** API. The enforcement runs as a form
`#validate` handler that is `array_unshift`-ed to the front of the login form's validators
(`_domain_login_restrict_validate` in `domain_login_restrict.module:96`), calling the shared
`_domain_login_restrict_check()` (`domain_login_restrict.module:334`); the same check is added to the
password-reset request form (`user_pass`) as `_domain_login_restrict_reset_password_validate`
(`:239`), and `hook_user_login` (`:410`) re-runs it for JSON/`api_json` requests. The active domain
comes from `domain.negotiator`→`getActiveDomain()`; matching is a strict `in_array($currentDomain->id(), $userDomainList)`
on domain machine ids, and the role check is `array_intersect` of the per-domain allowed roles with
the user's roles.

- Depends on: `domain:domain`, `domain:domain_access` (info.yml). No Composer requirements (no `composer.json`).
- Core: `^8 || ^9 || ^10 || ^11 || ^12`. Package: `Domain`. Version: **8.x-1.4** (dir label `8.x-1.x`).
- **No settings page / `configure` route.** Config is stored in **State**, edited on the Domain
  module's own forms (`domain_settings`, `domain_edit_form`). No config schema, no config/install.
- Permissions: **one** — `login to any domain` (`restrict access: true`). No Drush commands.
- Plugins: uses core types only — one **Block** (`domain_login_block`) and one **Form**
  (`domain_list_form`). Defines no new plugin type.

## What you'd do → where

- **Turn the restriction on, configure per-domain roles, auto-assign domain/roles to new users, read
  the State keys and the exact match logic** → [configure/settings.md](configure/settings.md)
- **Grant/understand the `login to any domain` bypass permission** →
  [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Hooks (`domain_login_restrict.module`): `hook_help`, `hook_user_insert` (`:36` auto-assign domain +
  roles to new users), `hook_form_alter` (`:85`), `hook_user_login` (`:410`).
- Altered forms: `user_login`, `user_login_block`, `user_login_form` (add `_domain_login_restrict_validate`);
  `user_pass` (add `_domain_login_restrict_reset_password_validate`); `domain_settings` (global toggles
  + submit `_domain_login_restrict_config_submit`); `domain_edit_form` (per-domain role checkboxes +
  submit `_domain_login_restrict_config_role_submit`).
- Core functions: `_domain_login_restrict_check()` (`:334`), `_domain_login_restrict_user_lookup()`
  (`:295`, loads by `name` then by `mail`), `_domain_login_restrict_validate()`,
  `_domain_login_restrict_reset_password_validate()`.
- State keys: `domain_login_restrict_enabled` (bool, global on/off),
  `domain_login_restrict_assign_domain` (bool, auto-affiliate new users),
  `domain_login_restrict_role_<domainId>` (array, roles allowed to log in on that domain),
  `domain_login_restrict_assign_role_<domainId>` (array, roles auto-granted to new users on that domain).
- Permission: `login to any domain` (`domain_login_restrict.permissions.yml`, `restrict access: true`).
- Block plugin id: `domain_login_block` (`src/Plugin/Block/LoginBlock.php`, admin label "Domain Login
  block", `getCacheMaxAge()=0`, `blockAccess` = `access content`) — renders the domain switcher form.
- Form: `domain_list_form` (`src/Form/DomainListForm.php`) — a `<select>` of enabled domains whose
  `onchange` navigates to `$domain->getUrl()`; not the login gate, just a domain picker.
- Service: `domain_login_restrict.login_block` → `Drupal\domain_login_restrict\Form\DomainListForm`
  (`domain_login_restrict.services.yml`; the block builds the form via `form_builder`, so this service
  entry is effectively unused).
- Logger channel: `domain_login_restrict` (writes an error on each blocked login/reset attempt).
- Field used (from `domain_access`): `field_domain_access` on the user entity.
- Service used: `domain.negotiator` (`getActiveDomain()`).
