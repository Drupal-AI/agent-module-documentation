# Login Monitor — manual setup guide

**Login Monitor** (`login_monitor`) gives administrators a comprehensive view of
who is logging into the site, when, and from where. It logs **successful logins**
(including one‑time login links), **failed login attempts** (invalid users, valid
users, and blocked users), and **logout events**, recording the IP address, user
agent, and timestamp for each. On top of the log it adds configurable **email
notifications** for login events and periodic **statistical reports**.

Think of it as a purpose‑built security‑monitoring tool. Tracking logins helps you
spot compromised accounts, brute‑force attempts, and unusual access patterns, and
real‑time notifications alert you (or the user) to unexpected logins as they
happen. Reports can be scheduled daily, weekly, or monthly and summarise login
activity and failed‑attempt analysis.

The module provides an administrative interface with filterable, sortable event
listings, role‑based filtering for notifications, token‑enabled email templates,
and data‑management tools — configurable log retention, automatic cleanup of old
entries, and bulk operations. A Drush command,
`drush login-monitor:send-reports`, manually triggers the statistical reports,
which is handy for testing or for sending a report outside the normal schedule.

Login Monitor **monitors** — it doesn't block logins by itself. And because login
logs record IP addresses and user agents, they are **personal data**: handle them
according to your privacy obligations and restrict the reports and listings to
trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and satisfy its Token/Views requirements.
2. [Configuration](configuration/index.md) — set up logging, notifications,
   reports, retention, and permissions.

## Where it lives in the admin menu

Login Monitor's settings live at its configuration route
(`login_monitor.settings`), reached from the admin **Configuration** area. It
defines its own permissions (grant them at **People → Permissions**) so you can
limit who sees the login event listings and reports.
