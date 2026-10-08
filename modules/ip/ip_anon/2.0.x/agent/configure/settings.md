<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the retention policy

Config object: **`ip_anon.settings`**. Settings form route **`ip_anon.settings`** at
`/admin/config/people/ip_anon` (requires permission *administer site configuration*).

## Keys (shipped defaults)

| Key | Default | Meaning |
|---|---|---|
| `policy` | `0` | Master switch. `0` = **preserve** IPs (nothing scrubbed). `1` = **anonymize**. Cron only scrubs when this is truthy. |
| `period_sessions` | `-1` | Seconds to retain IPs in the `sessions` table. `-1` = forever. |
| `period_comment_field_data` | `-1` | comment_field_data retention (seconds). |
| `period_watchdog` | `-1` | dblog `watchdog` retention. |
| `period_commerce_order` | `-1` | commerce_order retention. |
| `period_login_history` | `-1` | login_history retention. |
| `period_simple_access_log` | `-1` | simple_access_log retention. |
| `period_tether_stats_activity_log` | `-1` | tether_stats retention. |
| `period_visitors` | `-1` | visitors retention. |
| `period_votingapi_vote` | `-1` | votingapi_vote retention. |
| `period_webform_submission` | `-1` | webform_submission retention. |

A `period_<table>` that is negative or non-numeric means **never scrub that table**. Any
value `>= 0` is treated as an age threshold in seconds: rows whose timestamp is
`<= requestTime - period` get their hostname column set to `'0'`.

The form only shows a select for each table that is actually available (via
`IpAnonymize::getTables()`); the select options are core `formatInterval` durations plus a
**Forever** option (`-1`). Only `sessions` and any tables added by modules implementing
`hook_ip_anon_alter()` appear.

## Via the UI

1. Go to `/admin/config/people/ip_anon` (*Configuration » People » IP address anonymization*).
2. Set **Retention policy** to **Anonymize IP addresses**.
3. For each listed table, pick a **Retention period** (or **Forever** to never scrub it).
4. Save. Scrubbing then runs on each cron.

## Via drush (scriptable)

```bash
# enable anonymization and keep session IPs for at most 1 hour
drush config:set ip_anon.settings policy 1 -y
drush config:set ip_anon.settings period_sessions 3600 -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('ip_anon.settings')
  ->set('policy', 1)
  ->set('period_sessions', 3600)
  ->save();
```

## Read it back

```bash
drush cget ip_anon.settings policy
drush cget ip_anon.settings period_sessions
```

Schema `ip_anon.settings` (config_object) types every key as `integer`.
