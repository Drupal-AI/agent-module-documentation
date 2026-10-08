<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Organic Groups access control — agent index

Enables **access control for private/public Organic Groups and group content** — implements
`hook_node_grants()` + `hook_node_access_records()`, so private group content is enforced at the **query
level** (listings/Views/all node queries), the correct/strong pattern. Depends on `og`. Version **2.0.3**.
Core `^10||^11||^12`.

Correctly-implemented access control (node access grants — no alternate-path leaks). Verify group
visibility settings; rebuild node access after enabling.
