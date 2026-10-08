<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Perms per Menu — agent index

Add-on to **menu_admin_per_menu** that generates six fine-grained permissions **per menu** so a role
can be allowed some menu-link operations but not others. No config UI (`configure` null), no Drush,
no plugin types, no config schema. Depends on `menu_admin_per_menu` (which itself pulls in `menu_ui`).

- **The six per-menu permissions, their exact machine names, and how each is enforced** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permissions are dynamic (`MenuPermsPerMenuPermissions::permissions()`), one set per `Menu` entity,
  with the menu **id** embedded in the machine name, e.g. `add new links to main menu from menu interface`.
- Enforcement: a route subscriber (priority -225, after menu_admin_per_menu) adds `_custom_access` to
  the add-link / delete / translate routes; `hook_form_alter()` on `menu_link_content` and `menu_edit_form`
  disables/removes the Link, Enable, Expand, Delete, Translate and Add-child controls.
- The Link/Enable/Expand field limits are applied as form `#disabled`.
