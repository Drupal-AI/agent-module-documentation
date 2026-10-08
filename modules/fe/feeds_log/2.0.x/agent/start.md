<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Log — agent index

Logs the records a **Feeds import did not import** (review/debug why source rows were dropped). Depends on
`feeds`. Version **2.x** (dev). Core `^9.3||^10||^11`.

Integration/logging — the log captures **source feed data** for unimported records (may include sensitive
content; readable by those with log access — prune it). No access role.
