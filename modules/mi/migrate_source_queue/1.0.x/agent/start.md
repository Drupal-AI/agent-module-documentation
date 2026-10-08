<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Source Queue — agent index

Lets **queue items be used as a source for Migrate** (queued items become migration rows — event-driven/
incremental migrations). `migrate_source_queue_cron_example` submodule. Depends on core `migrate`. Version
**1.0.4**. Core `^8||^9||^10||^11`.

Developer/migration — queued data processed with migration privileges (ensure only trusted code enqueues;
validate). No access role.
