# Configuration

Node Revision Health is mostly used through its reports and maintenance tools
rather than a large settings form. This page walks through what you will find and
how to grant access safely.

## Permissions — grant these first

Node Health defines two permissions, and the split matters:

- **View node health reports** — read‑only access to the reports, charts, and
  exports. Safe to grant to anyone who needs visibility into revision growth.
- **Administer node health** — access to the **destructive** maintenance tools
  (bulk revision deletion, dropping orphaned tables, table optimization). This is a
  restricted permission; grant it only to trusted administrators.

Set these at **People → Permissions** (`/admin/people/permissions`).

## The reports

- **Node Health Report** (`/admin/reports/node-health`) — an overview of content
  types, field storage, and revision counts, with table size and row counts for
  node and revision tables. Use the filters to narrow by content type, node ID,
  title, or revision count.
- **Revision Report** (`/admin/reports/node-health/revisions`) — a per‑node view of
  how many revisions each node has accumulated, so you can spot the worst
  offenders. You can delete a single node's old revisions directly from here (this
  action is CSRF‑protected).
- **Table Size Charts** (`/admin/reports/node-health/charts`) — visualizations of
  table‑size growth over time and of which content types drive revision‑table
  bloat. These rely on data gathered during cron runs, so they fill in gradually.
- **Exports** — table sizes can be exported to CSV for capacity planning.

## The maintenance tools

Reached from the Node Health section (and each mirrored by a Drush command):

- **Bulk revision cleanup** — delete old node revisions beyond a chosen minimum, in
  a batch, to shrink the revision tables.
- **Orphaned table detection and drop** — find `node_r__*` revision tables left
  behind when fields were removed, and drop the confirmed orphans. As a safety
  measure the drop operation only accepts names prefixed `node_r__`, and all table
  names used in raw SQL are validated against the live database schema first.
- **Table optimize** — run `OPTIMIZE TABLE` on selected tables to reclaim space
  after large deletions.
- **Log management** and a **queue processor** — clean the module's own logs and
  process large cleanup jobs through a queue so they do not time out on big sites.

Every destructive operation requires the **Administer node health** permission.

## The settings form

A settings form is available at **Reports → Node Health → Settings**
(`/admin/reports/node-health/settings`) for tuning the module's behavior. Review it
after installing to confirm the defaults suit your site.

## Using Drush

All of the reporting and maintenance actions have matching Drush commands, so you
can run revision cleanup, orphaned‑table maintenance, and table optimization from
the command line as part of scheduled operations rather than clicking through the
UI. Run `drush list` after enabling the module to see the available `node_health`
commands.

## Ongoing operation

Keep cron running regularly so the historical size data — and therefore the charts
— stay current, and revisit the reports periodically to catch tables that are
growing faster than expected. Pairing Node Health's reporting with an automatic
pruning module such as **Node Revision Limit** gives you both visibility and
prevention.
