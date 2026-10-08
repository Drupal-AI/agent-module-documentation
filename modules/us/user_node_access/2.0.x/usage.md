<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Node Access allows restricting a node to specific users.

---

User Node Access is meant to **restrict a node to specific users** — an admin picks which users may access
a given node. It depends on core Node.

Its enforcement is a single `hook_node_access()` implementation; the module implements no node grants
(`hook_node_grants`/`hook_node_access_records`). There is also a loop bug that wrongly denies allowed users
not listed first.

---

- Intend to restrict a node to specific users.
- Know it implements no node grants.
- Know the allow-list loop mis-denies non-first users.
- Depend on core Node.
- Configure the restriction.
- Handle the module.
