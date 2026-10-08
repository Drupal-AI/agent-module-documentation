# Login History — manual setup guide

**Login History** (`login_history`) keeps a record of every successful login on your
site. Each time a user signs in, it stores a row with the timestamp, the IP address
they came from, their browser (user agent), and whether the login used a one‑time
password‑reset link. That gives you a lightweight audit trail — useful for spotting
suspicious access, troubleshooting with a helpdesk, or satisfying a compliance
requirement — without standing up a heavier logging stack.

The data is surfaced in several ways. Administrators get a site‑wide report at
**Reports → Login history**, and every user can review their own logins at
`/user/{uid}/login-history`. Because the login data is registered as a Views base
table, you can also build your own custom reports — filter by user, date range, or
IP, export to CSV, or relate users to their logins. A **"Last login"** block can show
returning users when and where they last signed in, which is a nice reassurance cue.

To keep the table from growing without bound, a single setting caps how many login
rows are kept per user (50 by default). Old rows are pruned automatically — both at
login time and on cron — and a user's history is deleted along with their account.
Three permissions control who can see what: your own history, everyone's history, and
the settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (Views is the only dependency).
2. [Configuration](configuration/index.md) — the retention setting, the reports, the
   three permissions, and the "Last login" block.

## Where it lives in the admin menu

- **Settings:** **Configuration → People → Login history**
  (`/admin/config/people/login-history`).
- **Site‑wide report:** **Reports → Login history**
  (`/admin/reports/login-history`).
- **Per‑user history:** `/user/{uid}/login-history`.
- **"Last login" block:** placed from **Structure → Block layout**.

## How to use it

Enable the module and it starts recording logins immediately — there is nothing you
*must* configure. Then grant the permissions to the right roles, optionally adjust
how many rows to keep per user, and place the "Last login" block if you want it. See
[Configuration](configuration/index.md) for the details.
