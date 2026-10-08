<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Manage Comment Own Content lets users manage comments created on their own content.

---

Manage Comment Own Content adds **per-comment-type permissions that let users manage comments on content
they own** — approve, update, delete, and view unpublished comments, but only on entities the user is the author
of. It depends on core Comment and Node, provides its own permissions.

Use it to let authors moderate comments on their own posts. It is an access-control feature and it is
implemented **correctly**: its `hook_ENTITY_TYPE_access` grants an operation only when the commented entity's
`getOwnerId()` equals the current user AND the user holds the matching per-type permission
(`<type> update/delete comments on own content`, `<type> view unpublished comments on own content`) — otherwise
it returns **neutral** (never forbidden), so it can only **add** ownership-scoped access, never broaden it to
others' content or override other modules' denials. Grant the per-type permissions to the roles that should
self-moderate. It layers on core comment access.

---

- Let users manage comments on own content.
- Cover approve/update/delete/view-unpublished.
- Scope to the entity's owner.
- Depend on core Comment and Node.
- Provide per-type permissions.
- Enable author self-moderation.
- Grant only when getOwnerId() == current user.
- Require the matching per-type permission.
- Return neutral otherwise (never forbidden).
- Only ADD ownership-scoped access.
- Layer on core comment access.
- Grant the per-type permissions.
- Handle own-content comments.
- Moderate comments.
- Configure the permissions.
- Approve comments.
- Handle the access.
- Manage comments.
- Scope to owners.
- Provide own-content comment management.
