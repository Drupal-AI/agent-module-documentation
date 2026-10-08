# Link Checker Per Node — manual setup guide

**Link Checker Per Node** (`linkchecker_per_node`) adds a per-node broken-links
report to Drupal. It builds on the [Link
Checker](https://www.drupal.org/project/linkchecker) module — Link Checker does
the actual scanning of your content's links and records which ones are broken;
this module surfaces those findings **one node at a time**, so an editor looking
at a single page can see exactly which of *its* links are dead.

Concretely, it installs a View named `broken_links_per_node_report` and adds a
**Broken Links** local task (tab) to node pages. Click that tab on any node and
you land on `node/{node}/broken-links`, a table of the broken-link records for
that node — status code, URL, and when each link was last checked. It provides a
permission so you can decide which roles are allowed to see the report.

Because it depends entirely on Link Checker for the underlying data, install and
configure Link Checker first (that's where the scanning schedule and options
live). This module simply gives each node its own view onto the results.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable
   alongside Link Checker, and grant the report permission.

There is **no dedicated settings form**. The report is a View
(`views.view.broken_links_per_node_report`), so if you want to change its
columns, filters, or layout you edit it in the **Views UI** at **Structure →
Views**. Access is controlled by a permission (see below).

## Where it lives in the admin menu

The report is not a central admin page — it appears **on each node**. Open any
node and click the **Broken Links** local task tab
(`node/{node}/broken-links`) to review that node's broken links.

## How to use it

1. Make sure **Link Checker** is installed, configured, and has run at least
   once (it checks links on cron), so there is data to report on.
2. Grant the **View broken links per node** permission at **People →
   Permissions** to the roles that should see the report (editors,
   administrators).
3. Open a node and click its **Broken Links** tab to review the broken-link
   table (status code, URL, and check timestamps) for that node.

> **Uninstall note:** removing this module deletes its View configuration
> (`views.view.broken_links_per_node_report`). Your Link Checker data itself is
> untouched.
