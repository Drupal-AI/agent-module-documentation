<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduler for ECK (scheduler_eck) — agent index

**Integrates Scheduler with Entity Construction Kit so ECK entities support scheduled publish/unpublish.**

- **Version:** 1.0.x
- **Core:** ^8.8.3 || ^9 || ^10 || ^11 (PHP 7.1+)
- **Depends on:** eck, scheduler (>= 2.0.0-rc4)
- **Plugin:** `@SchedulerPlugin` `scheduler_eck` (extends `SchedulerPluginBase`), deriver `SchedulerEckDeriver` (one instance per ECK entity type), event class `SchedulerEckEvents`
- **No routes/permissions/services/config of its own** — pure plugin glue

**Security:** No HTTP surface, no anonymous or mutating endpoints; scheduling runs through Scheduler cron and existing ECK entity access.

See [extend/plugin.md](extend/plugin.md)
