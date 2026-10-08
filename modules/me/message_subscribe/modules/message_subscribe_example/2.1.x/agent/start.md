# Message Subscribe Example — agent index

An **example / starter** submodule: message templates + fields + entity hooks that create and send
subscription notifications, meant to be copied and adapted. No configuration (`configure=null`).

- **The templates, fields, and the hook_ implementations it demonstrates** →
  [api/implementation.md](api/implementation.md)

Key facts:
- Ships message templates: `create_node`, `publish_node`, `update_node`, `create_comment`,
  `user_register`, with fields `field_node_reference`, `field_comment_reference`, `field_user`,
  `field_published` on the `message` entity.
- Implements `hook_node_insert` / `hook_node_update` / `hook_comment_insert` / `hook_user_insert` to
  build a `Message` and call `message_subscribe.subscribers::sendMessage()`.
- `hook_message_subscribe_get_subscribers_alter()` forces the `email` notifier on all recipients and
  adds administrators.
- Demonstrates a hand-built recipient list via explicit `uids` in `$subscribe_options` (user_register).
- Pulls in `message_ui`, `message_notify_ui`, `token`, `comment`. Its hooks fire on **every**
  node/comment/user insert — enable only when you want that. It is a code sample, not a dependency.
