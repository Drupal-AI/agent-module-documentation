<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — Commerce Reporting

Defined in `commerce_reports.permissions.yml`:

| Permission | Gates |
|---|---|
| `access commerce reports` | The Reports overview and each report-type table under `/admin/commerce/reports`. |
| `generate commerce order reports` | The "Generate reports" form (`/admin/commerce/config/reports/generate-reports`) that deletes and rebuilds order reports. |

Since `commerce_reports_update_10000`, the `commerce_order_report` entity also uses `entity`'s
`EntityPermissionProvider`, which generates standard per-entity permissions (e.g.
`administer commerce_order_report`, `view any commerce_order_report`, etc.) — these come from
the entity type, not the permissions.yml file.

```bash
drush role:perm:add store_analyst 'access commerce reports'
drush role:perm:add store_analyst 'generate commerce order reports'
```
