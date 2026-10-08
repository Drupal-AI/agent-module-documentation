<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Driplet Log (driplet_log) — agent index

Driplet example submodule: a real-time log viewer. Depends on `driplet:driplet` and `drupal:dblog`.
Package `Driplet`. Core `^10 || ^11`. Version 1.0.2. No permissions of its own, no config, no schema.

## What it provides

- **Logger service** `logger.driplet_log` (`DripletLogger`, tagged `logger`), args
  `@logger.log_message_parser`, `@driplet.service`.
- **Route** `driplet_log.page` → `LogController::content` at **`/admin/reports/driplet-log`**,
  permission **`access site reports`** (core). Menu under *Reports* (`system.admin_reports`).
- **Library** `driplet_log/driplet-log` (`js/driplet-log.js` + `css/driplet-log.css`), depending on
  `driplet/driplet-client`.

## How it works

- **Details** → [api/logger.md](api/logger.md)
- Send side: `DripletLogger::log()` mirrors each Drupal log entry to the `driplet-log` topic,
  targeted at the `administrator` role, via `driplet.service`.
- View side: `LogController::content()` renders an empty `#type => table`
  (`id = driplet-log-table`); `js/driplet-log.js` subscribes to `driplet-log` and prepends rows.
