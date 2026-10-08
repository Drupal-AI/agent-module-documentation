# BAWstats — manual setup guide

**BAWstats** (`bawstats`) brings the reports produced by
[AWStats](https://www.awstats.org/) — a widely used server-log analysis tool —
into the Drupal admin. AWStats reads your web server's access logs and works out
who visited, which pages they looked at, and which sites referred them. Normally
you view those reports through AWStats' own interface; BAWstats surfaces them
inside Drupal instead, so an operator can see server-log-based web analytics
without leaving the site.

Because the numbers come from server logs rather than a JavaScript tag in the
page, they count things page-tag analytics miss (bots, file downloads, requests
that never ran JavaScript). AWStats itself must already be installed and
generating reports on the server; this module is the Drupal-side viewer, not the
analyzer.

Two permissions control access: **view site statistics** for people who should
see the reports, and **statistics admin** for administration. The module reads
AWStats' generated data from a path on the server, so that path should be set
carefully and kept out of public reach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

Note: the upstream docs for this module are thin (it is an early **2.0.0-alpha4**
release), so this guide describes only what is actually documented.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, BAWstats shows AWStats reports (visitors, pages, referrers) inside
the Drupal admin to anyone holding the **view site statistics** permission.
Administration is gated behind the **statistics admin** permission. Grant these
under **People → Permissions** (`/admin/people/permissions`) to the roles that
should see or manage the statistics.

## How to use it

1. Make sure AWStats is installed on your server and producing reports for the
   site's domain.
2. Enable BAWstats (see [Installation](installation/index.md)).
3. Grant **view site statistics** to the roles that should read the reports and
   **statistics admin** to whoever administers them.
4. Point the module at your AWStats data. Keep that path secure — it is
   server-side log analysis, not something that should be publicly reachable.
5. Open the statistics view in the admin to see visitors, pages and referrers.
