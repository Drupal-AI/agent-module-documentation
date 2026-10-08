<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notify Widget (notify_widget) — agent index

A per-user, in-site notification system: a service to send notifications, a DB table to store
them, a header block (icon + unread badge + dropdown popup) to show them, and a full-page list to
manage them. Package **Other**. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.15.
Core-only — no contrib dependencies, no submodules, no Drush.

## Solution docs

- **Sending & the `notify_widget.api` service, the `notify_widget` DB table, query/delete/purge
  helpers** → [api/service.md](api/service.md)
- **`notify_widget.settings` config, keys, schema, install/enable** →
  [config/settings.md](config/settings.md)
- **The block, lazy builder, Twig template, libraries, user.data "new" flag** →
  [blocks/widget.md](blocks/widget.md)
- **Routes, the two ownership access checkers, controllers, confirm forms, the bulk send action**
  → [routes/notifications.md](routes/notifications.md)

## What it actually is

- **Storage:** one non-entity table `notify_widget` (`notify_widget_schema()` in
  `notify_widget.install`) — `id, uid, source, read, notification_type, notification_title,
  notification_text, link, timestamp`. Not a content entity; no fields, no views integration.
- **Service `notify_widget.api`** (`NotifyWidgetApi`): `send($source, $type, $title, $text, $uid,
  $link)` inserts a row per recipient (single id or array; 0 = current user). Also
  `markAsRead/markAsUnread`, `markAllAsReadByUserId`, `deleteNotification`,
  `deleteAllNotificationsByUserId`, `purgeOldNotificationsIfNeeded`, paged/unpaged getters and an
  unread-count.
- **Block** `notify_widget_block` (`NotifyWidgetBlock`) → `#lazy_builder`
  `notify_widget.lazy_builders:renderNotifyWidgetBlock` (`NotifyWidgetLazyBuilders`) → theme
  `notify_widget_block` / `templates/notify-widget-block.html.twig`. Adds a notifications icon,
  an iOS-style unread badge (`20+` cap), and a click-to-toggle popup (`js/notify_widget_popup.js`).
- **Action** `notify_widget_send_action` (`@Action`, type `user`) + install config
  `system.action.notify_widget_send_action` → bulk "Send notification to selected user(s)" on
  `/admin/people`, confirmed via `NotifyWidgetSendActionConfirmForm`.
- **Config** `notify_widget.settings` (`NotifyWidgetSettingsForm`, route
  `notify_widget.settings`, permission `administer site configuration`): `max_notifications`,
  `include_read`, `read_cutoff`, `purge_days_old`, `use_module_css`. Schema in `config/schema/`.

## Access model (from source)

Notifications are always per-user. The full list and mark-all routes use
`_user_can_access_notifications` (route `{user}` must equal the logged-in user); per-notification
read/unread/delete routes use `_user_owns_notification` (a row must exist with that id **and**
`uid = current_user`). The single-notification view (`/notification/{id}/view`) queries by the
current user's id, so cross-user access returns 404. Notification fields render through Twig /
table-theme auto-escaping, and all queries use the DB abstraction with placeholder conditions.

## Notes

- The bulk action checks a `send bulk notifications` permission that the module never declares
  (no `notify_widget.permissions.yml`), so it fails closed — only user 1 can use it as shipped.
- No config-install defaults ship; the code uses `?? default` fallbacks until the settings form
  is saved.
