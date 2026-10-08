# Role Log — manual setup guide

**Role Log** (`role_log`) is a small, focused module that records **user role and
status changes** to Drupal's log. Every time a role is granted to or revoked from a
user — and every time an account is activated or blocked — an entry is written at
"info" severity to Drupal's event log (the PSR-3 logging interface formerly known as
*watchdog*).

Crucially, it catches these changes no matter how they happen: through the admin UI,
through Drush or Drupal Console, or programmatically from custom code. That gives you
an audit trail of privilege changes — who gained or lost which role, and when — which
is valuable for security monitoring and accountability. The module only *writes* log
entries; it never changes roles or access itself.

You view the entries with either the **Database Logging** or **Syslog** module from
core. The module works on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration** — the module starts logging role and status changes as
soon as it is enabled.

## How to use it

1. Make sure a log viewer is available — enable core's **Database Logging** (`dblog`)
   or **Syslog** module if it is not already.
2. Grant or revoke a role for a user (or block/activate an account).
3. View the entry at **Reports → Recent log messages** (`/admin/reports/dblog`) if
   you use Database Logging, or in your system log if you use Syslog.

For the audit trail to be useful it has to be *watched* — pair Role Log with regular
log review, or forward your logs to a monitoring system (for example a SIEM), so that
unexpected privilege changes are actually noticed.
