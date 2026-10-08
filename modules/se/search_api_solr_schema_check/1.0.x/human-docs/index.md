# Search API Solr Schema Check — manual setup guide

**Search API Solr Schema Check** (`search_api_solr_schema_check`) verifies that the
schema a Solr server is *actually running* matches a **canonical schema** you
define — typically the one committed to your git repository. It exists to catch a
quiet, expensive failure mode: schema drift.

Here's the problem it solves. Search API Solr generates a schema, someone deploys
it to Solr, and then over time the two diverge — a config change that was never
pushed, a manual edit made on the Solr side, a server rebuilt from an older schema.
Search keeps working, so nobody notices; results are just subtly wrong, until one
day a field stops being searchable or a boost silently disappears. The gap between
"the schema we intend" and "the schema Solr is running" is normally invisible from
Drupal. This module makes it visible: you point it at your source-of-truth schema
and it compares each configured Solr server's live schema against it, reporting
where they differ. That turns silent drift into a check you can read like a failing
test — "this server is not running the schema we think it is."

It is a **diagnostic, not a fix**: it tells you the schemas differ, not how to
reconcile them. Reconciliation is still a matter of deploying the correct schema to
Solr. It depends on **Search API Solr**, since it inspects that module's servers,
and works on Drupal 10.1 and 11. The project is minimally maintained but covered by
Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no dedicated settings screen with its own menu entry; the check reports
through Drupal's **Status report**. Point the module at the location of your
canonical Solr config in your repository, then go to **Reports → Status report**
(`/admin/reports/status`):

- If the files match, you'll see confirmation in the report — a "Checked" entry for
  each file and each configured server.
- If any file differs, you'll see an **Error** naming the server and the file that
  doesn't match.

Because it surfaces in the status report, you can read it on every deploy or wire
it into a scheduled check, and treat a mismatch exactly as you would a failing
test.
