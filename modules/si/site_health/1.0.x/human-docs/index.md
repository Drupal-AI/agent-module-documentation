# Site Health — manual setup guide

**Site Health** (`site_health`), by miniOrange, helps administrators and developers
keep an eye on the performance and stability of a Drupal site by **monitoring its
database queries**. It logs and analyzes the queries running behind the scenes, so you
can see what your site is actually asking of the database and catch bottlenecks before
they start hurting real visitors.

Out of the box it gives you slow-query detection (with a configurable execution-time
threshold), query-frequency analysis, and a dashboard of summary statistics — most
frequent queries, average execution time, and the slowest queries. You can filter and
search queries by type (SELECT, INSERT, UPDATE, DELETE), execution time, or the module
they came from, and export the query data into structured reports for an audit or a
debugging session.

The module works after enabling — it starts tracking queries and building its reports —
and depends only on core **System**. It adds its own permission to gate who can see the
diagnostics. Two practical cautions worth keeping in mind: the query monitoring can
surface **query text, which may contain data**, so keep the reports restricted to
developers and administrators; and while the module is designed to add no meaningful
processing overhead, heavy query monitoring is generally best kept to development and
staging rather than left running on production indefinitely.

This guide is written for a **human** using the module through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling, grant the module's permission to the developer/administrator roles that
should see the data, then open its **dashboard** to review the summary statistics —
most frequent queries, average execution time, and slowest queries. Use the filters to
narrow queries by type, execution time, or originating module, set the slow-query
threshold to match your performance target, and export a report when you need a record
for an audit or debugging. Because the reports can include query text (and therefore
potentially sensitive data), keep access limited and prefer running heavy monitoring on
dev or staging.
