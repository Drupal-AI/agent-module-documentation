# Node Revision Health — manual setup guide

**Node Revision Health** (`node_health`) is an administrative reporting and
maintenance suite for node revisions and the revision‑related database tables it
generates. On a long‑lived editorial site, node revisions and the per‑field
`node_r__*` tables quietly accumulate until they dominate your database size. This
module gives you the reports to *see* that growth and the tools to *do something*
about it — bulk revision cleanup, detection and dropping of orphaned revision
tables left behind by removed fields, and table optimization to reclaim space.

Out of the reports it provides a main **Node Health Report**, a per‑node
**Revision Report**, an explorer for revision/field usage, and **charts** that
track table‑size growth over time. The maintenance side offers batch cleanup of
old revisions, orphaned‑table detection and removal, `OPTIMIZE TABLE` operations,
log management, and a queue processor for large sites. Every action is also
available as a **Drush command**, so you can script routine maintenance.

Access is split into a read‑only reviewer role and a destructive‑admin role by two
permissions, and the destructive operations are guarded carefully (for example,
table names interpolated into raw SQL are validated against the live schema, and
orphaned‑table drops are restricted to `node_r__`‑prefixed names). It has **no
module dependencies** beyond core, but it does rely on cron and on the database
user having access to `information_schema` to gather table‑size data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and confirm cron and database prerequisites.
2. [Configuration](configuration/index.md) — the reports, the maintenance tools,
   permissions, and the settings form.

## Where it lives in the admin menu

Everything lives under **Reports → Node Health** (`/admin/reports/node-health`):

- **Node Health Report** — `/admin/reports/node-health`
- **Revision Report** — `/admin/reports/node-health/revisions`
- **Table Size Charts** — `/admin/reports/node-health/charts`
- **Settings** — `/admin/reports/node-health/settings`
