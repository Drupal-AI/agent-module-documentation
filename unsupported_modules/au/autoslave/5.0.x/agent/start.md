<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AutoSlave — agent index

**Automatically routes read database queries to replica (slave) servers** (writes to primary; scale reads).
Depends on core `system`. Provides permissions. Version **5.0.0**. Core `^9.5||^10||^11`.

Performance/infrastructure — needs correct replication + awareness of **replication lag** (stale reads after
writes). No content/access role beyond permission.
