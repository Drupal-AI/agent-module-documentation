<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Private Messages (privatemsg) 2.x lets authenticated users exchange private, threaded messages through a Views-based inbox at `/messages`. A conversation is stored as two custom content entities: `privatemsg_message` (the body + author) and `privatemsg_thread` (one row per participant, all sharing a numeric `group`). Users compose to one or more recipients (or whole roles) via autocomplete, reply inside a thread, mark threads read/unread, delete their own messages, block other users, and tag threads. An unread-counter block and an account-menu badge surface new messages.

---

Privatemsg 2.x replaces the Drupal 6/7 schema with an entity model. Sending a message creates one shared `privatemsg_message` entity and then one `privatemsg_thread` entity per participant; every thread row in the conversation carries the same `group` integer, the same `members` entity-reference list, and references the same message entities through the `private_messages` field, but each row's `owner` is a distinct participant. This per-owner-row design is how access is scoped: the thread access control handler grants `view` only when `owner === current user`, so the canonical URL `/messages/view/{privatemsg_thread}` only ever resolves to the viewer's own copy of a conversation. Reading state is tracked in the custom `pm_thread_history` table (uid + thread_group + access_timestamp), block relationships in `pm_block_user` (who/blocked), and the message/thread base tables are `pm_message` and `pm_index`. The inbox is the `all_privatemsg_threads` view, filtered to the current user via a `uid_current` filter on the owner relationship, with Views Bulk Operations (VBO) actions for mark read, mark unread, remove, and change tags. A decorated entity autocomplete matcher powers recipient selection (respecting block lists and the per-user "enable messages" flag), role-targeted sending (gated by `privatemsg send to role` and an `allowed_roles` config list), and thread-tag selection. Hooks add a "Send this user a private message" link and a privatemsg settings section (enable/notify) to user profiles, an unread badge to the account menu, an email notification on new messages, and a cron job that hard-deletes soft-deleted messages after a configurable number of days. Configuration lives at `/admin/config/content/privatemsg-settings` (`remove_after`, `allowed_roles`, `moderator_role`, `unblockable_roles`). Migration submodules cover Drupal 6 and 7; a `drush privatemsg:1to2` command migrates data from privatemsg 1.x tables.

---

- Build a community/forum site where members send each other private messages.
- Let users start a new conversation from `/messages/new` or `/messages/new/{uid}` (prefilled recipient).
- Add a "Send this user a private message" link on user profile pages.
- Send one message to multiple recipients at once (comma-separated autocomplete).
- Send a message to every user in a role (with the `privatemsg send to role` permission and an allowed role).
- Give users a threaded inbox at `/messages` with subject, participants, message count, and last-updated columns.
- Show an unread-message counter in a block (`privatemsg_block`) and as a badge on the account menu item.
- Let users reply inline within a conversation thread.
- Let users delete their own individual messages (soft delete, later purged by cron).
- Let a user leave a group conversation of 3+ participants.
- Let users bulk mark threads read/unread, remove threads, or change tags from the inbox.
- Let users tag their own threads with personal taxonomy tags and filter the inbox by tag.
- Let users block other users so neither can message the other, managed at `/messages/blocked`.
- Designate roles whose users cannot be blocked (`unblockable_roles`), e.g. site staff.
- Email users a link to new messages when they have notifications enabled in their profile.
- Let users opt out of private messaging entirely via a profile checkbox.
- Give administrators a read-only view of any user's messages at `/user/{uid}/messages`.
- Automatically purge soft-deleted messages from the database after N days via cron.
- Migrate existing private messages from a Drupal 6 or Drupal 7 site using the bundled migration submodules.
- Migrate data from privatemsg 1.x using `drush pmsg1to2`.
- Send messages programmatically through the `privatemsg.common` service (`createNewMessageAndThreads()`).
- Filter and search the inbox by subject, participant name, or tag.
