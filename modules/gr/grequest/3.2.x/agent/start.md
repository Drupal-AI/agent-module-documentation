<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Membership Request — agent index

Extends **Group** so outsiders can request to join a group and admins approve/reject via a
`state_machine` workflow. Requires `group` (^3) and `state_machine`. No global settings form
(`configure: null`); config is per group type.

- **Install the relation on a group type; the `remove_group_membership_request` option; the pending view** →
  [configure/setup.md](configure/setup.md)
- **Group permissions it adds and what they gate** →
  [permissions/group-permissions.md](permissions/group-permissions.md)
- **`grequest.membership_request_manager` service, the state field/workflow, actions & routes** →
  [api/manager.md](api/manager.md)

Key facts:
- Group relation plugin id **`group_membership_request`** (`GroupRelationType`, entity `user`,
  `admin_permission: administer membership requests`, `pretty_path_key: request`).
- Each request is a `group_relationship` entity with state field **`grequest_status`**; states
  `new → pending → approved | rejected` (transitions `create`, `approve`, `reject`), plus a
  `grequest_updated_by` field.
- Group permissions (per group type): `request group membership`, `administer membership requests`,
  `view any membership requests`, `view own membership requests`.
- Manager service methods: `create($group,$user)`, `approve($relationship,$roles=[])`,
  `reject($relationship)`, `getMembershipRequest($user,$group)`.
- Pending queue route `/group/{group}/members-pending` (optional view `group_pending_members`).
