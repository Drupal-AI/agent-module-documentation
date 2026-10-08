<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nodetype Access — agent index

Provides **per-content-type view permissions** (deny view of node types a user isn't permitted to see).
Provides permissions. Version **8.x-1.0**. Core `^8.8||^9||^10||^11`.

Genuine access control — `hook_node_access()` returns **`AccessResult::forbiddenIf(!$bundleIsPermitted)`**
(authoritative forbid). **Level:** entity-access (governs full node view, respected by access-aware listings/
Views) — **not** node-grants/query-level, so contexts that bypass entity access (custom queries, View with
access-check off) could still surface restricted-type nodes (verify your listings/search). Test can/can't-
see.
