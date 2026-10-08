<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification System Dispatch (notification_system_dispatch) — agent index

Outbound-delivery framework for **notification_system**. Defines the
**`notification_system_dispatcher`** channel plugin type, a queue pipeline, per-user preferences,
and send-mode bundling. Depends on `notification_system`. `configure: notification_system_dispatch.settings`.

## Solution docs
- **Dispatcher plugin type + writing a channel** → [plugins/dispatcher.md](plugins/dispatcher.md)
- **Pipeline: event → bundle → queue → worker → dispatch; user settings; site settings** → [api/pipeline-and-settings.md](api/pipeline-and-settings.md)

## Provides
- Plugin type **`notification_system_dispatcher`** (`Plugin/NotificationSystemDispatcher`, manager
  `plugin.manager.notification_system_dispatcher`, interface `NotificationSystemDispatcherInterface`,
  base `NotificationSystemDispatcherPluginBase`, annotation `@NotificationSystemDispatcher`, alter
  `notification_system_dispatcher_info`). Send-mode constants `SEND_MODE_IMMEDIATELY=1`,
  `SEND_MODE_DAILY=2`, `SEND_MODE_WEEKLY=3`.
- Service **`notification_system_dispatch`** (`Service/NotificationDispatcherService`) — `queue()`:
  turns a notification list for a user into queue items, one per enabled channel; honors whitelist,
  forced dispatcher, and per-group opt-outs.
- Service **`notification_system_dispatch.user_settings`** (`Service/UserSettingsService`) — reads/
  writes per-user channel + group + send-mode + last-dispatch data in `user.data`
  (`notification_system_dispatcher` module key).
- Event subscriber **`NotificationSystemDispatchSubscriber`** — on `NewNotificationEvent`, per
  audience user either `queue()`s immediately or appends to that user's `notification_dispatch_bundle`.
- Queue worker **`notification_system_dispatch`** (`Plugin/QueueWorker/DispatchQueue`, cron 30s) —
  loads notifications by provider+id, instantiates the dispatcher, calls `dispatch($user, $notifications)`.
- Content entity **`notification_dispatch_bundle`** (`Entity/NotificationDispatchBundle`) — holds a
  user's accumulated notifications (field type `notification_reference`); access handler restricts
  to `administer notification dispatch bundle entities`.
- Block **`notification_system_dispatch_usersettings`** (`Plugin/Block/UserSettingsBlock`) — renders
  `UserSettingsForm`; authenticated users only.
- `hook_cron` — flush due bundles to the queue and delete them.

## Routes / permissions
- `notification_system_dispatch.settings` — `/admin/config/system/notification-system-dispatch` —
  `administer notification_system_dispatch configuration`.
- Permission `administer notification dispatch bundle entities` (`restrict access: true`).

## Config
`notification_system_dispatch.settings` — `send_mode`, `enable_bundling`,
`default_enabled_dispatchers` (sequence), `forced_dispatcher`. Whitelist is stored in **state**
(`notification_system_dispatch.enable_whitelist` / `.whitelist`), not config.
