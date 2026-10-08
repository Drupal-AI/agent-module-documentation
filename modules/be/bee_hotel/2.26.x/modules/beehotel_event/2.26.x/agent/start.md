<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BEE Hotel Event (beehotel_event) — agent index

**BAT-event maintenance** helper for Bee Hotel. Dependency: `bat`. Core `^9.4 || ^10 || ^11`.
No routes, permissions or config.

## What it does

- `beehotel_event_cron()` (`.module`) instantiates `Util\EventMaintenance` and calls
  `deleteOldBatEvents([])` — purges stale `bat_event` rows so the BAT availability tables don't
  grow unbounded.
- `menu` link file present (`.links.menu.yml`).

The whole surface is the cron hook + `EventMaintenance`; no solution subpages needed.
