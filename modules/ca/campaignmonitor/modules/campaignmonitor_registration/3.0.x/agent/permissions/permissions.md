# Permissions — Campaign Monitor Registration

Defined in `campaignmonitor_registration.permissions.yml`:

| Permission | Restrict access | Documented purpose |
|---|---|---|
| `access campaignmonitor registration` | `TRUE` | "Allow user to subscribe to lists on the registration page." |

This permission is declared but is **not referenced** by the module's code: the opt-in fields are added to
the user registration form unconditionally, and the admin settings form is gated by the parent's
`administer campaignmonitor` permission (see [../configure/settings.md](../configure/settings.md)). Access to
the registration form itself is governed by Drupal core's account-registration settings.
