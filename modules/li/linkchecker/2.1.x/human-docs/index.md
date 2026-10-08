# Link checker — manual setup guide

**Link checker** (`linkchecker`) keeps an eye on the hyperlinks in your content
and tells you when they break. Whenever you save a piece of content, it pulls out
the links it contains; then, on a schedule driven by cron, it revisits each one
and records the HTTP response. Anything that comes back broken — a 404, a server
error — is collected into a single **Broken links** report so you can fix or
remove it.

It checks both internal links (to other pages on your own site) and external
links (to other websites), and it can look inside more than just body text: as
well as ordinary `<a>` links it can be told to check images, iframes and embedded
audio, video and other media sources. You decide which fields on which content
types get scanned by ticking a box on the field's settings, so the module never
crawls more than you want it to.

Beyond reporting, Link checker can take action on what it finds. It can be
configured to automatically unpublish content whose links keep returning 404, or
to rewrite links that have been permanently moved (a 301 redirect) to their new
address. It also ships Drush commands for re‑checking or clearing links from the
command line, and it is extensible — developers can add plugins to pull links from
custom field types or to react to other response codes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choosing which fields to scan, the
   settings form, cron‑based checking, and the report.

## Where it lives in the admin menu

- The settings form is at **Configuration → Content authoring → Link checker**
  (`/admin/config/content/linkchecker`).
- The results are at **Reports → Broken links** (`/admin/reports/linkchecker`).
- The choice of *which* fields to scan is made on each field's own settings form,
  under a **Link checker settings** section.

## How to use it

1. Enable the module and grant the relevant permissions (see
   [Installation](installation/index.md)).
2. On the content types you care about, open the fields that hold links (for
   example the Body field) and tick **Scan broken links**, choosing an extractor.
3. Adjust the global options — which links to check, HTTP behaviour, how often to
   re‑check — on the settings form if the defaults do not suit you.
4. Let cron run (or run it manually). As links are checked, broken ones appear in
   the **Broken links** report for you to act on.
