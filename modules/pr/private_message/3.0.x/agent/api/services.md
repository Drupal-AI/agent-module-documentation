<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message — services & entity API

## Entities

- `private_message` (base table `private_messages`) — fields: `owner` (entity_reference→user,
  auto-set to current user on create), `message` (text_long, required, cardinality 1),
  `created`. Interface: `Drupal\private_message\Entity\PrivateMessageInterface`
  (`getOwner()`, `getOwnerId()`, `setOwner()`, `getMessage()`, `getCreatedTime()`).
- `private_message_thread` (base table `private_message_threads`) — a `members` user
  reference list plus per-user last-access / last-delete history.
  Interface `PrivateMessageThreadInterface`: `addMember(AccountInterface)`,
  `addMemberById($id)`, `getMembers()`, `getMembersId()`, `isMember($id)`,
  `addMessage(PrivateMessageInterface)`, `getMessages(bool $include_banned = FALSE)`,
  `getNewestMessageCreationTimestamp()`, `getLastAccessTimestamp($account)`,
  `updateLastAccessTime($account)`, `getLastDeleteTimestamp($account)`,
  `clearAccountHistory(?$account)`, `delete()` (also deletes all its messages).

Both are `admin_permission = "administer private messages"`, `fieldable = TRUE`.

## Services (private_message.services.yml)

| Service id | Class / interface | Purpose |
|---|---|---|
| `private_message.service` | `PrivateMessageServiceInterface` | thread lookup/creation, inbox, unread counts, access-time bookkeeping |
| `private_message.thread_manager` | `PrivateMessageThreadManagerInterface` | one-call "post a message to a thread" |
| `private_message.ban_manager` | `PrivateMessageBanManagerInterface` | user-to-user blocking/banning |
| `private_message.mapper` | `PrivateMessageMapper` | low-level DB queries (used by the service) |
| `private_message.uninstaller` | `PrivateMessageUninstaller` | batch-delete all content before uninstall |

### private_message.service — `PrivateMessageServiceInterface`
- `getThreadForMembers(array $members)` → the `PrivateMessageThread` shared by exactly those
  `User` objects; **creates one if none exists**.
- `getFirstThreadForUser(UserInterface $user)` — most recently updated thread.
- `getThreadsForUser($count, $timestamp = FALSE)` → `['threads' => [...], 'next_exists' => bool]`.
- `getCountThreadsForUser()`, `getUnreadThreadCount()`, `getUnreadMessageCount()`.
- `getNewMessages($threadId, $messageId)`, `getPreviousMessages($threadId, $messageId)`.
- `getUpdatedInboxThreads(array $existingThreadIds, $count = FALSE)` — powers the AJAX inbox.
- `updateThreadAccessTime(PrivateMessageThreadInterface $thread)`, `updateLastCheckTime()`.
- `getThreadFromMessage(PrivateMessageInterface $pm)`, `getThreadIds()`.
- `createRenderablePrivateMessageThreadLink(&$build, $entity, $display, $view_mode)` — add a
  "send private message" link when rendering another entity.

### private_message.thread_manager — `PrivateMessageThreadManagerInterface`
- `saveThread(PrivateMessageInterface $message, array $recipients = [], ?PrivateMessageThreadInterface $thread = NULL)`
  — adds `$message` to `$thread`; if `$thread` is NULL it is loaded/created from `$recipients`
  (an array of `User`/account objects). This is the canonical way to send a message and it
  fires `hook_private_message_new_message`.

### private_message.ban_manager — `PrivateMessageBanManagerInterface`
Backed by the `private_message_ban` content entity (base table `private_message_ban`).
- `banUser(int $user_id)`, `unbanUser(int $user_id)` — act as the **current user**.
- `isBanned(int $user_id)` — is that user banned *by the current user*.
- `isCurrentUserBannedByUser(int $user_id)`, `getBannedUsers(int $user_id)`.

## Recipe: send a private message in code

```php
$switcher = \Drupal::service('account_switcher');
$switcher->switchTo($sender);            // messages are owned by the current user
$message = \Drupal\private_message\Entity\PrivateMessage::create([
  'owner' => $sender->id(),
  'message' => ['value' => 'Hello!', 'format' => 'plain_text'],
]);
$message->save();
\Drupal::service('private_message.thread_manager')->saveThread($message, [$sender, $recipient]);
$switcher->switchBack();

// Fetch the shared thread (creates it if absent):
$thread = \Drupal::service('private_message.service')->getThreadForMembers([$sender, $recipient]);
$thread->getMessages();  // EntityReferenceFieldItemList of private_message entities
```

Note: when `private_message_notify` is enabled, `saveThread()` triggers an email render/send
for eligible recipients; disable it via `private_message.settings:enable_notifications` if you
need to create threads without the notification side effect.
