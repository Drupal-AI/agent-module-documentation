# Private Files Logging — manual setup guide (1.2.x)

**Private Files Logging** (`fileslog`) writes Drupal's log entries to files in the
**private filesystem** instead of to the database. It is a drop‑in alternative to
core's **dblog** — it adds a "Recent log messages" link to the same reports menu
and a nearly identical viewer at **`/admin/reports/fileslog`** — but the entries
live on disk rather than in your database.

Why choose it? Core gives you two logging destinations and neither suits every
site. **dblog** writes to the database on every request, is capped by row count so
older entries eventually disappear, and travels with your content backups.
**syslog** hands entries to the operating system, which is ideal when there is
somewhere for them to go — and no help at all on shared hosting or in a container
with no log collector. Files in the private directory sit between the two: readable
in the Drupal UI, kept out of the database, retained on the filesystem's terms, and
shippable by anything that can read files. Each entry is stored as
`private://logs/[category]/[timestamp]-[severity].json`, so logs sort by timestamp
and filter cleanly by category and severity, and every entry has its own detail
page.

Two things are worth keeping in mind whenever you rely on this module. First, **the
private filesystem must genuinely be private** — if `file_private_path` is
misconfigured inside the web root, the log files become directly fetchable and the
permission check is bypassed. That is a deployment mistake rather than a module bug,
but it matters here. Second, **log entries carry request data** (paths, user ids,
sometimes parameters), so any backup or file sync that covers the private directory
now carries your logs with it — mind that for privacy and retention.

Version **1.2.5** runs on **Drupal 10.1 and 11**. All of its pages sit behind the
**Access site reports** permission — the same one core's dblog uses.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, configure a
   private filesystem, and enable the module.

This 1.2.x branch has **no settings form of its own**. Its "configure" link simply
opens core's **Logging and errors** page (**Configuration → Development → Logging
and errors**); the important prerequisite — a working private filesystem — is a
site‑level setting covered in [Installation](installation/index.md).

## Where it lives in the admin menu

Once enabled, the log viewer lives at **Reports → Recent log messages**
(`/admin/reports/fileslog`) — the same menu location as core's dblog. Each entry
links to its own canonical detail page. There are also Drush commands to show and
delete logs.

## How to use it

1. Confirm your site has a **private file path** configured (see
   [Installation](installation/index.md)).
2. Enable the module. New log entries begin writing to `private://logs/…` as JSON
   files.
3. Read them at **`/admin/reports/fileslog`**, filtering by category and severity,
   or clear them from the admin UI.

> **Tip:** Because this branch does not prune logs automatically, plan a retention
> approach — for example periodic clearing from the UI or Drush — so the private
> logs directory does not grow without bound.
