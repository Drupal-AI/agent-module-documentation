<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification Message — agent index

Broadcast site-wide notification messages (announcements/banners/alerts) shown for a
date window in a block, optionally gated by Condition plugins and dismissible. Provides a
`notification_message` content entity + `notification_message_type` bundle config entity, a
`Notification messages` block, and four permissions. No global settings page (`configure`
null — the module's own routing only declares a stray `notification_message.edit` route
pointing at a non-existent `NotificationMessageSettingForm`; ignore it). No Drush. Depends
on core `block`, `datetime`, `text`.

- **Message types (bundles), fields, block placement, dismiss, adding messages via Drush** →
  [configure/messages.md](configure/messages.md)
- **The four permissions and the broadcast access model (who can view what)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Entity API: `isPublished()` window logic, conditions evaluation, the block query, cron,
  the `route.entity_uuid` cache context** → [api/entity.md](api/entity.md)
- **Templates, theme hooks, suggestions, the dismiss JS library** →
  [theming/theming.md](theming/theming.md)

Key facts:
- Content entity `notification_message`; bundle config entity `notification_message_type`
  (config prefix `notification_message.type.*`); ships a `global` type.
- "Published" = now within `publish_start_date`..`publish_end_date` (`isPublished()`), NOT a
  status flag; `setPublished()`/`setUnpublished()` are no-ops.
- Block plugin id `notification_message`; block settings schema
  `block.settings.notification_message` (`type[]`, `display_mode`).
- Admin permission: `administer notification message content` (content),
  `administer notification message types` (bundles).
