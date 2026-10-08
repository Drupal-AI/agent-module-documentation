<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Scheduler (advanced_scheduler) — agent index

Schedules **content-moderation state transitions** (any state, not just publish/unpublish).
Version **8.x-1.2**. Core `>=8`. Works with content moderation.

The scheduling layer for editorial workflows (embargo→Published, auto-archive, staged review).
**Security:** a scheduled transition **runs automatically** — confirm it honours the workflow's
transition permissions (not a bypass), and restrict who can set schedules.