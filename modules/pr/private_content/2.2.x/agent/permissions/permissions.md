<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `private_content.permissions.yml`. Three permissions, each gating a distinct thing.

| Permission | Gates |
|---|---|
| `mark content as private` | Whether the user may **edit the `private` checkbox** on a node form (`PrivateItemList::defaultAccess()` allows the field `edit` op only with this permission). Does not by itself grant view access. |
| `edit private content` | Lets a non-owner **update or delete** a node that is private (`hook_node_access` returns forbidden for update/delete on private nodes unless the account has this). |
| `access private content` | Lets the user **view any** private node. Realm `private_view` (gid 1) is granted to holders of this permission via `hook_node_grants`; it is flagged `restrict access: true` (security-sensitive). |

Notes:
- A node's **author always** has view/edit of their own private node regardless of these
  permissions (realm `private_author`, gid = author uid).
- These permissions only ever *remove* restrictions the module itself imposes — they do not
  override other access rules, and the module never grants access a user wouldn't otherwise have
  for non-private content.
- Grant with drush, e.g.: `drush role:perm:add editor 'access private content'`.
