<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Merge — agent index

An advanced mechanism to **merge two user accounts** (consolidate content/references/roles, then remove/block
the merged account). Gated by a dedicated `merge accounts` permission. Version **2.0.x** (dev). Core
`^9||^10||^11`.

**Powerful/sensitive admin operation** — merging reassigns content/authorship and can **transfer roles**
between accounts; gate `merge accounts` to **fully-trusted admins** only, review what's transferred
(especially roles), treat as irreversible (back up first).
