<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Optimize Database Tables — agent index

Runs **database table optimization (`OPTIMIZE TABLE`)** from Drupal (defragment/reclaim space). Drush
commands; provides permissions. Config at `optimize_database_tables.settings`. Version **1.2.1**. Core
`^10||^11`.

Performance/admin op against the DB — restrict to trusted admins (optimization locks/rebuilds tables → brief
availability impact on large tables); prefer low-traffic windows / Drush. No content-access role beyond
permission.
