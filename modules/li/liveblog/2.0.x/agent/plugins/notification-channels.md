<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification channel plugins

Real-time delivery is abstracted behind the `@LiveblogNotificationChannel`
annotation plugin type, managed by `NotificationChannelManager`
(`plugin.manager.liveblog.notification_channel`). Plugins extend
`NotificationChannelPluginBase` / implement `NotificationChannelInterface`.

**Pusher (submodule `liveblog_pusher`):**
`PusherNotificationChannel` (`src/Plugin/LiveblogNotificationChannel/`) pushes
new/updated posts over the Pusher socket service. Enable the submodule and set
the Pusher app id / key / secret / cluster in the liveblog settings.

**Selecting a channel:** the active channel and its credentials are chosen on
the admin settings form `/admin/config/content/liveblog`
(`LiveblogSettingsForm`, `administer liveblog settings`). Without a push
channel, clients fall back to polling the JSON list endpoint.

**Adding a channel:** implement a new `@LiveblogNotificationChannel` plugin
(e.g. for a different websocket provider), provide its config form and publish
logic, and it becomes selectable in the settings form.
