<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes and controllers

Routing is `privatemsg.routing.yml` plus the two entity route providers
(`PrivatemsgThreadHtmlRouteProvider`, `PrivatemsgMessageHtmlRouteProvider`) and the
`all_privatemsg_threads` view (which owns `/messages` and `/user/%user/messages`).

## `PrivatemsgController` — `src/Controller/PrivatemsgController.php`

### `removeMessage()` — `POST /messages/delete/{thread_id}/{mid}`
Route perm `privatemsg delete own messages` + `_csrf_token: TRUE`. Loads the message by `mid` and
acts **only if** `hasPermission('privatemsg delete own messages')` **and**
`message->getOwnerId() === currentUser id`. So a user can soft-delete only their own messages; the
`thread_id` is used solely to build the redirect. No cross-user delete (own-only check).

### `blockUser()` — `POST /messages/block/{user}`
Route perm `privatemsg block users` + CSRF. Toggles the block relationship between the current user
and `{user}`: if `isUserBlocked` (either direction) it calls `unblockUser` (which only removes the
caller's own `who` rows), else `blockUser`. Returns an AJAX `ReplaceCommand` swapping the block/
unblock link. Note: this AJAX toggle does **not** consult `canBeBlocked()` / `unblockable_roles`
(the block *form* does) — a minor policy gap, functional only.

### `leaveChat()` — `POST /messages/view/{thread_id}/leave`
Route perm `privatemsg write messages` + CSRF. Loads the thread and refuses (HTTP 400) unless
`currentUser id === thread->getOwnerId()` **and** the group has 3+ members. Then, for every thread
row in the group, removes the current user from `members` and, on the caller's own row, marks it
deleted. Owner-gated, so a user can only leave conversations they participate in.

## Entity routes

- `entity.privatemsg_thread.canonical` — `/messages/view/{privatemsg_thread}`, `_entity_access:
  privatemsg_thread.view` + perm `privatemsg write messages`. Renders the thread (see hooks) and
  embeds the reply form.
- `entity.privatemsg_message.canonical` — `/privatemsg_message/{privatemsg_message}`,
  `_entity_access: privatemsg_message.view` + perm `administer privatemsg` (admin-only).
- `entity.privatemsg_message.add` — `/messages/new/{user}` (user optional), perm
  `privatemsg write messages`.
- `entity.privatemsg_message.settings` / `entity.privatemsg_thread.settings` — field-UI base
  routes under `/admin/structure/...`, perm `administer privatemsg`.
- `privatemsg.settings` — `/admin/config/content/privatemsg-settings`, perm `administer privatemsg`.
- `privatemsg.block_user_form` — `/messages/blocked`, perm `privatemsg block users`.

## CSRF

The three mutating GET/link-driven controller routes (`delete_message`, `block_user`, `leave_chat`)
all require `_csrf_token: TRUE`, and the links are generated server-side with a token bound to the
session (`SynchronizeCsrfTokenSeedTrait` + `PrivatemsgCsrfProtectionTest` exercise this). An attacker
cannot forge a valid token for a victim, so these are not CSRF-exploitable.
