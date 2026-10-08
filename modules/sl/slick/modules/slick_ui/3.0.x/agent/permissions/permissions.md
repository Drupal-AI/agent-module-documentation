# Permissions

Defined in `slick_ui.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer slick` | All Slick UI screens: the optionset collection, add/edit/duplicate/delete forms, and the sitewide settings page (`/admin/config/media/slick*`). |

`administer slick` is marked `restrict access: true` (a security-sensitive permission — it lets
holders manage configuration and attach assets), so grant it only to trusted roles. It is also
set as the `admin_permission` on the `slick` config entity via `hook_entity_type_build()`.
