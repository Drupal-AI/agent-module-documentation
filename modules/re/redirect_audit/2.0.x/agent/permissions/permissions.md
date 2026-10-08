<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `redirect_audit.permissions.yml`. The module ships exactly one permission.

| Permission | Machine name | Gates |
|---|---|---|
| Administer redirect audit | `administer redirect audit` | Everything the module exposes. |

Both routes in `redirect_audit.routing.yml` require it (`_permission: 'administer redirect audit'`):

- `redirect_audit.dashboard` → `/admin/config/search/redirect/audit` — view stats/results
  and run the **Audit**, **Fix** and **Clear** operations (each a form submit handler on
  `RedirectAuditDashboardForm`, so they are POST actions carrying a Drupal form/CSRF token).
- `redirect_audit.settings` → `/admin/config/search/redirect/audit/settings` — edit the
  config object.

There is no separate "view report" permission: reading the dashboard (which lists redirect
source/target paths and links to redirect edit forms) and mutating audit data are the same
grant. Grant it only to trusted administrators, alongside Redirect's own
`administer redirect` permission (the fix operation edits `redirect` entities and the
dashboard chain view links to `entity.redirect.edit_form`).

The three drush commands run in the CLI and are not gated by this permission (standard
drush access model).

## Dashboard

The audit report at `/admin/config/search/redirect/audit` (status message, Audit/Fix/Clear
buttons, and the paged results table once records exist):

![Redirect Audit dashboard report](../../../../../../../screenshots/redirect_audit/2.0.x/dashboard-report.png)
