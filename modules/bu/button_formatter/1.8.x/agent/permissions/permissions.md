# Permissions

Defined in `button_formatter.permissions.yml`.

| Permission | Machine name | Restrict access | Gates |
|---|---|---|---|
| Administer Button Formatter | `administer button formatter` | `true` | The settings form/route `button_formatter.settings` (`/admin/config/button-formatter`). |

This is the only permission the module defines. It is flagged `restrict access: true` because
holders edit the site-wide button style vocabulary (`global_class`, `styles`, `sizes`, `radius`).
Choosing a style *on a field display* is instead governed by core's Field UI permissions
(`administer <entity-type> display`), not by this permission.
