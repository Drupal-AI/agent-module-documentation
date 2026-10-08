# Permissions — Campaign Monitor User

Defined in `campaignmonitor_user.permissions.yml`:

| Permission | Restrict access | Gates |
|---|---|---|
| `access campaign monitor user` | (not set) | The profile subscription page route `campaignmonitor_user.page` (`/user/{user}/campaignmonitor`). |

The admin settings form is gated by the parent module's `administer campaignmonitor` permission, not this one
(see [../configure/settings.md](../configure/settings.md)).
