<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Skip Temp File Warnings — agent index

Clears the **temporary-files status warning** by deleting stale temporary managed-file entries on cron.
Config via `system.logging_settings`. Version **5.1.0**. Core `^9.5||^10||^11`.

Admin/maintenance tool — **deletes temp file entries** (ensure appropriate; core retention exists for a
reason — don't remove mid-workflow files prematurely). No access role.
