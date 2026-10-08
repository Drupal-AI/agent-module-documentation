<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Messages (privatemsg) 2.x — agent index

User-to-user private messaging for Drupal 10.1+/11/12, rebuilt in 2.x on two custom content
entities. Installed here as **2.0.0-rc23**. Depends on core `block`, `datetime`, `taxonomy`,
`user`, `views`, `image` and on **`views_bulk_operations`** (VBO supplies the inbox bulk actions).

## Data model (read this first)

- **`privatemsg_message`** (base table `pm_message`) — one row per message: `owner` (author, a user
  ref), `message` (a `text_long` field with a text format), `created`, `deleted` (soft-delete
  timestamp). Defined in `src/Entity/PrivatemsgMessage.php`.
- **`privatemsg_thread`** (base table `pm_index`) — **one row per participant per conversation.** A
  conversation is a set of thread rows sharing the same integer `group`. Each row has its own
  `owner` (one participant), a `members` multi-user reference (all participants, identical across
  the group), a `private_messages` multi-reference to the shared message entities, `subject`,
  `tags` (taxonomy), `updated_custom`, and `deleted`. Defined in
  `src/Entity/PrivatemsgThread.php`.
- Auxiliary tables (`privatemsg.install`): **`pm_thread_history`** (uid + thread_group +
  access_timestamp — per-user read state) and **`pm_block_user`** (who + blocked — block lists).

The per-owner-row design **is** the access model: a user only ever owns/loads their own copy of a
conversation. See `access/access-model.md`.

## Key paths & routes (`privatemsg.routing.yml` + `all_privatemsg_threads` view)

- `/messages` — inbox (Views `all_privatemsg_threads` page_1), filtered to the current user by a
  `uid_current` filter on the owner relationship. Access perm: `privatemsg write messages`.
- `/messages/view/{privatemsg_thread}` — a single thread (entity canonical). Access:
  `_entity_access: privatemsg_thread.view` **and** perm `privatemsg write messages`.
- `/messages/new/{user}` — compose form (`user` optional, prefills recipient).
- `/messages/delete/{thread_id}/{mid}` — soft-delete one own message (controller, CSRF-protected).
- `/messages/block/{user}` — AJAX toggle block/unblock (controller, CSRF-protected).
- `/messages/view/{thread_id}/leave` — leave a group thread (controller, CSRF-protected).
- `/messages/blocked` — manage blocked users.
- `/user/{uid}/messages` — admin-only read of any user's threads (perm `administer site configuration`).
- `/privatemsg_message/{privatemsg_message}` — single message view, gated by perm `administer privatemsg`.
- `/admin/config/content/privatemsg-settings` — settings (perm `administer privatemsg`).

## Permissions (`privatemsg.permissions.yml`)

`administer privatemsg` (restrict access), `privatemsg use messages actions`,
`privatemsg write messages`, `privatemsg delete own messages`,
`privatemsg view deleted messages`, `privatemsg send to role`, `privatemsg block users`,
`privatemsg change thread tags`. See `permissions/permissions.md`.

## Solution docs

- `entities/messages-and-threads.md` — the two entities, the group/owner model, the service.
- `access/access-model.md` — how thread/message view is gated, VBO action access, IDOR analysis.
- `controllers/routes-and-controllers.md` — the delete/block/leave controllers and route guards.
- `forms/compose-and-reply.md` — compose form, reply, recipient/role resolution, block checks.
- `permissions/permissions.md` — every permission and what it unlocks.
- `plugins-and-views/inbox-block-actions.md` — the inbox view, VBO actions, block, autocomplete,
  hooks, cron, drush.

## What to verify before trusting it (messaging = access-control minefield)

1. **Thread `view` access** is owner-scoped (safe against IDOR of another user's thread). ✅ verified.
2. **VBO bulk actions** (`mark_read`/`mark_unread`/`remove_thread`/`change_tags`) — their access
   handler checks a **permission only, not ownership**. Review `access/access-model.md` before
   relying on the inbox actions on a site where message privacy matters.
3. **Message body** is a `text_long` field rendered through its text format — XSS exposure follows
   whatever formats the sender is allowed to use (standard Drupal trust boundary).
