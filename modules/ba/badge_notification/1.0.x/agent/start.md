<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Badge Notification (badge_notification) — agent index

Shows logged-in users **"New"/"Updated"** status markers and **unread-count** badges, computed from
core's `history` table and loaded **asynchronously** (no page-cache impact). Package *User Interface*.
Version **1.0.9**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

Depends on core **`history`**, **`views`**, **`menu_ui`**. Provides one permission
(`administer badge notification`) and one plugin type (`@BadgeNotification`). No config schema shipped
(config object `badge_notification.settings` is written but not schema-validated).

## What it provides (from source)

- **Plugin type** `badge_notification` — manager `Plugin/BadgeNotificationManager.php`
  (service `plugin.manager.badge_notification`), annotation `Annotation/BadgeNotification.php`
  (`id`, `label`, `has_menu_notification`), base `Plugin/BadgeNotificationBase.php`, interface
  `BadgeNotificationInterface::badgeResult($badge_id, $attributes)`. Three plugins in
  `src/Plugin/BadgeNotification/`: `node_is_new` (NodeIsNew), `views_count_new` (ViewsCountNew),
  `views_has_new` (ViewsHasNew).
- **Route** `badge_notification.post` — `POST /badge-notification/get/json` →
  `Controller/BadgeNotificationController::json()`. Requirement `_role: authenticated`.
- **Route** `badge_notification.admin.settings` — `/admin/config/content/badge-notification` →
  `Form/BadgeNotificationSettingsForm` (permission `administer badge notification`). Menu link in
  `*.links.menu.yml`.
- **Services** `badge_notification.core` (`Service/BadgeNotificationCore` — reads settings, computes
  time limit) and `badge_notification.menu` (`Service/BadgeNotificationMenu` — menu-link handler
  options + View execution/counting).
- **Library** `badge_notification/badge_notification.assets` (`js/badge-notification.js`,
  `Drupal.behaviors.badge_notification`), attached to every authenticated page via
  `hook_page_attachments`.
- **Theme hook** `badge_notification` → `templates/badge-notification.html.twig`
  (`<span {{ attributes }}>{{ content }}</span>`).
- **Hooks** in `badge_notification.module`: `entity_extra_field_info` (adds hidden `Content status`
  extra field to every node bundle), `ENTITY_TYPE_view` (renders the node placeholder),
  `form_menu_link_content_form_alter` + submit (attach handlers to menu links),
  `link_alter` (inject menu-link placeholders), `views_query_alter` (new-item filtering), `theme`,
  `help`.

## Solution docs

- **Settings, install/enable, plugins, routes & how it operates** →
  [config/settings.md](config/settings.md)
- **The async JSON endpoint, plugins, and writing a custom badge plugin** →
  [api/badges.md](api/badges.md)
