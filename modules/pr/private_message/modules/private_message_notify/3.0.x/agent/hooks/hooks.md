<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message Notify — hooks

Documented in `private_message_notify.api.php`.

## `hook_private_message_notify_exclude(PrivateMessageInterface $privateMessage, PrivateMessageThreadInterface $thread, array &$exclude): void`
Lets a module remove recipients from a notification by pushing their **user IDs** into
`$exclude`. Invoked by `PrivateMessageNotifier::getNotificationRecipients()` via
`invokeAll`; excluded members are filtered out before any email is created/sent.

```php
function my_module_private_message_notify_exclude($privateMessage, $thread, array &$exclude): void {
  foreach ($thread->getMembers() as $member) {
    // e.g. honour a per-user "mute this thread" flag.
    if (my_module_has_muted($member->id(), $thread->id())) {
      $exclude[] = $member->id();
    }
  }
}
```

This is the only hook the submodule invites. (It *implements* the parent's
`hook_private_message_new_message()` to trigger notifications, but that hook is defined by the
parent module.)
