# Site Guardian Watchdog Summary — manual setup guide

**Site Guardian Watchdog Summary** (`sgd_watchdog_summary`) summarizes the entries
in Drupal's watchdog/dblog so administrators can see recent log activity at a
glance. Instead of scrolling through every individual log message, you get an
overview of the patterns in your logs — helpful for spotting a sudden spike in
errors or a repeating warning.

It is part of the wider *Site Guardian* monitoring framework: it contributes its
summary in the Site Guardian style, so the same log overview is available to that
monitoring system when it is present. On its own it simply reads and summarizes the
database log.

There is nothing to configure — the module works as soon as you enable it. It has
no dependencies beyond Drupal core, no submodules, and no settings form. It reads
log data only, which is already admin-only (governed by core's site-reports
permission), so it opens no new public surface and has no access-control role of
its own.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module relies on Drupal's core Database Logging (`dblog`) module for its data.
Once enabled, it reads those log entries and presents a summary of recent
watchdog/dblog activity so you can review log patterns without paging through the
full log.
