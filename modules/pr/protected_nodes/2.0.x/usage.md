<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Protected Nodes protects nodes with a password.

---

Protected Nodes **password-protects individual nodes** — showing a password form instead of the node until
the correct password is entered, for content you want to gate behind a shared password without per-user
accounts. It provides its own permissions.

Use it to password-gate specific nodes. It is an access-control feature and it enforces at the **entity access**
layer: its `hook_node_access()` returns `AccessResult::forbidden()` for a protected node until it's unlocked, so
the gate is respected wherever `$node->access('view')` is checked (canonical page, and per-entity access checks
in Views/JSON:API). Things to understand: it is a **shared-password** gate (all users use the same password — it
is coarse, not per-user access control, so rotate the password and don't use it for high-sensitivity content
better served by real permissions); and ensure any node **fields/files** aren't exposed through paths that don't
re-check node view access (e.g. public file URLs bypass node access). It layers on core node access. Configure
the protected nodes.

---

- Password-protect individual nodes.
- Show a password form until unlocked.
- Gate content behind a shared password.
- Provide its own permissions.
- Enforce via hook_node_access (forbidden).
- Be respected on $node->access('view') checks.
- Be respected by canonical page + Views/JSON:API per-entity checks.
- BE a coarse shared-password gate (not per-user).
- Rotate the password / avoid high-sensitivity content.
- Ensure fields/files aren't exposed via non-access paths (public files).
- Layer on core node access.
- Configure the protected nodes.
- Handle node protection.
- Protect nodes.
- Configure the passwords.
- Gate nodes.
- Handle the access.
- Password nodes.
- Mind file exposure.
- Provide node password protection.
