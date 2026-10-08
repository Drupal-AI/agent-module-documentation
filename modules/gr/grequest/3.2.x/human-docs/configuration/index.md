# Configuration

There is no global settings form. You enable the request-to-join feature on each
group type by installing a relation plugin, and then you grant the group
permissions that control who can request and who can moderate.

## 1. Install the request relation on a group type

1. Go to **Administration → Groups → Group types**
   (`/admin/group/types`) and choose the group type you want to open up.
2. Open its **Set up content** page
   (`/admin/group/types/manage/<group_type>/content`).
3. Install **"Group membership request"**.
4. On its configuration form the one extra option is **"Remove a group membership
   request, when user joins the group"** (default off). Turn it on if you'd rather
   not keep the request record around once the user becomes a member.

The group type must also have the standard **"Group membership"** relation
installed, so that approved requests can be turned into real memberships.

## 2. Grant the group permissions

These are **group permissions** — set per group type, per role — not site-wide
permissions. Configure them on the group type's **Permissions** page
(`/admin/group/types/manage/<group_type>/permissions`):

| Permission | Give it to | What it allows |
|---|---|---|
| **Request group membership** (`request group membership`) | the **outsider** role (non-members) | Show and use the "Request membership" link to submit a join request. |
| **Administer membership requests** (`administer membership requests`) | moderators / group admins | Approve and reject requests, manage request records, and access the pending-requests page. |
| **View any membership requests** (`view any membership requests`) | moderators | See every request in the group. |
| **View own membership requests** (`view own membership requests`) | members / requesters | Let users see the status of their own requests. |

The "Request membership" link only appears for users who are **not** already
members and who hold *Request group membership*.

## 3. How the flow works

- An outsider visits a group and clicks **Request membership** to submit a
  request. The request starts in the *pending* state.
- Group admins review pending requests at **`/group/{group}/members-pending`**
  (backed by an optional Views view of pending members). There they **approve** —
  which adds the user as a real member and lets you pick which group roles to give
  them — or **reject** the request.
- The request's lifecycle (*new → pending → approved / rejected*) is tracked on a
  status field, and who acted is recorded, so you have an audit trail.

## Bulk moderation and code (optional)

The module ships Views field plugins (approve/reject/request links) and VBO-style
bulk **approve** / **reject** actions, so you can build a custom listing that
moderates many requests at once. Developers can also drive the workflow through
the `grequest.membership_request_manager` service (`create()`, `approve()`,
`reject()`, `getMembershipRequest()`) — see the [`agent/`](../agent/start.md)
docs.
