# Redirect Audit — manual setup guide

**Redirect Audit** (`redirect_audit`) inspects the redirects on your site for the
problems that quietly accumulate in any long-lived redirect table and reports them
on a dashboard. The core Redirect module lists source and destination but never
checks whether a redirect still makes sense — so over the years you end up with
redirects pointing at pages that were later deleted, **chains** (A → B → C) that
cost every visitor an extra hop, and **loops** (A → B → A) that fail outright.
This module adds the checking, and offers to fix what it safely can.

It detects chains and loops automatically, shows the complete redirect paths on a
visual dashboard with summary statistics, and can resolve chains in bulk with a
single click — rewriting each source redirect straight to its final destination.
Loops are flagged for manual review rather than auto-fixed, because there is no
safe automatic answer to a circular reference. For large redirect tables the work
runs through Drupal's Batch API so it does not time out, and you can tune how deep
it follows chains and how many redirects it processes per batch.

Two practical notes. First, **auditing makes requests** — checking thousands of
redirects means thousands of checks, so on a big table this is real traffic;
prefer running it off-peak and mind the batch size. Second, **results are a
snapshot**: a redirect that resolved cleanly today can break next week when its
target is unpublished, so re-audit on a schedule rather than treating one clean
run as a permanent answer. Usefully, the module ships with its **own** permission
rather than reusing Redirect's, so auditing can be delegated to an SEO role
without also granting the ability to edit redirects.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Redirect
   module it depends on, and enable it.
2. [Configuration](configuration/index.md) — the audit settings (scan-on-change,
   auto-fix, batch size, chain depth) and how to run and read the dashboard.

## Where it lives in the admin menu

- **Dashboard:** `/admin/config/search/redirect/audit` — the summary statistics,
  the results table of chains and loops, and the Audit / Fix / Clear actions.
- **Settings:** `/admin/config/search/redirect/audit/settings`.

Both pages are gated by the module's own **administer redirect audit** permission.
