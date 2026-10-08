# DB Log Filter — manual setup guide

**DB Log Filter** (`dblog_filter`) lets you control which log messages Drupal
actually writes, filtering by **severity level** and/or **log channel** — for the
database log and syslog independently. On a busy site, the *Recent log messages*
table fills up with low‑value `info`, `notice`, and `debug` entries; DB Log Filter
lets you drop that noise at the source, keeping the `dblog` table small and the
reports page fast. For example, you can log only `error` and worse, exclude a
chatty module's channel, or silence a deprecation warning you can't fix yet.

It works by quietly replacing Drupal's core database‑log and syslog logger
services with filtering subclasses. Before each message is written, a small filter
decides whether to keep it, based on your settings. Each of the two log
destinations (dblog and syslog) has its own rules: which severity levels to target,
per‑channel rules like `cron|info,notice,debug`, optional message‑text regex
matches, and a **method** of *include* (only matching messages are logged) or
*exclude* (matching messages are dropped). Severity is checked first; if that
doesn't decide it, the channel rules are consulted.

Out of the box, DB Log Filter is a no‑op: every severity is unchecked and the rule
lists are empty, so nothing is filtered and all messages log exactly as before. You
only start dropping messages once you configure it. Because filtering happens at
write time, it affects new log entries only — rows already stored are untouched, and
you can restore full logging at any time by clearing the settings. The module ships
config and schema only: it has **no permissions of its own** (the settings page uses
core's *Access site reports* permission), no plugins, and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the
   include/exclude method, severity levels, channel rules, and examples.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Reports → DB Log Filter settings**
(`/admin/reports/dblog-filter`). Access is controlled by core's **Access site
reports** permission — the same permission that guards the *Recent log messages*
report — not by a permission this module defines.
