# Permission Watchdog — manual setup guide

**Permission Watchdog** (`permission_watchdog`) records every change made to a
role's permissions to Drupal's log, so an administrator can audit the full
history of who changed which role's permissions, and when.

This fills a genuine gap. A silent change to a role's permissions — quietly
granting an editor an administrative capability, or loosening access somewhere —
is exactly the kind of high-impact configuration change that should never go
unnoticed, and Drupal does not log it by default. Permission changes are among
the most consequential settings on a site, and a compromised or careless
administrator changing them is a classic privilege-escalation path. Having a
record lets you answer "what did this role hold at that point in time?" after the
fact, which is invaluable for sites with security-audit requirements.

Treat the log as sensitive: it reveals your site's permission structure and its
change history, so keep it restricted to trusted operators. And treat an
unexpected permission-change entry as a signal worth investigating — it may be the
first sign of an incident. It pairs well with related modules like Role Watchdog
(which tracks changes to users' roles) and Role Change Notify.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** — logging begins automatically once the module is
enabled.

## Where it lives in the admin menu

Permission Watchdog adds no admin page of its own. It writes its entries to
Drupal's logging system, so you review them at **Reports → Recent log messages**
(`/admin/reports/dblog`, provided by core's Database Logging module). Look for
the entries describing role permission changes, and keep access to the reports
restricted to trusted operators.
