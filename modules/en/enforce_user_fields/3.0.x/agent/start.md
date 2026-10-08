<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enforce User Fields (enforce_user_fields) — agent index

Forces logged-in users to complete **required user-account fields** before they can browse the site.
At login (`hook_user_login`) a checker (`UserFieldsChecker::hasUnfilledRequiredFields`) walks the user
entity's fields, and if any field that is both **required** and **empty** is found it stores a boolean
flag in the session (`enforce_user_fields`). On every subsequent non-AJAX request a
`KernelEvents::REQUEST` subscriber (`EnforceUserFieldsSubscriber`, priority 30) reads that flag and, if
set, adds an error message and issues a `RedirectResponse` to the user's own edit form
(`entity.user.edit_form`). The flag is refreshed whenever the account form is saved, so once the fields
are filled the redirect stops. It is a data-completeness / UX gate, not an access-control layer.

The redirect target is a fixed internal route (the current user's `entity.user.edit_form`); the
`destination` query param is built from the current route match (an internal path), not from request
input. A `SKIP_ROUTES` allowlist (edit form, logout, password-reset login, image styles, CSS/JS assets)
plus early returns for anonymous users, AJAX (`X-Requested-With`), the `bypass enforce user fields`
permission, and an admin-configured path `whitelist` keep it from trapping users or looping.

- Depends on: nothing declared in `.info.yml` (uses core `user`). Optional soft integration with
  **`multiple_registration`** (only consulted when that module is installed — per-role field scoping).
- Core: `^11.1` (requires the `#[Hook]` attribute API). PHP `>=8.3`. Package: `User`.
- Has a settings page: **yes** — route `enforce_user_fields.settings`
  (`/admin/config/people/enforce-user-fields-settings`, permission `administer site configuration`).
- Provides one permission (`bypass enforce user fields`), config schema, an alter hook. No drush, no
  plugin types, no services beyond the checker + subscriber.

## What you'd do → where

- **Set the prompt message / exempt paths (whitelist) / find the config keys** →
  [configure/settings.md](configure/settings.md)
- **Understand the enforcement mechanism, exemptions, the checker service, or override the check from
  code (alter hook)** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Route: `enforce_user_fields.settings` (`/admin/config/people/enforce-user-fields-settings`, `_form`
  `Drupal\enforce_user_fields\Form\SettingsForm`, `_permission: administer site configuration`).
  Menu link `enforce_user_fields.settings` (parent `user.admin_index`), local task
  `enforce_user_fields.settings_tab`, config-translation mapping `enforce_user_fields.settings`.
- Services: `enforce_user_fields.checker` (`UserFieldsChecker`; also aliased from the FQCN, private),
  `enforce_user_fields.event_subscriber` (`EnforceUserFieldsSubscriber`, tagged `event_subscriber`).
- Permission: `bypass enforce user fields`.
- Config object: `enforce_user_fields.settings` — keys `message` (string), `whitelist` (newline path
  list, lower-cased on save), `langcode`. Install default `message` =
  `Fill out the required fields to complete your profile.`; `whitelist` empty by default.
- Session flag: `enforce_user_fields` (constant `EnforceUserFieldsHooks::SESSION_KEY`).
- Event: `KernelEvents::REQUEST` → `checkForUserFields`, priority `30`.
- `SKIP_ROUTES` (never redirected): `entity.user.edit_form`, `user.logout`, `user.reset.login`,
  `image.style_public`, `image.style_private`, `system.css_asset`, `system.js_asset`.
- Hooks (attribute `#[Hook]` in `Hook\EnforceUserFieldsHooks`): `help`, `user_login`,
  `form_user_form_alter`. Alter hook invoked:
  `enforce_user_fields_have_unfilled_required_fields_alter(bool &$result, AccountInterface $account)`
  (documented in `enforce_user_fields.api.php`).
- Update hooks: `enforce_user_fields_update_8001` (seed default message),
  `enforce_user_fields_update_10001` (lower-case existing whitelist).
