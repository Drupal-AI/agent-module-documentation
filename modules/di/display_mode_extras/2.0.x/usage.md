<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Lets you manage which form modes and view modes are available per user role.
- Generates dynamic permissions so display modes can be granted to specific roles.
- Useful when different editorial roles should see different form/view mode variants of an entity.

---

## Install & configure

- Enable the module.
- Configure form modes at `/admin/structure/display-modes/settings` and view modes at `/admin/structure/display-modes/settings/view_modes` (both permission `administer site configuration`).
- Assign the module-generated per-mode permissions to roles on the People -> Permissions page.

---

## Usage & behaviour

- `DisplayModeExtrasPermissions` builds one dynamic permission per managed display mode.
- Two admin settings forms let you opt specific form modes and view modes into role-based governance.
- Both settings routes are gated by the core `administer site configuration` permission and marked `_admin_route`.
- Once a mode is managed, only roles granted its permission can use that form/view mode.
- Typical use: give a "Basic editor" role a slimmed-down form mode while "Power editor" gets the full one.
- View-mode governance can limit which display variants a role may select or trigger.
- Permissions are standard Drupal permissions, exportable and assignable like any other.
- No entity data is exposed by routes; the module only affects display-mode availability.
- Works alongside core Field UI display-mode configuration rather than replacing it.
- Because permissions are dynamic, clearing caches after adding a mode ensures the permission appears.
- Config is stored via CMI and can be deployed across environments.
- Safe on multilingual and multisite setups; it governs modes, not content.
- Removing a mode from management restores default (unrestricted) availability.
- Pair with role-based workflows so editors only touch the display variants they own.
- Review the generated permissions after enabling, since they widen the permissions matrix.
- The module has test coverage under `tests/`, indicating maintained behaviour.
