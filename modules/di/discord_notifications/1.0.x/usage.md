Discord Notifications posts messages to a Discord channel through an incoming webhook when selected Drupal content, user, system, and security events occur.

---

The module registers a set of core hook implementations (`hook_entity_insert/update/delete` for nodes, `hook_user_login/insert/update`, `hook_cron`, `hook_user_login_failed`, and a password-reset form submit handler) that all delegate to a single service, `discord_notifications.notification_service` (`DiscordNotificationService`). The service reads the `discord_notifications.settings` config object, checks whether the triggering event type is enabled in one of four sequence lists (`content_notifications`, `user_notifications`, `system_notifications`, `security_notifications`), builds a color-coded Discord embed, optionally prefixes an `@here` or `@everyone` mention, and POSTs a JSON payload (`content` + `embeds`) to the configured `webhook_url` with Drupal's `@http_client` (Guzzle). Configuration lives on one form at `/admin/config/system/discord-notifications`, gated by the core `administer site configuration` permission, exposed under the System configuration menu. There are no entities, plugins, permissions, or Drush commands. Failures are caught and written to the `discord_notifications` logger channel rather than surfaced to the user.

---

- Post a Discord message whenever a new node is created (`node_create`).
- Post a Discord message whenever any node is updated (`node_update`).
- Post a Discord message whenever a node is deleted (`node_delete`).
- Announce new user registrations to a Discord channel (`user_register`).
- Announce user logins to a Discord channel (`user_login`).
- Notify a channel when a user account is blocked (`user_blocked`).
- Send a Discord alert on each failed login attempt (`failed_login`).
- Send a Discord alert when a password reset is requested (`password_reset`).
- Post a message after every cron run completes (`cron_run`).
- Reserve a slot for "updates available" system notifications (`update_available` option exists in the form).
- Route all notifications to a specific Discord channel by pasting that channel's webhook URL.
- Prefix urgent notifications with an `@here` mention so online members are pinged.
- Prefix notifications with an `@everyone` mention to ping the whole server.
- Colour-code events in Discord: green for create/register, yellow for update, blue for login/system, red for delete/block/security.
- Include who performed a content or user action via the embed footer ("Action performed by").
- Selectively enable only the event groups you care about (e.g. security alerts only) via checkboxes.
- Use Discord as a lightweight, real-time audit feed for a small editorial team.
- Get pinged in Discord about suspicious authentication activity (failed logins, password resets).
- Monitor cron health from Discord without logging into the site.
- Give stakeholders visibility into content publishing activity in a shared channel.
- Centralise multi-site event streams by pointing several sites at the same or different webhooks.
- Turn a moderation Discord server into a notification hub for editor actions.
- Disable all notifications quickly by unchecking every option while keeping the webhook configured.
- Drive an existing Discord bot/automation channel by feeding it Drupal events through the webhook.
