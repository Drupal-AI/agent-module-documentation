# Permissions

Defined in `lightgallery.permissions.yml`.

| Permission | Title | Guards |
|---|---|---|
| `configure lightgallery` | Configure settings | Access to the settings form route `lightgallery.admin.settings` (`/admin/config/user-interface/lightgallery`), where the lightGallery license key is set. |

This is an administrative permission (grant to trusted roles only — it controls the site-wide license
key config). It is not marked `restrict access`, but it only exposes the single settings form. Applying
the field formatters is governed separately by core's field-display administration permissions, not by
this permission.
