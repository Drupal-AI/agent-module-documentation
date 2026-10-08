<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities: messages and threads

## `privatemsg_message` — `src/Entity/PrivatemsgMessage.php`

Content entity, base table `pm_message`. Base fields:

- `owner` — entity_reference to `user`, the author. Set from the current user in `preCreate()`.
- `message` — `text_long`, required, cardinality 1, **not** translatable. Carries a text format;
  rendered through the format's filters (see access/security notes).
- `created` — created timestamp.
- `deleted` — timestamp; non-empty means the message is soft-deleted (`markMessageAsDeleted()`).

Handlers: form `add` = `PrivatemsgMessageForm`; access =
`PrivatemsgMessageAccessControlHandler`; route provider `PrivatemsgMessageHtmlRouteProvider`.
`admin_permission = administer privatemsg`. Canonical route `/privatemsg_message/{privatemsg_message}`
additionally requires the `administer privatemsg` permission, so individual message pages are
admin-only; normal users see messages only rendered inside a thread.

## `privatemsg_thread` — `src/Entity/PrivatemsgThread.php`

Content entity, base table `pm_index`. **One row per participant.** Base fields:

- `owner` — entity_reference to `user`; the single participant who owns this row.
- `group` — integer; identical across all rows of one conversation. Ties the per-owner rows
  together. New group number = `getLastThreadGroupNumber() + 1`.
- `members` — entity_reference to `user`, unlimited cardinality, required; the full participant
  list (same on every row of the group).
- `private_messages` — entity_reference to `privatemsg_message`, unlimited; the shared messages.
- `subject` — string(255). Used as the entity label.
- `tags` — entity_reference to taxonomy terms in the `privatemsg_tags` vocabulary (per-user tags).
- `updated_custom` — timestamp used for inbox sorting/unread math; `updated` is a core `changed`.
- `deleted` — timestamp; set by `markAsDeleted()`. A deleted thread is refused by the access
  handler and filtered out of the inbox view.

Helper methods: `getMembersId()`, `isMember($id)` (in_array over member target ids),
`getOwnerId()` (returns `owner->target_id`), `getGroup()`, `getMessages()`, `getMembers()`,
`removeMember()` (only if >2 members remain), `addHistoryRecord()` (writes a `pm_thread_history`
row on first save via `postSave()`).

## The service — `src/PrivateMsgService.php` (`privatemsg.common`)

Central helper implementing `PrivateMsgServiceInterface`. Notable methods:

- `createNewMessage($author_id, $text, $format)` — creates one `privatemsg_message`.
- `createNewThreads($subject, $members)` — creates one thread row per member, all sharing a new
  group.
- `createNewMessageAndThreads(...)` — the programmatic "send" entry point (message + threads +
  attach). Use this to send messages from code.
- `getThreadFromMessage($message_id, $user_id)` — loads the thread row for a message **owned by a
  specific user**; this is how per-user scoping is enforced when rendering a message.
- `getThreadsForUser`, `getThreadsFromGroup`, `getUnreadThreadCount` (drives the block/menu badge).
- Read state: `updateThreadGroupLastAccessTime`, `getThreadGroupLastAccessTime`,
  `markThreadGroupAsUnread` (all keyed by uid + thread_group in `pm_thread_history`).
- Block lists: `isUserBlocked($a,$b)` (true if **either** direction blocks), `blockUser`,
  `unblockUser` (only ever touches the caller's own `who` rows), `canBeBlocked` (respects
  `unblockable_roles`), `getBlockedByUserId`.

## Conversation lifecycle

1. Compose: `PrivatemsgMessageForm` on `entity.privatemsg_message.add` creates one message, then one
   thread row per recipient (plus the sender) sharing a new `group`.
2. Reply: submitting the embedded form on a thread canonical page appends the new message id to
   every thread row in the group and bumps `updated_custom`.
3. Read: rendering a message updates the viewer's `pm_thread_history.access_timestamp`.
4. Delete: `markMessageAsDeleted()` / `markAsDeleted()` set timestamps; `hook_cron` hard-deletes
   messages older than `remove_after` days.
