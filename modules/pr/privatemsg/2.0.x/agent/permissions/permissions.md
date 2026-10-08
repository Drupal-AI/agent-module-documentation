<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `privatemsg.permissions.yml`:

| Permission | Unlocks | Notes |
|---|---|---|
| `administer privatemsg` | Settings forms, field UI, single-message view, admin `/user/%user/messages` context | `restrict access: true` — treat as admin/trusted |
| `privatemsg write messages` | Inbox, view/compose/reply to threads | The core "can use messaging" permission; gates the canonical thread route and the inbox view |
| `privatemsg use messages actions` | VBO bulk actions: mark read/unread, remove thread, change tags | The access handler grants these operations on the strength of this permission **without an ownership check** — see security review |
| `privatemsg delete own messages` | Soft-delete one's own individual messages | Controller re-checks `owner === current user` |
| `privatemsg view deleted messages` | See the body of soft-deleted messages in a thread (else only a "deleted by X" notice) | Presentation only |
| `privatemsg send to role` | Address a message to a whole role via autocomplete | Suggestions limited to `allowed_roles`; element validation does **not** re-enforce that list |
| `privatemsg block users` | Block/unblock other users, `/messages/blocked` | |
| `privatemsg change thread tags` | Add/change personal thread tags (form + VBO change-tags action) | Also required (with `use messages actions`) for the `change_tags` entity operation |

## Guidance

- The natural "member" role needs `privatemsg write messages` and usually
  `privatemsg use messages actions`, `privatemsg delete own messages`, and `privatemsg block users`.
- `administer privatemsg` is restricted and also confers read access to any message via the
  standalone message route and the admin `/user/{uid}/messages` display — grant only to admins.
- Granting `privatemsg use messages actions` currently implies the ability to invoke the
  `remove_thread` / `change_tags` entity operations on threads the user does not own if the VBO
  selection can be tampered (the operations lack an ownership check). Weigh this before handing the
  permission to a large/low-trust audience — see the security review.
