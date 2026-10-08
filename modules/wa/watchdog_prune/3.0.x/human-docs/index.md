# Watchdog Prune — manual setup guide

**Watchdog Prune** (`watchdog_prune`) keeps Drupal's database log from growing
without bound. Drupal's core Database Logging (dblog) module records events in the
`watchdog` table, and on a busy site that table can balloon — slowing down the
*Reports → Recent log messages* page and bloating your backups. Watchdog Prune
trims it on every cron run based on the **age** of the entries.

You give it a global "delete entries older than…" threshold (for example, one
month or eighteen months), and optionally a set of per‑log‑type rules so noisy
channels can be pruned more aggressively than important ones. For instance you can
keep everything for a year but throw away routine `cron` notices after a week, or
drop `php` and `system` chatter after a month while retaining `access denied`
security logs longer.

Pruning happens **through cron only** — there is no separate button or Drush
command, and no need for one. Set your retention policy once and Drupal's regular
cron keeps the log table tidy.

> **Important prerequisite.** For age‑based pruning to work, Drupal core's dblog
> setting **"Database log messages to keep"** must be set to **All**. If it is left
> at a row‑count limit, core trims the table by row count first and undercuts this
> module's age rules. See [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the retention settings, plus the
   dblog prerequisite you must set.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → Watchdog Prune
settings** (`/admin/config/development/watchdog-prune`), gated by the **Administer
watchdog prune** permission.
