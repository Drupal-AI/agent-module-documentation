# Cron Fail Alert — manual setup guide

**Cron Fail Alert** (`cron_fail_alert`) keeps an eye on your site's cron and emails
you when it stops running. Cron is easy to forget about — until it quietly breaks,
and search indexes go stale, queue items pile up unprocessed, caches never clear,
and scheduled tasks silently stop firing. This module catches that early: it
checks how long it has been since cron last ran successfully and, if that exceeds a
tolerance you set, sends an alert email so you can fix it before it affects your
users.

It is deliberately lightweight — no external services, no complex setup. Sensible
defaults (check every 15 minutes, consider cron failed after 20 minutes) work out
of the box, so the module is useful the moment you enable it. Everything else is
optional tuning on its settings form: how often to check, how much delay to
tolerate, who receives the alerts, and what the alert email says. To keep it easy on
performance, checks run on a schedule rather than on every page load, and built-in
validation ensures the tolerance is always greater than the check frequency so you
don't get false alarms.

It has no third-party dependencies and adds a permission for administering its
settings. Because the alert emails can contain operational detail about your site,
point them at an appropriate recipient (a site administrator or an ops mailbox).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   monitoring frequency, tolerance, and the notification email.

## Where it lives in the admin menu

Once enabled, the settings live at **Configuration → System → Cron → Cron Fail
Alert settings**, or navigate directly to
`/admin/config/system/cron-fail-alert`.
