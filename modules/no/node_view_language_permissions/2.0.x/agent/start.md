<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node View Language Permissions — agent index

Adds per-content-type, **per-language** "View own/any content" permissions (restrict node view by the node's
**language**). Provides permissions. Version **2.0.0**. Core `^10||^11`.

Genuine access control — uses the **node-grants system** (`hook_node_access_records` + `hook_node_grants`) →
**query-level enforcement** (restricted nodes filtered from listings/search, not just hidden — correct/strong
pattern). Grant per-type/per-language permissions to match intent; test can/can't-see (grants are additive).
