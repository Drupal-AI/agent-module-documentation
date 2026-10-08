# Message Subscribe — agent index

A **developer subscription API** on top of Flag + Message + Message Notify. Users subscribe by
flagging entities with `subscribe_*` flags; your code hands a `Message` to the
`message_subscribe.subscribers` service, which finds subscribers and delivers a per-user
notification. No end-user UI here (that's the `message_subscribe_ui` submodule).

- **Admin settings, config keys, the `subscribe_` flag convention, the admin permission quirk** →
  [configure/settings.md](configure/settings.md)
- **The `message_subscribe.subscribers` service (`sendMessage`, `getSubscribers`, `getBasicContext`, `getFlags`), `DeliveryCandidate`, queue** →
  [api/subscribers.md](api/subscribers.md)
- **The three hooks to add/alter subscribers and personalize messages** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Configure route `message_subscribe.admin_settings` → `/admin/config/message/message-subscribe`.
- Config object `message_subscribe.settings`: `use_queue` (false), `notify_own_actions` (false),
  `flag_prefix` (`subscribe`), `debug_mode` (false), `default_notifiers` (`[email]`), `range` (100).
- A flag is a subscription flag iff its id starts with `flag_prefix` + `_` (default `subscribe_`).
  Ships optional, **disabled-by-default** flags `subscribe_node`, `subscribe_term`, `subscribe_user`
  (and `subscribe_og` when OG is present).
- Service id `message_subscribe.subscribers` = `Drupal\message_subscribe\Subscribers`.
- Queue worker plugin id `message_subscribe` (runs on cron, 60s) drains queued sends.
- The `administer message subscribe` permission (used by the settings route) is defined by the
  **message_subscribe_ui** submodule, not here.
