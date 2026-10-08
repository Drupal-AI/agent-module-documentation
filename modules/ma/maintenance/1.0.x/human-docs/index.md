# Maintenance — manual setup guide

**Maintenance** (`maintenance`) is a fully configurable enhancement to Drupal
core's maintenance-mode system. Where core gives you a simple on/off switch and a
plain message, this module lets you control *when* maintenance mode is applied,
*who* sees it, and *how* it looks — making planned downtime feel professional
rather than broken.

Its features cover a lot of ground: a custom maintenance message (plain text,
rich HTML, or even a full node rendered as the page), **scheduling** so
maintenance mode turns itself on and off at set times, **access control** that
shows or hides the maintenance page based on IP address, route path, or query
string, **user redirection** that sends anonymous visitors to another URL, page
**reload** options (a manual button or an automatic refresh), custom **HTTP
status codes** in place of the default 503, and a choice of built-in maintenance
**themes** (such as *clean* or *particles*). It also keeps a small status report
and log so you can see when maintenance was last enabled.

One important thing to understand: maintenance mode is about **who can still use
the site while it's offline**. That bypass is governed by Drupal core's *access
site in maintenance mode* permission — make sure it's limited to the right roles
and that you don't accidentally leave a bypass open to the public.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the maintenance settings, section
   by section: message, scheduling, access rules, redirection, reload, status
   code, and themes.

## Where it lives in the admin menu

All of the module's settings are gathered under **Configuration → Development →
Maintenance** (`/admin/config/development/maintenance`).
