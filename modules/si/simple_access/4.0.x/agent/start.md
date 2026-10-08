<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Access — agent index

Simple **hide/view access control for nodes** via access groups. Depends on core `node`; provides
permissions. Config at `simple_access.admin`. Version **4.0.0-alpha2**. Core `^10||^11`.

Genuine access control — uses the **node-grants system** (`hook_node_access_records` + `hook_node_grants`) →
**query-level enforcement** (restricted nodes filtered from listings/search, not just hidden on the page —
the correct/strong pattern). Configure access groups/assignments to match intent; test can/can't-see.
