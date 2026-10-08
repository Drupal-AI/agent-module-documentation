<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manager service, state field, actions & routes

## Service `grequest.membership_request_manager` → `MembershipRequestManager`

Use this for all request operations so state-machine events fire correctly. Constructor args:
`@entity_type.manager`, `@current_user`.

```php
$mgr = \Drupal::service('grequest.membership_request_manager');
$request = $mgr->create($group, $user);   // returns an UNSAVED group_relationship; call ->save()
$request->save();
$mgr->approve($request, $group_roles = []); // sets state approved, saves, AND adds the user as a member
$mgr->reject($request);                      // sets state rejected, saves
$existing = $mgr->getMembershipRequest($user, $group); // GroupRelationship|null
```

- `create()` returns `NULL` if the group type lacks the plugin, and throws if the user is already a
  member. It builds a `group_relationship` of the computed relationship type, sets
  `grequest_status` to `new`, and applies the `create` transition (→ `pending`). **You must `save()`
  the returned entity.**
- `approve()` applies the `approve` transition, saves, then calls
  `$group->addMember($user, ['group_roles' => $group_roles])`.
- `reject()` applies the `reject` transition and saves.
- `updateStatus()` throws if the transition isn't allowed from the current state, and stamps
  `grequest_updated_by` with the current user.

## State field & workflow (`state_machine`)

- Status field: **`grequest_status`** (constant `GroupMembershipRequest::STATUS_FIELD`).
- Workflow `request` (`grequest.workflows.yml`), group `group_membership_request`, entity type
  `group_relationship`:
  - States: `new`, `pending`, `approved`, `rejected`.
  - Transitions: `create` (new→pending), `approve` (pending→approved), `reject` (pending→rejected).
- Read a request's state: `$request->get('grequest_status')->value`.
- Class constants: `TRANSITION_APPROVE`, `TRANSITION_REJECT`, `TRANSITION_CREATE`, `REQUEST_NEW`,
  `REQUEST_PENDING`, `REQUEST_APPROVED`, `REQUEST_REJECTED`.

## Actions (VBO)

- `grequest_approve_membership_request` (`ApproveMembershipRequest`)
- `grequest_reject_membership_request` (`RejectMembershipRequest`)

## Routes

| Route | Path | Access |
|---|---|---|
| `entity.group.group_request_membership` | `/group/{group}/request-membership` | `request group membership` + not a member |
| `entity.group_relationship.group_approve_membership` | `/group/{group}/content/{group_relationship}/approve-membership` | `administer membership requests` + pending |
| `entity.group_relationship.group_reject_membership` | `/group/{group}/content/{group_relationship}/reject-membership` | `administer membership requests` + pending |

Views field plugins: approve/reject/request membership links (`src/Plugin/views/field/*`), used by
the optional `group_pending_members` view at `/group/{group}/members-pending`.
