# Permissions

Defined in `admin_dialogs.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer dialogs` | (not set → FALSE) | All Dialog/Dialog Group entity list, add, edit, delete routes and the global settings form. Also set as the `admin_permission` on both config entity types (`entity_type_build`). |

Only this one permission. It governs configuration of a purely presentational feature (which
admin links open as dialogs and how). It does not grant access to any of the admin pages the
dialogs point at — those are still protected by their own permissions; Admin Dialogs only changes
how already-permitted links are opened. Grant it to administrators who curate the admin UX.
