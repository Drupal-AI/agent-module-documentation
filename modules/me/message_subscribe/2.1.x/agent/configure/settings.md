# Message Subscribe settings & the flag convention

- **UI:** `/admin/config/message/message-subscribe` (route `message_subscribe.admin_settings`,
  form `MessageSubscribeAdminSettings`, permission `administer message subscribe`).
- **Config object:** `message_subscribe.settings` (has config schema).
- **Drush:** `drush config:get message_subscribe.settings`, `drush config:set message_subscribe.settings <key> <value>`.

## Config keys

| Key | Default | Meaning |
|---|---|---|
| `use_queue` | `false` | If true, `sendMessage()` enqueues the send (drained by the `message_subscribe` queue worker on cron) instead of sending inline. |
| `notify_own_actions` | `false` | If false, the user who triggered the event (entity owner/reviser) is removed from the recipients. |
| `flag_prefix` | `subscribe` | A flag is a subscription flag iff its id starts with `<flag_prefix>_`. Change it to reuse existing flags (e.g. `follow`). |
| `debug_mode` | `false` | Verbose logging of subscriber gathering/delivery to the `message_subscribe` logger channel. Not for production. |
| `default_notifiers` | `[email]` | Message Notify notifier plugin ids added to **every** recipient (`addDefaultNotifiers()`). Options come from the notifier plugin manager. |
| `range` | `100` | Max subscribers fetched per batch when queueing (`MessageSubscribeAdminSettings` labels it "Maximum subscribers per batch"). |

The settings form's notifier `#options` are the registered Message Notify notifiers (out of the
box just `email`). `message_subscribe_email` adds an extra "Email flag prefix" field to this form.

## The `subscribe_` flag convention

Subscriptions are ordinary **Flag** flaggings. `Subscribers::getFlags()` returns every flag whose
machine name starts with `flag_prefix . '_'`. The module ships these as **optional, disabled**
flags (enable the ones you need at `/admin/structure/flags`):

- `subscribe_node` (flaggable: node)
- `subscribe_term` (flaggable: taxonomy_term)
- `subscribe_user` (flaggable: user)
- `subscribe_og` (node; only imported when the OG module is present)

`getFlags($entity_type, $bundle, $account)` filters by flaggable type/bundle and, when an account is
given, by that account's flag/unflag action access. To let users subscribe to content you enable the
relevant `subscribe_*` flag and configure its bundles/display like any Flag flag.

## Permission quirk

The settings route requires `administer message subscribe`, but that permission is **defined in the
`message_subscribe_ui` submodule** (`message_subscribe_ui.permissions.yml`), not in the base module
(whose `message_subscribe.permissions.yml` is empty). With only the base module enabled the
permission does not exist, so only user 1 can reach the settings form. Enable `message_subscribe_ui`
to grant the permission to roles.
