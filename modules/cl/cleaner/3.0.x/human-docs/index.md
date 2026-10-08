# Cleaner — manual setup guide

**Cleaner** (`cleaner`) runs routine site housekeeping on a schedule instead of
whenever someone remembers to do it. Clearing caches, trimming the watchdog log
table, removing old session records, optimising database tables — none of it is
urgent, and all of it eventually matters. A long-running Drupal site quietly
accumulates cache rows, log rows, and session records until a backup takes an hour
or a query slows down. Cleaner puts that maintenance on a timer so it happens
quietly in the background.

You choose what runs and how often on the module's settings form, and the work is
then triggered through cron. The module has no dependencies of its own, needs PHP
8.1 or newer, and supports Drupal 10 and 11. It also exposes an event so other
modules can hook into the cleanup — a niche extension point most sites won't need.

Two things are worth settling before you enable it:

- **Clearing caches on a schedule is not free.** A cache clear on a busy site
  triggers a rebuild "storm" as pages regenerate, so schedule cache clearing
  **off-peak and infrequently** — hourly clearing usually costs more in
  regeneration than it saves.
- **Deleting rows is irreversible, and logs are evidence.** Watchdog and session
  data are exactly what an incident investigation reads afterwards. Decide your
  retention policy deliberately rather than pruning aggressively by default.

Note that the current release is an **alpha** (`3.0.0-alpha1`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form: choosing what runs
   and how often.

## Where it lives in the admin menu

Cleaner's settings live at **Configuration → System → Cleaner**
(`/admin/config/system/cleaner`), reachable by any user with the **Administer site
configuration** permission.
