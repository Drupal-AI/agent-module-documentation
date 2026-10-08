Message notify example is a developer demonstration submodule of Message Notify: when a new comment is posted on a node, it sends an email notification to that node's author using the `example_create_comment` Message template.

---

This module is a teaching example, not meant for production. It ships only a `.module` file with a single `hook_comment_insert()` implementation: on every new comment it loads the node the comment was posted on (from the comment's `entity_id` reference), creates a `Message` entity of template `example_create_comment` owned by the node's author, sets the message's `field_comment_reference` to the comment and `field_published` to the comment's published state, saves it, and calls the `message_notify.sender` service's `send()` to email it. It depends on `message`, `message_notify`, and `message_example` (which provides the `example_create_comment` template and its fields). Because the email notifier resolves the recipient from the message owner, the node must have a real (non-anonymous) author with an email address, and the site must have working mail. As shipped, the notification email can be blank until you configure the `mail_subject` / `mail_body` view displays for the `example_create_comment` message bundle (the README calls this out). It has no configuration UI, permissions, services, or plugins of its own.

---

- Learn how to trigger a Message Notify notification from an entity hook (`hook_comment_insert`).
- See how to build a `Message` entity and populate its reference/boolean fields in code.
- See how to call the `message_notify.sender` service to deliver a notification.
- Notify a node's author by email whenever someone comments on their content.
- Use as a copy-paste starting point for a custom "new comment" notification module.
- Demonstrate wiring a Message template (`example_create_comment`) to a real event.
- Show how the message owner (`uid`) determines the email recipient of a notification.
- Illustrate attaching contextual data (the comment) to a message via an entity reference field.
- Illustrate passing the comment's published state to the message via a boolean field.
- Test end-to-end notification delivery on a dev site by commenting on a node.
- Explore how `mail_subject` / `mail_body` view displays shape the resulting email.
- Serve as a reference for the minimal code needed to send a Message Notify email.
- Teach the dependency chain: message → message_notify → message_example.
- Prototype comment-driven engagement emails before writing a bespoke module.
- Demonstrate that saving the message plus sending it happens inside the comment insert flow.
- Understand why a node with an anonymous owner cannot receive the example's email.
- Show site builders where to enable custom display settings for message notify view modes.
- Provide a working fixture for training or documentation about Message Notify.
