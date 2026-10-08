<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduler Request Cron — agent index

Runs **Scheduler's lightweight cron as part of page requests** (process scheduled publish/unpublish promptly
vs waiting for full cron). Config at `scheduler_request_cron.settings`. Version **2.1.0**. Core `^10||^11`.

Automation — triggers Scheduler's lightweight cron on requests (actions run with site privileges; adds small
per-request work — set frequency sensibly). No access role.
