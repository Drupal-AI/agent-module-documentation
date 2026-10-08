<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Protector (node_protector) — agent index

**Blocks deletion of one configured node (by NID) or the front-page node, by aborting the delete in `hook_node_predelete` and redirecting back.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** none
- **Configure:** `/admin/config/system/node_protector/settings` (route `node_protector.settings`, `administer site configuration`).

**Surface:** `hook_node_predelete` guard in `.module`; settings form; trivial info page `/node_protector/home` (`access content`, static markup). Config: `node_protector_nid`, `node_protector_auto`.

**Security:** fail-closed for the single protected node (execution halts before the delete). Scope is narrow — protects one NID (+ optional front page), not content types or arbitrary sets. Settings gated by `administer site configuration`. No disclosure via the info page.
