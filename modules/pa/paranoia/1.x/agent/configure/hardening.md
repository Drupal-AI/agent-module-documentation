<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What Paranoia hardens (and how to remove it)

There is **no settings form** (`configure` is null). Enabling the module applies the hardening; the hooks below run on every relevant event thereafter.

## Applied on install (`paranoia_install`)
- `paranoia_remove_disabled_modules()` uninstalls every module returned by `hook_paranoia_disable_modules()` — by default `php` and `skinr_ui`.
- `_paranoia_remove_risky_permissions()` revokes every banned permission from all roles.
- `ParanoiaDefanger::unsetAdminRole()` clears the `is_admin` flag on all roles.

## Enforced continuously (hooks in `paranoia.module`)
| Mechanism | Hook | Effect |
|---|---|---|
| Hide modules | `hook_system_info_alter`, `form_system_modules_uninstall_alter` | `paranoia`, `php`, `skinr_ui` hidden from the modules and uninstall pages. |
| Re-disable banned modules | `form_system_modules_alter` (+ validate) | Any banned module enabled via the modules form is uninstalled again on submit. |
| Block admin-role grant | `hook_user_role_presave` | If a role is/was admin, `is_admin` is forced FALSE and an alert is logged to the `paranoia` channel. |
| Hide admin-role selector | `form_user_admin_settings_alter` | `admin_role` element `#access` = FALSE. |
| Protect user/1 | `form_user_form_alter` | Name/mail/pass/current_pass fields hidden unless the current user *is* user/1. |
| Lock down permissions form | `form_user_admin_permissions_alter` | Banned permissions removed; every `restrict access: true` perm disabled + unchecked for Anonymous/Authenticated; banned perms revoked from all roles on submit. |
| Re-check on module install | `hook_modules_enabled` | `_paranoia_remove_risky_permissions()` runs again. |
| Disable risky forms | `hook_form_alter` | Forms from `hook_paranoia_risky_forms()` get `#access` FALSE + an always-fail validator (mitigates `unserialize()` RCE). Default: `devel_execute_php`. |
| Block routes | `RouteSubscriber` | Routes from `hook_paranoia_hide_routes()` get `_access` = `FALSE`. Default: `devel.execute_php`. |

Default banned permissions: `use PHP for settings`, `use text format php_code` (core), `execute php code` (devel), `use PHP for tracking visibility` (google analytics), `administer bueditor`, `use PHP for username patterns` (auto_username), `use PHP for auto entity labels` (auto_entitylabel).

## Config
`config/install/paranoia.settings.yml` ships a single value:
```yaml
delete_blocked_users: 1
```
Schema `paranoia.settings.delete_blocked_users` (integer). No UI writes it; it is a documented toggle only.

## Status report
`paranoia_requirements()` raises `REQUIREMENT_ERROR` on the status report when the `php` module is enabled (i.e. someone force-enabled it directly in the database, bypassing Paranoia).

## Uninstall (UI is blocked by design)
```bash
drush pm:uninstall paranoia
```
Or delete the module directory and truncate `cache_config` / clear caches. Paranoia intentionally does not appear on the uninstall form.
