<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Membership Request extends the Group module so non-members can request to join a group, and group admins can approve or reject those requests through a state-machine workflow.

---

The module adds a Group relation plugin `group_membership_request` (a `GroupRelationType`) that you install per group type, just like the standard "Group membership" relation. Once installed, users with the group permission `request group membership` see a "Request membership" link on a group and can submit a request; each request is a `group_relationship` entity carrying a `grequest_status` state field managed by the `state_machine` module with states `new → pending → approved | rejected` (transitions `create`, `approve`, `reject`). Group admins with `administer membership requests` review pending requests at `/group/{group}/members-pending` (backed by the optional `views.view.group_pending_members` view) and approve — which adds the user as a real member, optionally with chosen group roles — or reject them. A `MembershipRequestManager` service (`grequest.membership_request_manager`) is the programmatic entry point with `create($group, $user)`, `approve($relationship, $roles)`, `reject($relationship)`, and `getMembershipRequest($user, $group)`; using it fires the correct state-machine events. The module also ships VBO-style actions (`grequest_approve_membership_request`, `grequest_reject_membership_request`), Views field plugins (approve/reject/request links), custom access checkers, and a per-plugin option to delete the request record once the user joins. It has no global settings form (`configure: null`); all configuration is the relation-plugin config on each group type.

---

- Let anonymous-turned-authenticated users ask to join a private group instead of being added manually.
- Add a "Request membership" button to group pages for outsiders.
- Build a moderated join flow where admins approve or reject each request.
- Approve a request and simultaneously assign the new member specific group roles.
- Reject membership requests that don't qualify, recording who acted via `grequest_updated_by`.
- Review all pending requests for a group at `/group/{group}/members-pending`.
- Bulk-approve or bulk-reject pending requests using the provided Views/VBO actions.
- Programmatically create a membership request from custom code via the manager service.
- Programmatically approve or reject requests in an event subscriber or cron job.
- Track a request's lifecycle (new/pending/approved/rejected) via the `grequest_status` state field.
- Gate the request link with the `request group membership` permission for the outsider role.
- Restrict who can moderate with the `administer membership requests` permission.
- Let users view their own pending requests (`view own membership requests`).
- Let moderators view all membership requests (`view any membership requests`).
- Automatically remove the request record when a user becomes a member (per-plugin option).
- Expose approve/reject links inside a custom Views listing of requests.
- Integrate a request-to-join workflow into a community, association, or membership site built on Group.
- Combine with notifications to email admins when a new request arrives (via state-machine events).
- Prevent duplicate requests (the manager rejects requests from existing members).
- Enforce single-request cardinality (the plugin fixes entity cardinality at 1).
- Add a self-service join workflow to course/cohort groups.
- Let team leads approve contributors into project groups.
- Migrate a manual invite-only process to a request-and-approve model.
- Show a member's request status in their profile via the request's state field.
- Drive membership approval from a custom REST/queue worker using the manager API.
