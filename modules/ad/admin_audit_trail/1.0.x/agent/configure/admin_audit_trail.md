# Configure — Admin Audit Trail

## Report & routes
- **Report (primary):** `/admin/reports/audit-trail` — a View (`views.view.admin_audit_trail`, installed from `config/optional/`) with exposed filters (type, operation, user, IP, keyword). Requires permission `access admin audit trail`.
- **Legacy report:** `/admin/reports/audit-trail/legacy` (controller-based, deprecated; same permission).
- **Settings form:** `/admin/config/development/audit-trail/settings` (route `admin_audit_trail.settings`, permission `configure admin audit trail`).

## Permissions (`admin_audit_trail.permissions.yml`)
- `access admin audit trail` — view the logged events / report.
- `configure admin audit trail` — change the settings below.

## Settings (`admin_audit_trail.settings`)
Config object with two keys (schema in `config/schema/admin_audit_trail.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `filter_expanded` | boolean | `false` | Show the report's filter form expanded by default. |
| `admin_audit_trail_row_limit` | integer | `0` | Max rows kept in the table. `0` = unlimited (no pruning). |

Read/set via drush:
```bash
drush config:get admin_audit_trail.settings
drush config:set admin_audit_trail.settings admin_audit_trail_row_limit 10000 -y
drush config:set admin_audit_trail.settings filter_expanded 1 -y
```

## Pruning (cron)
`admin_audit_trail_cron()` trims the `admin_audit_trail` table down to the most recent
`admin_audit_trail_row_limit` rows on every cron run. With the default `0` the table grows
unbounded — set a limit on busy sites.

## What actually gets logged
The base module logs nothing by itself. Enable a submodule per subsystem:
```bash
drush en admin_audit_trail_node admin_audit_trail_user -y
```
Each submodule adds an event *type* to the report's filters and starts writing rows for that
subsystem's create/update/delete form submissions.
