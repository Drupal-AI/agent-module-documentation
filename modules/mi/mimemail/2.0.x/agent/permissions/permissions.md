# Permissions

Defined in `mimemail.permissions.yml`.

| Permission | Gates |
|---|---|
| `edit mimemail user settings` | User may edit their own per-user Mime Mail settings. |
| `send arbitrary files` | Attach or embed files located **outside** the public files directory. Marked `restrict access: true` (trusted). |

Note the settings **admin form** itself is gated by core `administer site configuration`
(see `mimemail.routing.yml`), not by a module-specific permission.
