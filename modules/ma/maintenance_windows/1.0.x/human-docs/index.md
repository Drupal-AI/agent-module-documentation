# Maintenance Windows — manual setup guide

**Maintenance Windows** (`maintenance_windows`) lets you schedule the times
during which your site should automatically enter and exit Drupal's maintenance
mode — no more setting an alarm to toggle the switch by hand. You define a
window (a start time, an end time, and the message visitors should see), and a
`hook_cron` implementation takes care of enabling maintenance mode when the
window opens, disabling it when the window closes, and cleaning up afterwards.

It's built for planned downtime: infrastructure work, deployments, or upstream
system maintenance that will disrupt your site but happens at a fixed, often
inconvenient hour. If you also run the
[Read Only Mode](https://www.drupal.org/project/read_only_mode) module, a window
can put the site into read-only mode instead of full maintenance mode, keeping
content visible while blocking changes. Windows can still be started or ended
manually from the same interface whenever you need to.

The module is purely an operations utility — it adds no content types, no fields,
and no visitor-facing features. Administration is gated by a single permission,
**Administer maintenance_window configuration**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — schedule, start, and end your
   maintenance windows.

## Where it lives in the admin menu

Once enabled, scheduling lives at **Configuration → Development → Maintenance
Windows** (`/admin/config/development/maintenance-windows`). You need the
**Administer maintenance_window configuration** permission to reach it.

## How to use it

Because scheduling depends on Drupal's cron, windows open and close only when
cron runs. If your site's cron interval is long (say, hourly), a window may start
or end a little late. For precise timing, run cron on a tight external schedule
(for example every minute via your server's crontab) around the times you have
windows planned.
