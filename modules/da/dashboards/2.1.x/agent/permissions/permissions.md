<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Static permission (`dashboards.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer dashboards` | The dashboards admin UI (`/admin/structure/dashboards`), add/edit/delete/Layout Builder forms, and the settings form. It is also the `dashboard` entity's `admin_permission`. |

## Dynamic per-dashboard permissions

`permission_callbacks` → `Drupal\dashboards\DashboardsPermissions::permissions()` generates **two
permissions per dashboard entity**:

- `can view <dashboard_id> dashboard` — view that dashboard's canonical page.
- `can override <dashboard_id> dashboard` — "Personalize": create/edit a personal, user-specific copy of
  that dashboard (via `UserDashboardSectionStorage`).

So creating a dashboard `ops_overview` yields `can view ops_overview dashboard` and
`can override ops_overview dashboard`. Each carries a config dependency on its dashboard.

Grant with drush:

```bash
drush role:perm:add editor 'can view ops_overview dashboard'
drush role:perm:add editor 'can override ops_overview dashboard'
```

Access to a dashboard is enforced by `DashboardAccessControlHandler` (used e.g. by the toolbar tray,
which only lists dashboards the current user may view).
