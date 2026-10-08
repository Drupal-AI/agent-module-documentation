# Permissions

`social_auth_entra_id.permissions.yml` declares one permission:

| Permission | Title | Notes |
|---|---|---|
| `administer social_auth_entra_id settings` | Administer Microsoft Entra ID settings | Manage the module's settings. |

Caveat: the settings route (`social_auth_entra_id.settings`) is actually gated by core
`administer site configuration`, and the admin menu link (`social_auth_entra_id.links.menu.yml`) uses
`user_access('administer site configuration')`. So the declared permission above is defined but not
wired to any route in this release — grant `administer site configuration` to let an admin reach
`/admin/config/services/entra-id/settings`.

The login/callback routes are open (`_access: TRUE`) so anonymous users can start the OAuth flow.
