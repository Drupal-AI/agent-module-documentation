# Maintenance Notifier — manual setup guide

**Maintenance Notifier** (`maintenance_notifier`) sends an email alert when your
site has been in maintenance mode for longer than a threshold you set. It exists
to catch the classic operations mistake: a site left in maintenance mode after a
deployment, quietly offline, with nobody noticing. With this module enabled, the
right people get an email once the site has been down for, say, thirty minutes.

The alerts are flexible. You choose a **time threshold** (in minutes) that the
site must be in maintenance mode before an email goes out, and you pick the
recipients — either a comma-separated list of specific email addresses, or all
users holding particular roles. The email's **subject and body** are fully
customisable and support **tokens**, so you can drop in dynamic values like the
site name or the current date, with a token browser to help you pick them.

The check runs automatically on every **cron** run. There's also a **Drush
command** (`drush maintenance-notifier:check`, or the short alias `drush mnc`) to
run the check by hand whenever you want.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   Token module) and enable it.
2. [Configuration](configuration/index.md) — set the threshold, recipients, and
   email subject/body.

## Where it lives in the admin menu

Configure the notifications on the module's settings form under **Configuration**
(in the administration area). Because notifications fire on cron, make sure your
site's cron is running regularly for the alerts to be timely.
