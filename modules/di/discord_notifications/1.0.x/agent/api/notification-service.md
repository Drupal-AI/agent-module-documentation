<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification service & hook wiring

Service `discord_notifications.notification_service` → `Drupal\discord_notifications\Service\DiscordNotificationService`
(`discord_notifications.services.yml`, args `@http_client`, `@config.factory`, `@logger.factory`, `@current_user`).

## Hook → service map (`discord_notifications.module`)
| Hook | Call |
| --- | --- |
| `hook_entity_insert` (node) | `handleContentNotification($entity, 'create')` |
| `hook_entity_update` (node) | `handleContentNotification($entity, 'update')` |
| `hook_entity_delete` (node) | `handleContentNotification($entity, 'delete')` |
| `hook_user_login` | `handleUserNotification($account, 'login')` |
| `hook_user_insert` | `handleUserNotification($account, 'register')` |
| `hook_user_update` (block transition) | `handleUserNotification($account, 'blocked')` — only when `$account->isBlocked() && $account->original->isActive()` |
| `hook_cron` | `handleSystemNotification('cron_run', 'Cron run completed')` |
| `hook_user_login_failed` | `handleSecurityNotification('failed_login', "Failed login attempt for: {$name}")` |
| `user_pass` form submit (via `hook_form_user_pass_form_alter`) | `handleSecurityNotification('password_reset', "Password reset requested for: {$name}")` |

Only node entities pass the `hook_entity_*` type guard.

## Handler methods
Each `handle*` method: loads `discord_notifications.settings`, returns early if the event key is not in the relevant sequence, builds an embed array, then calls `sendNotification('', $embed)`.

- `handleContentNotification`: embed `title` = `"{$operation}d Content"`, `description` = `"{title} (ID: {id})"`, `color` by operation (create `0x00FF00`, update `0xFFFF00`, delete `0xFF0000`), `footer.text` = "Action performed by: " + current user display name, `timestamp` = `date('c')`.
- `handleUserNotification`: `title` = `"User {Operation}"`, `description` = display name + id, color register/login/block. Note: the `$colors` map keys are `register`/`login`/`block`, but the blocked path passes operation `blocked`, so `$colors['blocked']` is undefined (harmless PHP notice; color omitted).
- `handleSystemNotification` / `handleSecurityNotification`: generic embed with a `Details` field carrying the passed `$details` string; system color `0x0000FF`, security color `0xFF0000`.

## `sendNotification($message, array $embed = [])`
1. Reads `webhook_url`; if empty, logs an error to channel `discord_notifications` and returns.
2. Applies `@here` (if `use_here`) else `@everyone` (if `use_everyone`) as a message prefix.
3. Builds payload `['content' => $message]` and adds `['embeds' => [$embed]]` when an embed is present.
4. `POST`s to the webhook with `$this->httpClient->post($webhook_url, ['json' => $data])` — Drupal's default Guzzle client (TLS verification enabled by default).
5. Any exception is caught and logged to the `discord_notifications` channel; the calling hook is never interrupted.

## Behaviour notes
- Content/user embeds send an empty `content` string plus the embed; only mentions add visible message text.
- The webhook URL is admin-only configuration (`administer site configuration`); it is not exposed on any public route.
- No queueing/batching — one synchronous HTTP POST per enabled event during the request/cron that triggered it.
