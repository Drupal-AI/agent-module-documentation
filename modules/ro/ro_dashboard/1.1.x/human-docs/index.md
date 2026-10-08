# RO Dashboard — manual setup guide

**RO Dashboard** (`ro_dashboard`) is the base module for a **multi-site status
dashboard**. If you look after several Drupal sites, it gives you one central place
to see how each of them is doing. It works hand-in-hand with the
[Site Guardian](https://www.drupal.org/project/site_guardian) module: each site you
monitor runs Site Guardian, and RO Dashboard collects and parses the reports it
generates.

Specifically, it can parse these Site Guardian reports for each monitored site:
the main **Site Guardian** report, **User Status**, **PHP Status**, **Server
Benchmarks**, and the **Watchdog Summary**. From those, it presents a simple view
of all your sites and their current status, and it re-scans them once a day as part
of cron.

You model each monitored site as a **Site entity** (which is revisionable, so you
can review changes over time). To keep the dashboard from crying wolf, you can
maintain **ignore lists** — both global and per-site — of items or modules you've
reviewed and accepted, so a known, harmless finding no longer pushes a site into
"warning" or "error". Per-site ignores are always added on top of the global list.

A word on security and data sensitivity. A status dashboard aggregates operational
detail across sites — exactly the kind of information you don't want in the wrong
hands — so gate its permissions to **trusted operators** only, and secure the
channel over which it exchanges status data (authentication + HTTPS). Be aware, too,
that in this version the **Site Guardian secret is stored as plain text** in the
Site entity; the maintainer has flagged improving that as a to-do, so treat those
entities as sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the sites you want to monitor,
   connect them to Site Guardian, and tune the ignore lists.

## Where it lives in the admin menu

RO Dashboard adds an administrative dashboard plus screens for managing **Site
entities** and the **ignore lists**, all gated by the module's own permissions. The
day-to-day view shows your sites and their status; the setup happens on the Site
entity and settings screens described in the
[Configuration](configuration/index.md) guide.
