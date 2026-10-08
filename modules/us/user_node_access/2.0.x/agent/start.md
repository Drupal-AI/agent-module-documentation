<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Node Access — agent index

Meant to **restrict a node to specific users**. Depends on core `node`. Version **2.0.0**. Core `^9||^10||^11`.

Enforcement is a single `hook_node_access()` implementation; the module implements **no node grants**. A loop
bug mis-denies allowed users not listed first.
