<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Access provides simple hide/view access for nodes, using access groups.

---

Simple Access provides straightforward hide/view access control for nodes — letting you restrict which
users (via access groups) can view particular nodes, a lightweight alternative to more complex access
modules. It depends on core Node, is configured at `simple_access.admin`, provides its own permissions, in
the Access control package.

Use it for simple per-node view restrictions. This is a genuine access-control module implemented with the
correct mechanism: it uses Drupal's **node-grants system** (`hook_node_access_records()` +
`hook_node_grants()`), which enforces access at the **query level** — so restricted nodes are filtered out of
listings/search, not just hidden on the full page (the strong, correct pattern, avoiding the
"protected-in-view-but-leaks-in-listings" mistake). When adopting: configure the access groups and node
assignments to match your intent, and remember node-access modules **grant** view access via grants (test
that the intended users can/can't see the nodes). Configure the access groups.

---

- Restrict node view access simply.
- Hide/show nodes by access group.
- Provide lightweight node access.
- Depend on core Node.
- Use the node-grants system.
- Enforce access at the query level.
- Filter restricted nodes from listings/search.
- Avoid the listings-leak mistake.
- Provide its own permissions.
- Configure access groups and assignments.
- Test intended can/can't-see.
- Configure at simple_access.admin.
- Restrict per-node viewing.
- Handle node access.
- Use access groups.
- Enforce node grants.
- Control node visibility.
- Configure the groups.
- Restrict content viewing.
- Provide node access control.
