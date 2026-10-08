<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message Notify — notifier service

## Service `private_message_notify.notifier`
Class `Drupal\private_message_notify\Service\PrivateMessageNotifier`
implements `PrivateMessageNotifierInterface`.

```php
$notifier = \Drupal::service('private_message_notify.notifier');
$notifier->notify(PrivateMessageInterface $message, PrivateMessageThreadInterface $thread);
```

`notify()` is normally called for you by the submodule's
`hook_private_message_new_message()` implementation whenever
`PrivateMessageThreadManager::saveThread()` posts a message — you rarely call it directly.

### What `notify()` does, per thread member
1. Skips the message author (`$member->id() == currentUser`) and any member with no email
   (logged as a warning to channel `private_message_notify`).
2. Calls the private `shouldSend()` decision (below).
3. Creates a `message` entity: template `private_message_notification`, `uid` = recipient,
   sets `field_message_private_message` = the message and `field_message_pm_thread` = the
   thread, sets the recipient's preferred language, saves it.
4. Sends it via `message_notify.sender` (`MessageNotifier::send()`).

The recipient list comes from `getNotificationRecipients($message, $thread)` =
`$thread->getMembers()` minus anyone added to `$exclude` by
`hook_private_message_notify_exclude()`.

### `shouldSend()` logic (all from `private_message.settings` + user data)
- Returns false unless `enable_notifications` is true.
- Recipient is eligible if their user-data `receive_notification` is truthy, **or** they have
  set nothing and `notify_by_default` is true.
- If eligible: notify when the recipient's `notify_when_using` (user-data, else the
  `notify_when_using` setting) is `'yes'`, **or** when they have been away longer than their
  away threshold — `message created time − thread last-access time > away seconds`, where away
  seconds is the user-data `number_of_seconds_considered_away` else the site setting.

Per-user preferences live in user data under module key `private_message`:
`receive_notification`, `notify_when_using`, `number_of_seconds_considered_away` (set from the
user's profile form provided by the parent module).

## Shipped config (config/install)
- `message.template.private_message_notification` — the Message template; token text renders
  `[private_message:author-name]`, `[private_message:message]`, and
  `[private_message_thread:url]`. Has `default`, `mail_subject`, and `mail_body` view displays.
- Field storages/instances on the `message` entity:
  `field_message_private_message` (→ private_message) and `field_message_pm_thread`
  (→ private_message_thread).

No config schema, routes, permissions, or Drush are added by this submodule.
