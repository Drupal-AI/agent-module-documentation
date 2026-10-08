<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Protected Nodes — agent index

**Password-protects individual nodes** (shared-password gate). Provides permissions. Version **2.0.2**. Core
`^9.5||^10||^11`.

Access-control — enforced via `hook_node_access` returning **forbidden** until unlocked (respected by canonical
page + per-entity access checks in Views/JSON:API). Coarse **shared-password** gate (not per-user; rotate it);
ensure node **files** aren't exposed via public-file URLs (which bypass node access). Layers on core node
access.
