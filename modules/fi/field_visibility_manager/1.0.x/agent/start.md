<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Visibility Manager (field_visibility_manager) — agent index

**Admin table that hides selected node fields from the add/edit form for chosen roles by setting the widget's `#access` to FALSE.**

- **Version:** 1.0.x · **Core:** ^9 || ^10 || ^11 · **Package:** PanKM
- **Route:** `field_visibility_manager.admin_settings_form` → `/admin/config/field_visibility_manager/adminsettings` (`administer site configuration`, `_admin_route`)
- **Config:** `field_visibility_manager.adminsettings:permissions` (per field: `Field`, `field_name`, and a flag per role id)
- **Mechanism:** `hook_form_alter` sets `$form[$fieldname]['#access'] = FALSE` when a current-user role is flagged for that field
- **Scope:** node entity forms; fields named `field_*`

**Security:** Form-widget access only — `#access=FALSE` is enforced server-side by the Form API (blocked role cannot submit the field), but there is **no** `hook_entity_field_access`, so field **display/read** is not restricted (rendered pages, REST, Views still show the value). Not a view-access control. Admin form gated by `administer site configuration`.
