# Configure the account policy

Settings form `Drupal\simple_account_policy\Form\AccountPolicyConfigForm` (form id
`account_policy_settings`), route `simple_account_policy.simple_account_policy_settings` at
`/admin/config/people/account_policy`, permission `administer account policy`. All values are
stored in the single config object **`simple_account_policy.settings`** (schema
`config/schema/simple_account_policy.schema.yml`).

## Config keys

| Key | Type | Default (config/install) | Meaning |
|---|---|---|---|
| `username_prevent_changes` | boolean | `0` | If true, disable the username field on existing accounts the policy applies to. |
| `username_match_email` | boolean | `1` | Username must equal the email address. |
| `username_match_patterns` | sequence(string) | `[]` | Regex patterns the **email** must match (used as `/pattern/`; violations flagged on the name field). |
| `username_ignore_patterns` | sequence(string) | `[]` | Regex patterns; accounts whose **name** matches are exempted from the whole policy. |
| `email_match_patterns` | sequence(string) | `[]` | Regex patterns the email must match. |
| `inactive_interval` | string (seconds) | `86400` | Cron throttle: minimum seconds between inactivity sweeps. `0` disables auto-blocking via cron. |
| `inactive_period` | string | `'3 months'` | Time since last access after which an account is "inactive" (blocked). Digits = seconds; else `strtotime`-relative. |
| `inactive_warning` | string | `'3 weeks'` | Warning lead time before the block. Empty = no warning mail. |
| `inactive_warning_mail.subject` | string | (token subject) | Warning email subject (token-replaced in `hook_mail`). |
| `inactive_warning_mail.body` | string | (token body) | Warning email body; may use `[account_policy:block_period]`. |
| `inactive_warning_mail.from` | string | `''` | Override From address; falls back to `system.site` mail. Not exposed on the form. |
| `delete_after_time` | string | `'1 year'` | Time since last access after which an inactive account is deleted. Empty = never delete. |
| `user_cancel_method` | string | `'user_cancel_reassign'` | Core `user_cancel_methods()` id used when deleting. |

Notes on parsing:
- `inactive_period`, `inactive_warning`, `delete_after_time` accept either a raw seconds integer
  (`ctype_digit`) or a `strtotime` phrase (e.g. `3 months`, `2 weeks`). See `getBlockTime()`,
  `getWarningTime()`, `getDeleteAfterTime()` in `src/AccountPolicy.php`.
- The form submit handler splits the textareas on the literal string `'\n'` (`explode('\n', …)`),
  not a real newline — a quirk to be aware of when setting patterns through the UI.

## Set via drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('simple_account_policy.settings');
$config
  ->set('username_match_email', TRUE)
  ->set('username_prevent_changes', TRUE)
  ->set('email_match_patterns', ['^.+@example\\.com$'])
  ->set('inactive_interval', 86400)   // sweep at most once/day
  ->set('inactive_period', '6 months')
  ->set('inactive_warning', '2 weeks')
  ->set('delete_after_time', '2 years')
  ->set('user_cancel_method', 'user_cancel_block')
  ->save();
```

```bash
ddev drush cset simple_account_policy.settings inactive_period '6 months' -y
ddev drush cset simple_account_policy.settings inactive_interval 0 -y   # disable auto-blocking
```

## What happens at runtime

- **Format policy** is enforced on the user form (`hook_form_user_form_alter` →
  `simple_account_policy_form_user_validate` → `AccountPolicy::validate()`), and the applicable
  rules are shown as field descriptions (`AccountPolicy::policy()`).
- **Inactivity/deletion** run in `hook_cron` (see [../hooks/hooks.md](../hooks/hooks.md)): it loads
  all users, skips those exempted by `applyPolicy()`, deletes those past `delete_after_time`, emails
  a warning once when within the warning window, then blocks once past `inactive_period`.
- The policy is skipped for a user when: they hold `bypass account policy`, their name matches an
  `username_ignore_patterns` entry, or they are anonymous (`AccountPolicy::applyPolicy()`).
