<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Watchdog File — agent index

Writes **watchdog log events to a local flat file** — a lighter alternative/replacement for core
Database Logging (dblog). Version **2.0.0**. Core `^10||^11`.

**Operational security:** place the log file **outside the web root** and ensure it's **not
web-servable** (logs can contain sensitive details); manage rotation. Changes where logs go, not site
access.
