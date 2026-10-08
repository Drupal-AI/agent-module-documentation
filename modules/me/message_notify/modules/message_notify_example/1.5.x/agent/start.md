# Message notify example — agent index

Demonstration submodule of **Message Notify**. Single behavior: a `hook_comment_insert()`
that, when a comment is posted on a node, sends an email notification to the **node's author**
using the `example_create_comment` Message template and the `message_notify.sender` service.
No config UI, permissions, services, or plugins of its own. Depends on `message`,
`message_notify`, `message_example`.

This module is small enough that reading its one hook is cheap; there are no separate
solution docs. The mechanics:

```php
// modules/message_notify_example/message_notify_example.module
function message_notify_example_comment_insert(Comment $comment) {
  $node = $comment->get('entity_id')->first()->get('entity')->getTarget()->getValue();
  $notifier = \Drupal::service('message_notify.sender');
  $message = Message::create(['template' => 'example_create_comment', 'uid' => $node->getOwnerId()]);
  $message->set('field_comment_reference', $comment);
  $message->set('field_published', $comment->isPublished());
  $message->save();
  $notifier->send($message);                 // defaults to the 'email' notifier
}
```

Key facts an agent needs:
- Template used: **`example_create_comment`** (provided by `message_example`), with fields
  **`field_comment_reference`** (entity ref → comment) and **`field_published`** (boolean).
- Recipient = the node owner's email; a node with an **anonymous** owner (uid 0) makes the
  email notifier throw (`MessageNotifyException`) because there is no recipient.
- The email can be empty until the `mail_subject` / `mail_body` view displays for the
  `example_create_comment` bundle are configured (see the parent module's
  `agent/configure/rendering.md`).
- For the send/notification API itself, see the parent:
  `../../../../1.5.x/agent/api/send.md` and `../../../../1.5.x/agent/plugins/notifier.md`.
