<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto-block settings

Form `SettingsForm` at route `block_inactive_users.settings`
(`/admin/config/people/block_inactive_users`, permission `administer site configuration`).
Config object: **`block_inactive_users.settings`**.

## Keys

| Key | Type | Meaning |
|---|---|---|
| `block_inactive_users_idle_time` | text (months) | block users idle at least this many **months** |
| `block_inactive_users_send_email` | bool | email the user (with reactivation link) when blocked |
| `block_inactive_users_from_email` | text | From address of the block email |
| `block_inactive_users_email_subject` | text | block email subject |
| `block_inactive_users_email_content` | text | block email body (tokens allowed) |
| `block_inactive_users_exclude_roles` | sequence | role ids never auto-blocked (default: administrator) |
| `block_inactive_users_include_never_accessed` | bool | also block users who never logged in (measured from account creation) |
| `block_inactive_users_warn_send_email` | int (0/1) | send an advance-warning email |
| `block_inactive_users_days_until_blocked` | int | how many days before the block to warn |
| `block_inactive_users_warn_from_email` | text | From address of the warn email |
| `block_inactive_users_warn_email_subject` | text | warn email subject |
| `block_inactive_users_warn_email_content` | text | warn email body |

Tokens supported in email bodies/subjects: standard `[site:*]`, `[user:*]`, plus the module's
pseudo-tokens `[activation-link]` and `[days-until-blocked]`.

## Read / set

```bash
drush cget block_inactive_users.settings block_inactive_users_idle_time
```

```php
\Drupal::configFactory()->getEditable('block_inactive_users.settings')
  ->set('block_inactive_users_idle_time', '6')
  ->set('block_inactive_users_send_email', TRUE)
  ->save();
```

The settings form's "Disable inactive users" button runs the block sweep immediately; otherwise
it runs on the next cron. Saving does not itself block anyone — cron (or the button) does.
