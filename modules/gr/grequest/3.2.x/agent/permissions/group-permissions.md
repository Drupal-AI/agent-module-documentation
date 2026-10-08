<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group permissions

grequest ships **no `grequest.permissions.yml`**. Its permissions are **group permissions**
(scoped per group type, granted on `/admin/group/types/manage/{group_type}/permissions`),
provided by `GroupMembershipRequestPermissionProvider` for the `group_membership_request` relation:

| Permission | Gates |
|---|---|
| `request group membership` | Submit a request to join (default target: the **outsider** role). Guards the `/group/{group}/request-membership` route. |
| `administer membership requests` | The relation's `admin_permission`: approve/reject, create/update/delete request relationships, and access `/group/{group}/members-pending` and the approve/reject routes. |
| `view any membership requests` | View any request relationship in the group. |
| `view own membership requests` | View one's own request relationships. |

Notes:
- These are **not** site-wide permissions; assign them on each group type's permission form (or via
  `group.role.*` config), per role (outsider / member / custom group roles).
- The approve/reject/pending routes additionally use custom access checks
  (`_group_membership_request`, `_pending_group_membership_request`) plus
  `_group_permission: 'administer membership requests'`.
- The request link only appears for users who are **not** already members and who hold
  `request group membership`.
