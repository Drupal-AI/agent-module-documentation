# Liveness — manual setup guide

**Liveness** (`liveness`) is an uptime‑monitoring tool for Drupal. It watches the
availability of one or more environments — your production site, a staging server,
partner endpoints — and sends notifications and keeps logs when something goes down
and again when it recovers. You configure the URLs to probe and the email
addresses to notify, then run the checks on a schedule (typically via cron).

A nice touch for reliability: alongside the usual Drush command, Liveness ships a
standalone PHP command that wraps the check and can log outage/recovery events
**even if the Drupal database is down** — exactly the situation you most want an
alert for. That makes it suitable for catching hard outages that a
Drupal‑dependent monitor would miss.

It targets Drupal 10 and 11 and requires Drush.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the environment URLs, notification
   emails, and schedule the checks.

## Where it lives in the admin menu

Liveness settings live at **Configuration → Development → Performance → Liveness**
(`/admin/config/development/performance/liveness`), where you set the environment
URLs, enable or disable probing, and enter notification email addresses.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Configure the environments and notification emails at
   `/admin/config/development/performance/liveness`.
3. Schedule the checks with cron so Liveness probes your environments regularly and
   alerts you on outages and recovery (see [Configuration](configuration/index.md)).
