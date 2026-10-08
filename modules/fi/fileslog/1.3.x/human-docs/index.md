# Private Files Logging — manual setup guide (1.3.x)

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
in the Drupal UI **and from the command line**, kept out of the database, pruned on
cron to a limit you set, and shippable by anything that can read files. Each event
becomes one `private://logs/{channel}/{timestamp}-{severity}.json` file, so logs
sort by timestamp and filter cleanly by channel and severity, and every entry has
its own detail page.

This 1.3.x branch adds two things over earlier releases: **cron‑based retention**
(a `max_items` limit prunes the oldest log files) and **two Drush commands** for
reading and clearing the logs. It also refuses to install alongside core's dblog or
without a private filesystem configured, and it closes a path‑traversal weakness
that was latent in earlier versions.

Two things are worth keeping in mind whenever you rely on this module. First, **the
private filesystem must genuinely be private** — if `file_private_path` is
misconfigured inside the web root, the log files become directly fetchable and the
permission check is bypassed. That is a deployment mistake rather than a module bug,
but it matters here. Second, **log entries carry request data** (paths, user ids,
IPs, referrers), so any backup or file sync that covers the private directory now
carries your logs with it — mind that for privacy and retention.

Version **1.3.0** runs on **Drupal 10.1 and 11**, requires **PHP 8.1+**, and
depends on core's **User** module. All of its pages sit behind the **Access site
reports** permission — the same one core's dblog uses.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, configure a
   private filesystem, disable dblog, and enable the module.
2. [Configuration](configuration/index.md) — set the `max_items` retention limit on
   core's logging‑settings form.

## Where it lives in the admin menu

Once enabled, the log viewer lives at **Reports → Recent log messages**
(`/admin/reports/fileslog`) — the same menu location as core's dblog. The overview
is a paged table you can **filter by channel and severity** (remembered per
session), with a **Clear** confirmation form and a detail page for every entry. The
one setting (retention) lives on core's **Logging and errors** page — see
[Configuration](configuration/index.md).

## How to use it

1. Confirm your site has a **private file path** configured and that **dblog is
   disabled** (see [Installation](installation/index.md)).
2. Enable the module. New log entries begin writing to `private://logs/…` as JSON
   files, one per event.
3. Read them at **`/admin/reports/fileslog`**, or from the command line:

   ```bash
   drush fileslog:show            # most recent entries (default 10)
   drush fileslog:show --count=50 --extended
   drush fileslog:delete          # clears all logs (no confirmation prompt)
   ```

4. Set the retention limit so cron trims old files — see
   [Configuration](configuration/index.md).
