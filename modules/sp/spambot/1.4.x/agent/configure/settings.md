# Configure Spambot

Single config object: **`spambot.settings`**. Admin form at `/admin/config/system/spambot`
(route `spambot.settings_form`, form `Drupal\spambot\Form\SpambotSettingsForm`, requires the core
`administer site configuration` permission). Read/write with `drush cget/cset spambot.settings <key>`.

## Settings keys (with shipped defaults from `config/install/spambot.settings.yml`)

| Key | Default | Meaning |
|---|---|---|
| `spambot_user_register_protect` | `true` | Add the SFS check to the user registration form. |
| `spambot_criteria_email` | `1` | Block if the email appears on SFS ≥ this many times. `0` = don't check email. |
| `spambot_criteria_username` | `0` | Same for username. `0` = off (default, avoids false positives). |
| `spambot_criteria_ip` | `20` | Same for client IP. `0` = don't check IP. |
| `spambot_blacklisted_delay` | `20` | Index into a sleep-seconds list; delays a blocked attempt. `0` = no delay. |
| `spambot_whitelist_email_list` | `[]` | Array of exempt emails (form textarea, one per line). |
| `spambot_whitelist_username_list` | `[]` | Array of exempt usernames. |
| `spambot_whitelist_ip_list` | `[]` | Array of exempt IPs. |
| `spambot_cron_user_limit` | `0` | Existing-account scan: accounts checked per cron. `0` = no cron scanning. |
| `spambot_check_blocked_accounts` | `false` | Whether cron also scans already-blocked accounts. |
| `spambot_spam_account_action` | `0` | Cron action on a match: `0` none/log, `1` block, `2` delete (see `SpambotSettingsForm::SPAMBOT_ACTION_*`). |
| `spambot_log_blocked_registration` | `true` | Log blocked registrations (and invoke the `spambot_registration_blocked` hook). |
| `spambot_blocked_message_email` | `'Your email address or username or IP address is blacklisted.'` | Message when blocked by email. Tokens: `@email %email @username %username @ip %ip`. |
| `spambot_blocked_message_username` | same string | Message when blocked by username. |
| `spambot_blocked_message_ip` | same string | Message when blocked by IP. |
| `spambot_sfs_api_key` | `''` | Stop Forum Spam API key, required only to *report* spammers. Stored in `spambot.settings`. |
| `spambot_enable_cache` | `1` | Cache SFS responses in the `spambot` cache bin. |
| `spambot_cache_expire` | `-1` | Lifetime (seconds) for spammer hits. `-1` = `CACHE_PERMANENT`. |
| `spambot_cache_expire_false` | `-1` | Lifetime for non-spammer (miss) results. `-1` = permanent. |
| `use_https` | `true` | Use `https://` for SFS API calls (disable only if the server lacks SNI). |

Legacy raw whitelist strings `spambot_whitelist_email` / `_username` / `_ip` also exist in schema; the
form reads/writes the `_list` array variants. (Note: `spambot_check_whitelist()` still matches against
the non-list string variants via `strpos`.)

The scan cursor is **State**, not config: `\Drupal::state()->get('spambot_last_checked_uid')` (the form
exposes it as "Continue scanning after this user id"; set to 0 to rescan all).

## Examples (drush)

```bash
# Turn on username checking with a threshold of 3.
drush cset spambot.settings spambot_criteria_username 3 -y

# Whitelist an IP so it is never checked.
drush cset spambot.settings spambot_whitelist_ip_list.0 203.0.113.5 -y

# Scan up to 50 existing accounts per cron and block matches.
drush cset spambot.settings spambot_cron_user_limit 50 -y
drush cset spambot.settings spambot_spam_account_action 1 -y   # 1 = block

# Read the current IP threshold.
drush cget spambot.settings spambot_criteria_ip
```

Setting all three criteria to `0` disables every SFS lookup (the module makes no remote request when
there is nothing to check).
