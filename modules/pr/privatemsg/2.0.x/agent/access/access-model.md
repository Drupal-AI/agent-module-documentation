<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access model

Private messaging lives or dies on access control. Here is exactly how 2.x gates each operation.

## Thread `view` — `src/Entity/Access/PrivatemsgThreadAccessControlHandler.php`

The `view` operation is granted only when **all** hold:

1. the current user exists and their `user.data` `privatemsg/enable` flag is truthy;
2. the thread is not soft-deleted (`isDeleted()` → forbidden);
3. either the user has `administer site configuration`, **or** the user has
   `privatemsg write messages` **and** `owner === current user id`.

Because every conversation is stored as one thread row per participant (`owner` = that
participant), the `owner === current user` check means a user can only ever `view` their own copy
of a conversation. Requesting another user's `privatemsg_thread` id at
`/messages/view/{privatemsg_thread}` returns 403. **No cross-user thread-read IDOR.** (Comparison
is strict `===` on `owner->target_id` vs `$account->id()`; both are strings from the DB, so it
fails closed, never open.)

The canonical route also carries `_permission: 'privatemsg write messages'` as a second gate.

## Thread action operations — same handler, weaker

The same handler serves `mark_read`, `mark_unread`, `remove_thread`, and `change_tags`. For these
it checks **only a permission** — `privatemsg use messages actions` (plus
`privatemsg change thread tags` for `change_tags`) — and does **not** check `owner`/membership.
These operations are the access check that the VBO bulk actions rely on (each action's `access()`
calls `$thread->access('<op>')`). See the security review file for the resulting
broken-access-control concern on `remove_thread` / `change_tags`.

## Message `view` — `src/Entity/Access/PrivatemsgMessageAccessControlHandler.php`

`view` granted when the user has `administer site configuration`, or has `privatemsg write messages`
and is either the message owner **or** a member of the thread that `getThreadFromMessage(mid, uid)`
resolves (i.e. the user has their own thread row containing this message). Rendering messages inside
a thread therefore re-checks per-message membership. The standalone message page additionally
requires `administer privatemsg`.

## The inbox view — `all_privatemsg_threads` (page_1)

Access = permission `privatemsg write messages`. Crucially the rows are constrained **in the query**
by a `uid_current` filter on the `owner` relationship (`value: '1'`), so the inbox only lists
threads the current user owns — not a display-only filter. The admin display `page_2`
(`/user/%user/messages`) is gated by `administer site configuration` and takes the target uid as a
contextual argument.

## Reply gating — `PrivatemsgHooks::preprocessPrivatemsgThread()`

The inline reply form is only attached when the user has `privatemsg write messages` **and**
`$thread->isMember(currentUser)`. Posting a reply runs through the thread-canonical route, which is
already owner-gated by the access handler, so a non-participant cannot inject a reply.

## Messaging enabled/disabled

Every entry point checks the per-user `user.data` flag `privatemsg/enable`. A user who turned
messaging off on their profile cannot view threads or open the compose form (the form throws
`NotFoundHttpException`). Note this is checked for the *actor*; see forms doc for recipient checks.

## Summary

| Operation | Gate | Cross-user safe? |
|---|---|---|
| View thread `/messages/view/{id}` | owner === user + perm | Yes |
| View message page | `administer privatemsg` | Yes (admin only) |
| Inbox list | perm + `uid_current` query filter | Yes |
| Reply | owner-gated route + isMember for form | Yes |
| Delete own message | controller checks owner | Yes (own only) |
| Leave thread | controller checks owner | Yes (own only) |
| VBO mark read/unread | **permission only** | read/unread is a no-op on others' rows |
| VBO remove / change tags | **permission only, no owner check** | **No — see security review** |
