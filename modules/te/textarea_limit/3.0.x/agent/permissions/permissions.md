# Permissions

Defined in `textarea_limit.permissions.yml`.

| Permission | Title | Guards |
|------------|-------|--------|
| `administer textarea_limit` | Administer Textarea Limit | The settings route `textarea_limit.settings` (`/admin/config/content/textarea-limit`), i.e. editing the `global_limit` config. |

This is the module's only permission. Note it is a distinct permission from
`administer site configuration`, so an editorial lead can be given the global limit without
broader admin rights.

Enabling the counter on a specific widget is not gated by this permission — that happens on
**Manage form display**, governed by core's own Field UI permissions (e.g.
`administer <entity> form display`).
