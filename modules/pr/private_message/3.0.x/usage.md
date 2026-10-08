<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Private Message adds a full user-to-user private messaging system to Drupal: logged-in users hold threaded conversations through an inbox, notification, and thread-view UI built from blocks and AJAX, without any dependency on email.

---

The module defines two content entity types — `private_message` (a single message: owner, `message` text_long body, `created`) and `private_message_thread` (a conversation with a `members` user reference list plus per-user last-access/last-delete history) — stored in their own base tables. Users reach conversations at `/private-messages`, compose at `/private-message/create`, and read a thread at `/private-messages/{id}`; an AJAX controller streams new/old messages and inbox updates. Three blocks provide the UI: the inbox block, the notification (unread count) block, and the actions block. A `PrivateMessageService` handles thread lookup/creation, inbox and unread-count queries, and access-time bookkeeping, while `PrivateMessageThreadManager::saveThread()` is the one-call entry point for posting a message (creating the thread from its members if needed). Users can block/ban each other via `private_message_ban` entities managed by `PrivateMessageBanManager`, with a configurable passive or active ban mode. Global behavior lives in the `private_message.settings` config object (notification defaults, away threshold, ban labels/mode, send-key, button labels, CSS opt-out) editable at `/admin/config/private-message/config`, and the module exposes a `private_message_config_form` plugin type so other modules can add sections to that settings page. It ships permissions, Views data/filters/fields, entity-reference selection that hides banned users, a Rules action, a `private_message_new_message` hook, and a `private_message:prepare_uninstall` Drush command. The optional `private_message_notify` submodule adds email notifications on new messages.

---

- Let authenticated users send each other private, threaded messages through an on-site inbox rather than email.
- Provide a one-page AJAX messaging experience (inbox + thread + composer) similar to social-network direct messages.
- Programmatically start a conversation between two or more users and post the first message with `PrivateMessageThreadManager::saveThread()`.
- Look up (or lazily create) the shared thread for a given set of members via `PrivateMessageService::getThreadForMembers()`.
- Show an inbox block listing a user's most recently updated conversations, refreshed by AJAX.
- Display an unread-thread or unread-message count badge with the notification block.
- Place a "New message" / actions block that links users into the messaging UI.
- Add a "Send a private message" link to a user profile, node, or comment through the module's entity view integration.
- Let users block/ban other users so they can no longer receive their messages (passive or active ban mode).
- Configure the wording of block/unblock buttons, the create/send button labels, and the blocked-user message.
- Set how many seconds of inactivity mark a user as "away" from a thread for notification purposes.
- Choose the keyboard shortcut that sends a message (e.g. Enter) and toggle input autofocus.
- Hide the recipient field when a recipient is pre-filled through the URL.
- Opt out of the module's bundled CSS to fully theme the messaging UI yourself.
- Restrict who may message at all with the `use private messaging system` permission.
- Give moderators `administer private messages` / `delete any private message` to police conversations.
- Let a user delete their own sent messages, or a whole thread for every participant, using the delete permissions.
- Clear a user's personal history in a thread (soft delete) without removing it for the other members.
- Build Views of threads filtered by unread state or by whether the current user has a new message.
- Add custom sections to the Private Message settings page by writing a `private_message_config_form` plugin.
- Alter the rendered private message markup per author with `hook_private_message_view_alter()`.
- React to every newly posted message (counters, integrations, logging) with `hook_private_message_new_message()`.
- Send a private message as a Rules action in response to any event.
- Use the not-blocked-user entity-reference selection so recipient autocomplete never suggests users who have blocked you.
- Email users when they receive a new message by enabling the `private_message_notify` submodule.
- Cleanly wipe all messages and threads before uninstalling with `drush private_message:prepare_uninstall`.
- Expose per-user notification preferences (receive, notify-while-using, away threshold) stored in user data.
