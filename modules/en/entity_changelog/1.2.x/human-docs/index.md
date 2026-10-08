# Entity Changelog — manual setup guide

**Entity Changelog** (`entity_changelog`) records a **changelog of CUD operations**
— create, update, and delete — on entities, giving administrators an audit trail of
what changed, when, and by whom. It provides a **View** for browsing those log
entries, so you can see the history of content changes on your site.

It depends on core **Views** (used to display the log) and provides its own
permissions to gate who can see the changelog. The log can contain sensitive detail
about content and who edited it, so treat it as admin-only and grant its viewing
permission to trusted roles only.

There is **currently no configuration** for the module — it logs entity CUD
operations out of the box. Housekeeping is automatic: changelog entries older than
three years are removed by cron. The changelog View exposes a timestamp filter for
narrowing entries by date; in Drupal core that filter renders as a plain text field,
so you may wish to pair it with a date-picker module for a friendlier experience. It
requires **Drupal 10 or 11** and **PHP 8.1+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the viewing permission.

There is **no configuration page** for this module — it states plainly that there is
currently no configuration. Logging begins automatically once the module is enabled.

## Where it lives in the admin menu

The module provides a **changelog View** for browsing the recorded create/update/
delete entries. Access to it is controlled by the module's own permission — grant it
only to trusted administrators.

## How to use it

1. Grant the changelog viewing permission (under **People → Permissions**) to the
   roles that should see the audit trail.
2. Let the site run — as content is created, updated, and deleted, entries are
   logged automatically.
3. Open the changelog View to see who changed what and when. Use its exposed
   timestamp filter to narrow the list by date. (For a nicer date input, consider a
   date-picker module, since core renders the filter as a plain text field.)
4. No cleanup is required: entries older than three years are pruned automatically
   on cron.
