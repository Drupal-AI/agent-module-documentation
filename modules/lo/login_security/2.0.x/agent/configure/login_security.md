# Configure Login Security

![Login Security settings form](../../../../../../../screenshots/login_security/2.0.x/login_security.png)

Single settings form; no config entities. Route `login_security.settings` at
`/admin/config/people/login_security`, gated by core permission `administer site configuration`.
All values live in the `login_security.settings` config object
(`config/schema/login_security.schema.yml`), so they export/deploy with `drush config:export`
and can be set with `drush cset login_security.settings <key> <value>`.

## Threshold settings (`login_security.settings`)

Defaults shown; a count of `0` **disables** that particular protection.

| Key | Default | Meaning |
|---|---|---|
| `track_time` | `60` | Sliding window in **minutes** that failed attempts are kept and counted; older rows expire (cleaned on cron). |
| `user_wrong_count` | `0` | Failed attempts allowed **per user account** before the account is blocked (status set to 0), regardless of host. |
| `host_wrong_count` | `0` | Failed attempts allowed **per host IP (soft)** before that IP can no longer submit the login form (can still browse anonymously). |
| `host_wrong_count_hard` | `0` | Failed attempts allowed **per host IP (hard)** before the IP is banned outright via the Ban/AdvBan module. |
| `activity_threshold` | `0` | Total site-wide failed attempts before an "ongoing attack" is logged and admins are optionally emailed. |

## Behavior / notification settings

| Key | Default | Meaning |
|---|---|---|
| `disable_core_login_error` | `0` | Hide core's login error messages (e.g. "Unrecognized username or password") to prevent username enumeration. |
| `notice_attempts_available` | `0` | Show the user how many login attempts remain before lockout. |
| `last_login_timestamp` | `0` | On successful login, show a message with the user's previous login time. |
| `last_access_timestamp` | `0` | On successful login, show a message with the user's previous site-access time. |
| `user_blocked_notification_emails` | `''` | Comma-separated emails notified when an account is blocked. Blank = no email. |
| `login_activity_notification_emails` | `''` | Comma-separated emails notified when the attack threshold is reached. Blank = no email. |

## Message / email templates

Editable text with tokens: `notice_attempts_message`, `host_soft_banned`, `host_hard_banned`,
`user_blocked`, `user_blocked_email_subject`, `user_blocked_email_body`,
`login_activity_email_subject`, `login_activity_email_body`. Available tokens include
`@username`, `@ip`, `@site`, `@uid`, `@email`, `@edit_uri`, `@user_current_count`,
`@user_block_attempts`, `@ip_current_count`, `@hard_block_attempts`, `@soft_block_attempts`,
`@tracking_current_count`, `@activity_threshold`, `@tracking_time`, `@date`.

## Important operational notes

- **IP banning requires Ban or AdvBan.** `hook_requirements` raises an error/warning if neither
  `ban` nor `advban` is enabled; hard bans go through the `login_security.ban` service (`banIp()`).
- **Blocks are not auto-lifted.** A blocked user must be re-enabled at `/admin/people`; a banned IP
  must be removed from `/admin/config/people/ban`.
- **Relationship to core flood control.** Login Security does *not* disable core's login flood
  control — during validation it reads core's `flood_control_triggered` flag and layers its own
  per-account / per-IP thresholds on top. `disable_core_login_error` only hides messages; it does
  not turn off core flood protection.
- **Clear tracking data:** the settings form has a "Clear event tracking information" button
  (empties the `login_security_track` table).
- Failed attempts are recorded for every submission; successful login or user re-activation removes
  that user's tracked events.
