<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `merge_translations.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `merge_permissions admin` | `true` | Access the Merge translations form on any node (`merge_translations.node`) and perform the merge. |

This single permission (marked security-sensitive via `restrict access: true`) is the only access
check on the route. Notes on its scope:

- A holder can open `/node/{node}/merge_translations` for **any** node and copy field values from any
  same-bundle source node into it as translations. The form does not separately re-check *edit* access
  on the target node — treat this permission as edit-equivalent for translations and grant it only to
  trusted content-admin roles (which its `restrict access: true` flag signals).
- The extra **"Remove node" after import** action is gated more tightly: it only appears when the user
  has `bypass node access`, `delete any <type> content`, or `delete own <type> content`, and
  `removeNode()` still calls `$node_source->access('delete')` before deleting. So deletion cannot
  exceed the user's core node-delete rights.
