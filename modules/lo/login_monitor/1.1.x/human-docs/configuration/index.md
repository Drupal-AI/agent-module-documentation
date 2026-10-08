# Configuration

Login Monitor begins logging login activity as soon as it is enabled. The
configuration work is about deciding **what to be notified of**, **what reports to
send**, **how long to keep the data**, and **who may see it**.

## Open the settings form

1. Log in as an administrator.
2. Go to Login Monitor's settings page in the admin **Configuration** area (config
   route `login_monitor.settings`).

## What gets logged

Login Monitor records, out of the box:

- **Successful logins**, including logins via one‑time login links.
- **Failed login attempts**, distinguishing invalid users, valid users, and
  blocked users.
- **Logout events.**

Each event stores the **IP address**, **user agent**, and **timestamp**. Treat
these as personal data.

## Email notifications

Configure real‑time email alerts for login events:

- **Recipients** — set the customizable recipient address(es) for notifications.
- **Email templates** — the message bodies support **tokens** (this is why the
  Token module is required), so you can include event details in the text.
- **Role‑based filtering** — limit notifications to logins by particular roles, so
  you're alerted about, say, administrator logins without noise from every visitor.

## Statistical reports

Schedule periodic summary emails:

- **Frequency** — **daily**, **weekly**, or **monthly**.
- **Content** — login activity summaries and statistics, plus failed‑attempt
  analysis and user‑activity patterns.

To send a report immediately (for testing or an off‑schedule send), run the Drush
command `drush login-monitor:send-reports`.

## Data management and retention

Because every event is stored, decide how much history to keep:

- **Log retention period** — how long entries are kept.
- **Automatic cleanup** — old entries are removed once past the retention period.
- **Bulk operations** — manage (including delete) log entries in bulk from the
  admin listing.

Setting a sensible retention period is both a housekeeping measure (the table
doesn't grow without bound) and a privacy measure (you don't hold IP/user‑agent
data longer than you need).

## Permissions — who can see the logs

Login Monitor defines its own permissions. Grant them at **People → Permissions**
(`/admin/people/permissions`) only to trusted administrators, since the event
listings and reports expose IP addresses and user agents.

## The admin listing

The administrative interface shows a **filterable and sortable** list of login
events with detailed information (including IP address and user agent), so you can
investigate a specific user, time window, or pattern of failed attempts.

## Save

Click **Save configuration** after adjusting notifications, reports, and retention.
