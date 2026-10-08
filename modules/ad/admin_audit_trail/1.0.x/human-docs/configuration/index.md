# Configuration

Admin Audit Trail has a small settings form plus a report screen; most of the
"configuration" is really deciding which submodules to enable (covered in
[Installation](../installation/index.md)). This page covers the report, the
settings, and the permissions.

## The report

The main report is a View at **Reports → Audit trail**
(`/admin/reports/audit-trail`). It lists logged events with exposed filters for
**type**, **operation**, **user**, **IP address**, and a free-text **keyword**
search — so you can quickly answer "who did this?" for a given piece of content
or account. Reading it requires the **Access admin audit trail** permission.

Because it's a standard View, you can clone, re-theme, or extend it through the
Views UI if you want a custom report.

There is also a deprecated legacy report at
`/admin/reports/audit-trail/legacy` (controller-based, same permission) — prefer
the Views report above.

## Settings

Go to **Configuration → Development → Audit Trail → Settings**
(`/admin/config/development/audit-trail/settings`); this requires the **Configure
admin audit trail** permission. There are two settings:

- **Filter expanded** (`filter_expanded`, default off) — when on, the report's
  filter form shows expanded by default instead of collapsed.
- **Row limit** (`admin_audit_trail_row_limit`, default **0**) — the maximum
  number of rows kept in the log table. On every cron run the table is trimmed
  down to the most recent N rows. The default of **0** means *unlimited* — the
  table grows without bound, so on a busy site you should set a sensible limit
  (for example 10000) to keep the database from bloating.

You can also read or set these with Drush:

```bash
drush config:get admin_audit_trail.settings
drush config:set admin_audit_trail.settings admin_audit_trail_row_limit 10000 -y
drush config:set admin_audit_trail.settings filter_expanded 1 -y
```

## Permissions

Set these at **People → Permissions** (`/admin/people/permissions`):

| Permission | What it allows |
|------------|----------------|
| **Access admin audit trail** | View the logged events and the report. |
| **Configure admin audit trail** | Change the settings above. *Restrict to administrators.* |

## What actually gets logged

Remember that the base module logs nothing on its own — enable a submodule per
subsystem (see the table in [Installation](../installation/index.md)). Each
enabled submodule adds its event type to the report's filters and starts writing
rows for that subsystem's create/update/delete form submissions. And note that
CLI/Drush changes are never logged — only web-form submissions are recorded.
