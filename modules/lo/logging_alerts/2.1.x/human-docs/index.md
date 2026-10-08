# Logging and alerts — manual setup guide

**Logging and alerts** (`logging_alerts`) is a small collection of modules that
send Drupal's log (watchdog) messages somewhere *other* than the database, so your
logs can become alerts and can join your wider infrastructure logging. It ships
**two** modules, and you enable the one(s) you want:

- **Email Logging and Alerts** (`emaillog`) routes watchdog messages to email
  addresses based on their **severity**. For example, emergency and critical
  messages can go to an on‑call address (or a pager/mobile email), while notices
  and debug messages go nowhere. That severity routing is what turns your log into
  a lightweight alerting channel without standing up a separate monitoring stack.
- **Web Server Logging and Alerts** (`errorlog`) writes watchdog messages to the
  **web server's error log**. Where those land is governed by your PHP
  `error_log` configuration — typically syslog on a UNIX‑like system (which may
  end up in something like `/var/log/apache2/error.log`), or the event log on
  Windows. You choose which severities are routed there, which is handy for
  feeding an existing log shipper or centralised syslog pipeline.

> **Important — there is no module at the project root.** The `logging_alerts`
> project contains only a licence plus the two submodules above; running
> `drush en logging_alerts` will fail. Enable `emaillog` and/or `errorlog`
> instead.

This is a **2.1.0‑beta1** release for Drupal 10.3 and 11. (The older 2.0.x branch
covers Drupal 9–10 and will not gain Drupal 11 support; the D7 branch is
end‑of‑life. The Watchdog triggers and Watchdog rules pieces are Drupal 7 only and
are not part of this branch.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the project with Composer and
   enable `emaillog` and/or `errorlog`.
2. [Configuration](configuration/index.md) — set up severity routing on each
   module's settings form.

## Where it lives in the admin menu

Each submodule has its own settings form under **Configuration → Development**:

- Email Logging and Alerts → `/admin/config/development/emaillog`
- Web Server Logging → `/admin/config/development/errorlog`

Both forms are gated by core's **Administer site configuration** permission;
neither module defines a permission of its own.

## Two cautions before you rely on email alerts

1. **Data exposure.** Drupal log messages routinely carry user input, IP
   addresses, usernames, and request details. Emailing them moves potentially
   sensitive data through a mail provider and into inboxes — treat that as a
   privacy decision, not just an operational one.
2. **Volume.** A site that starts erroring produces errors at machine speed. Set
   severity thresholds deliberately (send only the high‑severity levels to a
   person) so an error loop doesn't become a mail loop.
