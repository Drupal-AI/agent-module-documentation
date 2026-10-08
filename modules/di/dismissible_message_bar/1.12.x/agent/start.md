<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dismissible Message Bar — agent index

Dismissible notification bars built from Paragraphs, rendered by a block, filtered client-side by
path / content type / date, and remembered as dismissed via a cookie. Provides the
`dmb_notifications_entity` content entity + `dmb_notification_type` vocabulary. Requires `paragraphs`
and `datetime_range`. No global settings page (`configure` null); no config schema of its own; no Drush.

- **Create/configure notifications: the entity, its bundle fields, the block, path/date/type targeting, cookie & auto-dismiss behavior** →
  [configure/notifications.md](configure/notifications.md)
- **The 8 permissions and what each gates (incl. which are grantable to non-admins)** →
  [permissions/permissions.md](permissions/permissions.md)
- **`DmbNotificationService` API — query visible notifications, current-page check, next-change timing** →
  [api/service.md](api/service.md)

Key facts:
- Entity type `dmb_notifications_entity`; default bundle `default`; vocabulary `dmb_notification_type`.
- Block plugin id `dmb_notifications_block` (optionally scoped to a notification type term).
- Visible notifications + their rules are pushed to `drupalSettings.dmbNotificationEntities`; `js/dismissible_message_bar.js` picks which show.
- Dismissal cookie name: `dismissible_message_bar` (dot-separated notification ids); kept `field_cookie_expiration` days unless `field_cookie_off` is set.
- Path fields (`field_notification_pages`, `field_excluded_pages`) are newline-separated, support `*` wildcard and `!` negation; excluded overrides sitewide.
