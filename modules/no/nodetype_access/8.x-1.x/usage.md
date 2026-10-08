<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nodetype Access provides view permissions per nodetype.

---

Nodetype Access provides per-content-type view permissions — so you can restrict which users may view
nodes of a given content type, denying view access to types a user isn't permitted to see. It is in the
Access control package and provides its own permissions.

Use it to restrict node view access by content type. It is a genuine access-control module: it implements
`hook_node_access()` and returns **`AccessResult::forbiddenIf(!$bundleIsPermitted)`** — a **forbid** result
(authoritative, AND-conjunction) when the node's bundle isn't permitted for the user, so viewing a
non-permitted type is denied. Note the enforcement level: `hook_node_access()` is the **entity-access**
check, which governs the full node view and is respected by access-aware listings/Views (with access
checking on); it is **not** the node-grants (query-level) system, so if you have contexts that bypass entity
access (a custom query, a View with access checking off), restricted-type nodes could still surface there —
verify your listings/search respect entity access. Grant the per-type view permissions to match intent and
**test** can/can't-see. Configure the permissions on the roles.

---

- Restrict node view by content type.
- Provide per-type view permissions.
- Deny view of non-permitted types.
- Implement hook_node_access() with forbiddenIf.
- Return a forbid result (authoritative).
- Enforce at entity-access level.
- Be respected by access-aware listings/Views.
- Know it is NOT node-grants (query-level).
- Verify listings/search respect entity access.
- Grant per-type permissions to match intent.
- Test can/can't-see.
- Provide its own permissions.
- Configure the permissions on roles.
- Handle node-type access.
- Deny non-permitted types.
- Restrict content viewing.
- Configure per content type.
- Handle bundle access.
- Enforce type view access.
- Restrict by node type.
