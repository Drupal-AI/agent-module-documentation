# Configure Purge Users (global settings)

Form `\Drupal\purge_users\Form\SettingsForm` at `/admin/config/people/purge-users`
(route `purge_users.settings`, permission `access purge setting page` — `restrict access: true`).
Config object: `purge_users.settings` (defaults in `config/install/purge_users.settings.yml`, all
**disabled** by default).

## Age-based rules (four independent; each: value + period + enable)

| Rule | Value key | Period key | Enable key |
|---|---|---|---|
| Never logged in, account older than | `user_never_lastlogin_value` (30) | `user_never_lastlogin_period` (days) | `enabled_never_loggedin_users` (false) |
| Last login older than | `user_lastlogin_value` (30) | `user_lastlogin_period` (days) | `enabled_loggedin_users` (false) |
| Never activated (inactive) for | `user_inactive_value` (30) | `user_inactive_period` (days) | `enabled_inactive_users` (false) |
| Blocked for | `user_blocked_value` (30) | `user_blocked_period` (days) | `enabled_blocked_users` (false) |

`*_period` ∈ minutes/hours/days/weeks/months/years (converted to a timestamp cutoff).

## Scope / exclusions

| Key | Default | Meaning |
|---|---|---|
| `enabled_do_not_purge_authors` | false | Skip users who authored content. |
| `enabled_do_not_purge_commenters` | false | Skip users who posted comments. |
| `purge_included_users_roles` | {} | Only purge users in these roles (checkboxes). |
| `purge_excluded_users_roles` | {} | Never purge users in these roles. |
| `disregard_blocked_users` | false | Skip already inactive/blocked users from certain rules. |

## Cancel method + cron

| Key | Default | Meaning |
|---|---|---|
| `purge_user_cancel_method` | `user_cancel_block` | Core account-cancel method: `user_cancel_block`, `user_cancel_block_unpublish`, `user_cancel_reassign`, `user_cancel_delete`, or `user_cancel_site_policy` ("follow site's policy"). |
| `purge_on_cron` | **false** | When 1, `hook_cron()` enqueues matching uids into the `purge_users` queue. **This is the automatic trigger — off by default.** |

## Notifications

| Key | Default | Meaning |
|---|---|---|
| `send_email_notification` | false | Email users when their account is deleted. |
| `inactive_user_notify_subject` / `_text` | (defaults) | Deletion email subject/body. |
| `send_email_user_before_notification` | false | Enable pre-deletion warning emails (enqueues `notification_users`). |
| `user_before_deletion_subject` / `_text` | (defaults) | Pre-deletion email subject/body. |
| `user_before_notification_value` / `_period` | '' / days | Lead time before deletion to notify. |

## Triggering a purge

- **Cron:** enable `purge_on_cron`; `hook_cron()` (in `src/Hook/PurgeUsersHooks.php`) queues uids.
- **UI:** `/admin/config/people/purge-users/confirm` (`ConfirmationForm`, permission
  `access purge confirmation form`, `restrict access: true`).
- **Drush:** see [../drush/commands.md](../drush/commands.md).

Deletion is performed with core `user_cancel`, so it honours the chosen cancel method and fires the
normal account-cancellation hooks/emails.
