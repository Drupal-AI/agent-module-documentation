# Simple 404 Logger — manual setup guide

**Simple 404 Logger** (`simple_404_logger`) is a lightweight module that records
every **404 (Page Not Found)** request your site serves and gives you a clean,
minimal admin report to review them. It is aimed at developers and site builders
who want a fast, no-fuss way to spot broken links without the overhead of a full
404-management or redirect system.

The module needs **zero configuration** — it starts logging the moment you enable
it. Behind the report it aggregates hits per path (so a repeatedly-missed URL
shows a running count rather than one row per hit), tracks the last time each path
was requested, paginates the report, includes basic spam protection against
duplicate entries, and lets you clear the log with a confirmation step. It depends
only on core's **System** module and has no submodules.

It deliberately does *not* do redirect automation, suggestions, analytics, or
advanced filtering — if you need those, the docs point you to the *Smart 404*
module instead. Simple 404 Logger focuses on simplicity and performance, which
makes it a good fit for small-to-medium sites and development environments.

One thing to keep in mind: a 404 log records **requested URLs**, and can include
referrers and IP addresses, which may amount to personal data — and the table can
grow quickly if your site is being scanned or attacked. Prune old entries
periodically (the report's *Clear logs* action helps), keep only what you need,
and make sure the report is only reachable by trusted, permitted users. The module
itself plays no access-control role. Note also that this project is **not covered
by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings form. Once enabled, view the collected 404s at **Reports →
Simple 404** (under `/admin/reports`). Visit any non-existing URL — for example
`/test-404` — and it will appear in the report with its hit count and last-access
time. Use the report's *Clear logs* action to prune the table when it grows.
