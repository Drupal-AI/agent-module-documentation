# Permissions

From `responsive_favicons.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer responsive favicons` | Access to the settings form (`responsive_favicons.admin` / `/admin/config/user-interface/responsive_favicons`) — uploading/pasting favicons and changing all options. Marked restricted (site-admin level). |

Grant via drush: `drush role:perm:add editor 'administer responsive favicons'`.

The dynamic icon-delivery routes (`/apple-touch-icon.png`, `/site.webmanifest`,
`/favicon.ico`, etc.) are registered with `_access: 'TRUE'` — publicly reachable, no
permission required, which is expected for favicon files.
