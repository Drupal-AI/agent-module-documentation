<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Declared in `tfa.permissions.yml`:

| Permission | Restrict access | Gates |
|---|---|---|
| `admin tfa settings` | yes | The global settings form `tfa.settings` (`/admin/config/people/tfa`) and its menu/local-task links. |
| `setup own tfa` | no | Route option `_tfa_permission` on `tfa.overview`, `tfa.validation.setup`, `tfa.plugin.reset` — lets a user view/configure their own TFA methods. Also required for the "redirect to setup after login" behavior. |
| `disable own tfa` | no | Route option `_tfa_permission` on `tfa.disable` — lets a user turn off their own TFA (still requires re-entering the current password in `TfaDisableForm`). |
| `administer tfa for other users` | yes | Allows setting up, resetting, and disabling TFA for **other** accounts, and resetting their skip counter, via `TfaLoginController::accessSelfOrAdmin` / `TfaOverviewForm::canPerformReset`. Admins confirm with **their own** password. |

Notes from source:

- The per-user routes use the custom access check `accessSelfOrAdmin`, not a plain `_permission`.
  For a self request it grants access only if the target user holds the route's `_tfa_permission`;
  for a non-self request it requires `administer tfa for other users` (and, per `{method}`, the
  plugin's `allowUserSetupAccess()` — recovery-code plugin blocks viewing another user's codes).
- `required_roles` in `tfa.settings` (not a permission) is what makes TFA **mandatory** for a role;
  the `SettingsForm` warns if a required role lacks `setup own tfa`.
- Install hooks grant `administer tfa for other users` to roles that already had `administer users`
  (`tfa_update_8009`), and an old `require tfa` permission was migrated into `required_roles`
  (`tfa_update_8003`).
