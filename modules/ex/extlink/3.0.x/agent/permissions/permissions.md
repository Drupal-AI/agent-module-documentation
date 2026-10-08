# Permissions

Defined in `extlink.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer extlink` | Access to the settings form (`/admin/config/user-interface/extlink`, route `extlink_admin.settings`). Marked `restrict access: TRUE` (trusted). |

That is the only permission. The public-facing decoration runs client-side for every
visitor and is not permission-gated. The `/extlink/settings.js` route has its own
`_custom_access` check that only allows the file when the external-JS-file option is enabled.

Grant via drush:
```
drush role:perm:add content_admin 'administer extlink'
```
