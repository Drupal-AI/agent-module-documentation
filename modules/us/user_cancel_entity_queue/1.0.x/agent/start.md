<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Cancel Entity Queue — agent index

**Queues deletion/reassignment of a user's entities (processed by cron) on cancel**. Provides permissions. Version
**1.0.0-alpha1**. Core `^9||^10||^11`.

Administration/user-management — **bulk delete/reassign** of a user's content (destructive; gate to trusted admins,
verify delete-vs-reassign; async via cron). No broader access role.
