# Events Logger — manual setup guide

**Events Logger** (`elogger`) records Drupal system events as its own log
entities — and, crucially, stores a **diff of what changed**, not just the fact
that something happened. Drupal's built‑in log tells you that an entity was
updated; Events Logger shows you *who* changed it, *when*, and *exactly which
fields* changed, which is the question an audit actually asks. It can track CRUD
actions on any type of entity as well as form submissions (including custom
forms), and it records the IP address and user agent for each tracked event.

You choose which modules' events to track and which forms to log, set system
messages (with token support) for those events, and browse everything through a
Views‑powered logs listing where you can filter, export, and act in bulk. You can
also cap how many log entries the system keeps, with a cron job pruning the rest.

The dependency list reflects this design: **Diff** provides the before/after
visualisation that is the whole point; **Views** powers the listing; **Views Data
Export** produces an auditor‑readable export; **Views Bulk Operations** lets you
act on entries in bulk; and **Token** supplies the tokens in the messages. Two
standing considerations apply to any audit log and are sharper here because diffs
are stored: **growth and retention** (diffs are large and nothing prunes them
unless you set a limit), and **sensitivity** — an audit trail of personal data is
itself personal data, so it needs the same lawful basis, retention, and access
treatment as the content it logs. Be mindful, too, of who holds the *delete*
permission, since that role can remove the evidence.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its contrib
   dependencies with Composer, and enable them.
2. [Configuration](configuration/index.md) — choose what to track, set log
   messages and retention, and view/export the logs.

## Where it lives in the admin menu

- **Logs listing:** **Reports → Events Logger** (`/admin/reports/elogger`).
- **Filter configuration:** `/admin/config/system/elogger`.
- **Log message configuration:** `/admin/config/system/elogger/log-messages`.

Access is governed by the module's own permissions — see Configuration.
