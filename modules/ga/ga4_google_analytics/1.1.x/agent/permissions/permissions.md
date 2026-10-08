<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

The module defines a single permission in `ga4_google_analytics.permissions.yml`:

| Permission string | Title | Gates |
|---|---|---|
| `ga4 configre` | GA4 Google Analytics Settings | Access to the settings form route `ga4_google_analytics.configure` (`/admin/config/services/ga4-google-analytics`). |

Note the machine name is the misspelled **`ga4 configre`** (not `ga4 configure`) — use it
exactly when granting via `user.role.*` config or `drush role:perm:add`:

```bash
drush role:perm:add content_editor 'ga4 configre'
```

This is a "restrict access" permission (editing it exposes site-wide tracking markup), so grant
it only to trusted roles. There are no other permissions and no per-entity access checks.
