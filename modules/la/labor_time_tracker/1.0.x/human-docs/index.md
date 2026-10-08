# Labor Time Tracker — manual setup guide

**Labor Time Tracker** (`labor_time_tracker`) is a simple time‑and‑attendance
system for teams working inside Drupal. Each collaborator clocks in when they
arrive and clocks out when they leave, and the module records those enter/exit
timestamps and automatically calculates the duration between them. Managers get a
list of all time logs and a company‑wide labor report; collaborators can request
corrections to their own logs, which a manager then approves or rejects.

Two entity types do the work. **Time logs** hold the user, the enter and exit
timestamps, and a calculated duration. **Time log requests** reference an existing
time log and carry proposed enter/exit dates, a reason for the change, and a status
that a manager must approve before the change is applied. This keeps an audit trail
rather than letting people silently edit their own recorded hours.

It depends on the **Admin Toolbar** and **Honeypot** modules and requires Drupal
11.3 or newer. Two permissions govern it: **administer labor time tracker** for
managers who configure the system and manage logs and requests, and **view labor
times** for viewing recorded times.

A note on privacy: attendance records are **personal data**. Handle them in line
with your organisation's privacy policy and any applicable regulations, and grant
the viewing and administration permissions only to the people who genuinely need
them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Admin Toolbar and Honeypot.
2. [Configuration](configuration/index.md) — set the expected daily hours, manage
   logs and change requests, read the labor report, and assign permissions.

## Where it lives in the admin menu

Collaborators use two front‑end pages:

- **`/labor-info/time-log`** — a page with an action button to register entry and
  exit times when arriving at or leaving work.
- **`/labor-info/time-log-request`** — a form to request a change to a time log,
  with a table below showing the status of requests already made.

Managers (users with **administer labor time tracker**) use the admin pages under
**Configuration → Labor time**: settings, the log list, the request list, and the
report — all detailed in [Configuration](configuration/index.md).
