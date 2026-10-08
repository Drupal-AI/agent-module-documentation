# What the example implements

`message_subscribe_example.module` is the whole point — copy it. All logic is in hook implementations
that build a `Message` and send it via `\Drupal::service('message_subscribe.subscribers')`.

## Templates & fields (config/optional)

Message templates: `create_node`, `publish_node`, `update_node`, `create_comment`, `user_register`,
each with default + `mail_subject` + `mail_body` view displays. Fields on the `message` entity:
`field_node_reference`, `field_comment_reference`, `field_user` (entity references back to the
subject), and `field_published` (boolean mirroring the source's publish state).

## Hooks

- **`hook_node_insert`** — builds a `publish_node` (published) or `create_node` (unpublished) message
  for the node author, sets `field_node_reference`/`field_published`, saves it. For `article` nodes it
  **auto-subscribes all active users** to `subscribe_node` via the flag service. If published, calls
  `sendMessage($node, $message)`.
- **`hook_node_update`** — keeps the message publish state in sync (`update_message_status()`), builds
  `publish_node` (newly published) or `update_node`, emails the author immediately with
  `message_notify.sender`, and (if published) calls `sendMessage()` for subscribers.
- **`hook_comment_insert`** — builds a `create_comment` message referencing the comment, emails the
  node author immediately, then `sendMessage($comment, $message)` (the base module's context expands a
  comment to its node + author).
- **`hook_user_insert`** — builds a `user_register` message and sends it to a **hand-built recipient
  list of administrators** by passing explicit `uids` (`DeliveryCandidate`s) in `$subscribe_options`,
  demonstrating how to bypass flag-based subscriber lookup.

## Patterns to copy

- Force a channel on everyone: `hook_message_subscribe_get_subscribers_alter()` calls
  `$candidate->addNotifier('email')` for each recipient and adds active `administrators` as new
  `DeliveryCandidate`s.
- Immediate vs subscription send: `message_notify.sender->send($message, [], 'email')` for a direct
  one-off, vs `message_subscribe.subscribers->sendMessage()` for fan-out to subscribers.
- Custom recipient list: set `$subscribe_options['uids'][$uid] = new DeliveryCandidate($flags, $notifiers, $uid)`
  to send to exactly those users (skips `getSubscribers()`).

Note the README also lists suggested upstream patches; they are historical and not required to run.
