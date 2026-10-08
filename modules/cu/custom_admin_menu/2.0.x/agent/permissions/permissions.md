<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `custom_admin_menu.permissions.yml`. All three are flagged `restrict access: true`
(marked as sensitive / warned on the permissions form). Grant at `/admin/people/permissions`.

| Machine name | Title | Gates |
|---|---|---|
| `administer custom_admin_menu configuration` | Administer custom_admin_menu configuration | Access to the settings form route `custom_admin_menu.settings_form` (`/admin/config/system/custom-admin-menu`). |
| `access_custom_menu` | Access custom menu | Whether the user sees the **custom** menu in the toolbar. |
| `access_default_menu` | Access default menu | Whether the user sees the **default** admin menu in the toolbar. |

## How the two menu permissions combine

Checked at runtime in `src/Hook/Toolbar.php` via
`CustomAdminMenuManager::userCanSeeCustomAdminMenu()` (`access_custom_menu`) and
`userCanSeeDefaultAdminMenu()` (`access_default_menu`). Behavior depends on the `include_in_admin`
setting:

- **Separate-menu mode** (`include_in_admin = false`): without `access_default_menu` the default
  `administration` toolbar tab is removed; with `access_custom_menu` a separate custom-menu tab is
  added. A user can therefore see the custom menu only, the default menu only, both, or neither.
- **Merged mode** (`include_in_admin = true`): without `access_default_menu` the default admin
  items are dropped from the merged tree (only the help/flush "main" items and any custom items
  remain); without `access_custom_menu` no custom items are merged in.

Typical setup: grant `access_custom_menu` to editors (curated menu) and `access_default_menu` to
administrators (full standard tree); grant both to power users.

## Notes

- These are the module's **own** permissions; they only decide toolbar *visibility*. They do not
  grant access to the linked destinations — each menu link still enforces its target route/entity
  access, so a curated link the user cannot reach will not render.
- The superuser (user 1) always sees the full default menu and bypasses per-item role/language
  filtering (`CustomAdminMenuMenuItemDisplayManager::isSuperUser()`), regardless of these grants.
- Descriptions in the YAML are placeholders ("Optional description." / "Access … in toolbar.").
