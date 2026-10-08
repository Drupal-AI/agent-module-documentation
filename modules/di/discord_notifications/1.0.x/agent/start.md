<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Discord Notifications (discord_notifications) — agent index

Posts color-coded messages to a Discord channel via an incoming webhook when selected Drupal events fire. No entities, plugins, permissions, or Drush commands.

- **Dependencies:** core `node`, `user`. No composer requirements. Core `^9 || ^10 || ^11`.
- **Config object:** `discord_notifications.settings` (schema in `config/schema/discord_notifications.schema.yml`): `webhook_url` (string), `use_here` (bool), `use_everyone` (bool), and four sequence lists `content_notifications`, `user_notifications`, `system_notifications`, `security_notifications`.
- **Route:** `discord_notifications.settings` → `/admin/config/system/discord-notifications`, form `DiscordNotificationsSettingsForm`, requires `administer site configuration`. Menu link under `system.admin_config_system`.
- **Service:** `discord_notifications.notification_service` → `Drupal\discord_notifications\Service\DiscordNotificationService` (args: `@http_client`, `@config.factory`, `@logger.factory`, `@current_user`).
- **Hooks (`discord_notifications.module`):** `hook_entity_insert/update/delete` (nodes → `handleContentNotification`), `hook_user_login`/`hook_user_insert` (→ `handleUserNotification` login/register), `hook_user_update` (blocked → `handleUserNotification`), `hook_cron` (→ `handleSystemNotification` cron_run), `hook_user_login_failed` and password-reset submit (→ `handleSecurityNotification`), plus `hook_help` and `hook_form_user_pass_form_alter`.
- **Logger channel:** `discord_notifications` (POST failures and missing-URL errors).

Solution docs:
- [Settings form & config](config/settings.md) — the config object, keys, event options, route/permission.
- [Notification service & hook wiring](api/notification-service.md) — how events reach Discord, embed shape, payload.
