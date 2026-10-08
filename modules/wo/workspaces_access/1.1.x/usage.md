<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workspaces Access provides granular permissions for editing content per workspace.

---

Workspaces Access provides **granular, per-workspace editing restrictions** on top of core Workspaces —
letting you control who may create/update/delete content in a given workspace (notably the Live workspace),
via an extensible event. It depends on core Workspaces, provides its own permissions, in the Custom package.

Use it to restrict editing per workspace. It is an access-control feature and it is implemented **safely**: its
`hook_entity_access` handler only applies to the **Live** workspace and **create/update/delete** operations,
and it **adds** restrictions by dispatching a `workspaces_access.workspace_check` event — returning a
subscriber's `AccessResult::forbidden()` when one decides to block, and otherwise **NULL** (defer to core). It
can therefore only ever **tighten** access, never grant it — a fail-closed, additive design. Grant its
permissions and add subscribers for your rules. It layers on core Workspaces' own access.

---

- Restrict editing per workspace.
- Control create/update/delete access.
- Target the Live workspace.
- Depend on core Workspaces.
- Provide its own permissions.
- Use an extensible event.
- Only ADD restrictions (never grant).
- Return forbidden or NULL (defer to core).
- Be fail-closed and additive.
- Layer on core Workspaces access.
- Add subscribers for your rules.
- Configure the permissions.
- Handle workspace access.
- Restrict workspaces.
- Configure the access.
- Gate editing.
- Handle the access.
- Restrict content.
- Grant the permissions.
- Provide workspace access control.
