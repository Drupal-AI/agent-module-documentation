<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Queue Order (queue_order) — agent index

Controls the **execution order of queue workers** during cron. Version **2.1.6**. Core `>=10`.

Operational tuning for sites with multiple queues where one matters more (time-sensitive
notifications vs background cleanup). Controls **order, not capacity** — if cron time is the
constraint, ordering decides what runs first, not whether everything runs.