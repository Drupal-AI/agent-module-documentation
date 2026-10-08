Message Subscribe Example is a ready-to-copy reference implementation wiring Message, Message Notify, and Message Subscribe together: it ships message templates and fields and implements the entity hooks that create and send subscription notifications on node/comment/user events.

---

This is an **example / starter** submodule — enable it to see the whole Message stack working end to
end, then copy and adapt its code. It provides five message templates (`create_node`, `publish_node`,
`update_node`, `create_comment`, `user_register`) with reference fields (`field_node_reference`,
`field_comment_reference`, `field_user`, `field_published`) and implements `hook_node_insert`,
`hook_node_update`, `hook_comment_insert`, and `hook_user_insert` to build the matching `Message`
entity and hand it to `message_subscribe.subscribers::sendMessage()`. It demonstrates several
patterns: auto-subscribing all active users to new articles (`subscribe_node`), forcing the `email`
notifier and injecting administrators via `hook_message_subscribe_get_subscribers_alter()`, and
sending to a hand-built recipient list (admins) by passing explicit `uids` in `$subscribe_options`
(for new-user notifications). It has no configuration; it is intentionally a code sample. On a shared
site note that its hooks fire on **every** node/comment/user insert, so it is best enabled only when
you actually want that behavior.

---

- Bootstrap a real Message + Message Notify + Message Subscribe setup by enabling one module.
- See how to create a `Message` entity and call `sendMessage()` from `hook_node_insert`.
- Learn to send `publish_node` vs `create_node` messages based on a node's published state.
- Copy the `hook_comment_insert` pattern that notifies a node's subscribers of new comments.
- Copy the `hook_node_update` pattern for notifying subscribers when content changes.
- See how to auto-subscribe all active users to new articles via the flag service.
- Learn to force a notifier (email) on every recipient in `…_get_subscribers_alter()`.
- See how to always include administrators in a subscription list.
- Learn to notify a custom recipient list by passing explicit `uids` (new-user → admins).
- Use the shipped message templates as a starting point for your own notification content.
- Study reference fields (`field_node_reference`, etc.) linking messages back to their subject entity.
- See how message publish state is kept in sync with the source entity (`update_message_status`).
- Understand how the immediate `message_notify.sender` differs from queued `sendMessage()`.
- Use as documentation of the full "subscribe → event → message → notify" flow.
- Adapt the templates/fields to remove the example naming for a production build.
- Demonstrate the stack to stakeholders without writing code first.
- Test that subscriptions and notifications work on a fresh site.
- Serve as an integration test fixture for the Message stack.
