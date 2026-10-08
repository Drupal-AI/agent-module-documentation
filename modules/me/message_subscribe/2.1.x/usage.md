Message Subscribe is a developer subscription API on top of Flag, Message, and Message Notify: users subscribe to entities via `subscribe_*` flags, and your code hands a Message to the `message_subscribe.subscribers` service, which finds all subscribers and delivers a per-user notification (email by default) to each.

---

The module provides no end-user UI on its own (that's the `message_subscribe_ui` submodule) — it is an API. Subscriptions are ordinary Flag flaggings: any flag whose machine name starts with the configured prefix (`subscribe_`, from `flag_prefix`) is treated as a subscription flag, so `subscribe_node`, `subscribe_term`, `subscribe_user` (shipped as optional, disabled-by-default flags) let users flag content, terms, or other users. When something happens (a node is published, a comment is added), the implementing module builds a `Message` entity and calls `\Drupal::service('message_subscribe.subscribers')->sendMessage($entity, $message)`. The service extracts a "context" from the entity (the entity itself, its author, referenced taxonomy terms, and for comments the commented node), queries the `flagging` table to find every user subscribed to anything in that context, filters them (blocked users, entity-view access, and optionally the actor themselves), assigns each a set of message notifiers, then sends a cloned copy of the message to each recipient via Message Notify. Delivery can run inline or be pushed through Drupal's queue (`use_queue`) with a configurable batch `range` for scalability. Everything is customizable through three hooks (`hook_message_subscribe_get_subscribers`, `…_get_subscribers_alter`, `hook_message_subscribe_message_alter`) and a `DeliveryCandidate` value object that carries the flags, notifiers, and uid for each recipient. Admin settings live at `/admin/config/message/message-subscribe`.

---

- Email users when new content is published in a section they subscribed to.
- Notify subscribers of a taxonomy term whenever content tagged with that term appears.
- Let users "follow" other users and get notified about their activity.
- Send a notification to a node's author (and term/group subscribers) when a comment is added.
- Build a scalable mass-notification pipeline that queues and batches sends via cron.
- Fan out one Message entity into personalized per-recipient notifications.
- Drive notifications entirely from code via `message_subscribe.subscribers::sendMessage()`.
- Retrieve the list of users subscribed to an entity with `getSubscribers()` for custom logic.
- Add extra recipients programmatically with `hook_message_subscribe_get_subscribers()`.
- Filter or remove recipients (e.g. respect a per-user preference) via `…_get_subscribers_alter()`.
- Alter the message per recipient (personalize subject/body) with `hook_message_subscribe_message_alter()`.
- Choose default delivery channels for every subscription (`default_notifiers`, e.g. `email`).
- Skip notifying users about their own actions (or opt them in) with `notify_own_actions`.
- Use the `subscribe_` naming convention to add your own subscription flags for custom entity types.
- Change the subscription flag prefix (e.g. to `follow`) via `flag_prefix` to match existing flags.
- Respect entity view access so users are never emailed about content they can't see.
- Exclude blocked users from notifications automatically.
- Deliver to a hand-picked recipient list by passing `uids` in `$subscribe_options`.
- Cap how many subscribers are processed per batch with the `range` setting.
- Turn on verbose `debug_mode` logging to trace why a given user was or wasn't notified.
- Integrate with OG-style groups by adding a `subscribe_og` flag (when Organic Groups is present).
- Extend delivery beyond email by registering additional Message Notify notifiers and default notifiers.
- Reuse `getBasicContext()` to gather an entity's author and referenced terms for custom notifications.
- Process queued subscription messages during cron via the `message_subscribe` queue worker.
