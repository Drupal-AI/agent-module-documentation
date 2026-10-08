# Data Count — manual setup guide

**Data Count** (`data_count`) is a small statistics utility that counts the
nodes and users already on your site and shows the totals on a single admin
report. Instead of writing SQL or building a View just to answer "how much
content do we actually have?", you enable the module and read the numbers off a
page under **Reports**.

The report breaks the totals down in a way that is handy for content audits: it
shows the number of published and unpublished nodes per content type, and the
number of active and inactive users per role, with links to drill into each
group. It is deliberately lightweight — it reads aggregate counts only, it is
purely informational, and it plays no part in access control.

There is nothing to configure. The module works the moment you enable it, needs
no other modules beyond Drupal core, and requires no Views setup. It runs on
Drupal 8.8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.

## Where it lives in the admin menu

Once enabled, the report sits at **Reports → Data Count**
(`/admin/reports/data-count`). Open it to see the **Node Count Details** tab
(counts per content type) and the **User Count Details** tab (counts per role).
