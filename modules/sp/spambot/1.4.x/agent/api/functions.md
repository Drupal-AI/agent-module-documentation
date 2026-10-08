# Spambot API (procedural functions in `spambot.module`)

All are plain functions (no service class); call directly. The only service is `cache.spambot`
(a cache bin), used internally.

## Core lookup

```php
// Query Stop Forum Spam for one email/username/ip. Returns TRUE on a successful HTTP call;
// $data is filled with per-field results: $data['email']['appears'], ['frequency'], ['value'].
$data = [];
$ok = spambot_sfs_request(['email' => 'a@b.com', 'ip' => '203.0.113.5'], $data);

// Multi-value variant (arrays of values per field); used by spambot_sfs_request().
spambot_sfs_request_multiple(['email' => ['a@b.com','c@d.com']], $data);
```

- Builds the `https://www.stopforumspam.com/api?...` request, decodes the response, and (when `spambot_enable_cache`) caches each result in the `spambot` bin keyed
  `"{field}:{value}"` with hit/miss expiries `spambot_cache_expire` / `spambot_cache_expire_false`.
- `use_https` config switches the scheme. The API is queried by IPv4/IPv6, email, username only.

## Decision helpers

```php
$config = \Drupal::config('spambot.settings');

// Returns >0 spammer, 0 clean, <0 error contacting service. Uses the configured thresholds and
// gathers the account's IPs (sessions + comment hostnames) itself.
$result = spambot_account_is_spammer($account, $config);

// TRUE if $value is whitelisted for $type in ('ip','email','username').
spambot_check_whitelist('email', $config, 'a@b.com');

// All IPs seen for an account (sessions.hostname + comment hostnames).
$ips = spambot_account_ip_addresses($account);
```

## Reporting a spammer (needs API key)

```php
$key = \Drupal::config('spambot.settings')->get('spambot_sfs_api_key');
// POSTs email/username/ip_addr/evidence to https://www.stopforumspam.com/add.php.
// Returns TRUE on success (or on a "duplicate entry" response). No-op / FALSE when $key is empty.
spambot_report_account($account, $ip, $evidence_text, $key);
```

## Form protection helper

```php
// Attach the SFS validator to any form. $options maps which value keys hold mail/name and
// whether to check the client IP. Skips entirely if the current user has
// 'protected from spambot scans'.
spambot_add_form_protection($form, ['mail' => 'mail', 'name' => 'name', 'ip' => TRUE]);
```

The registration form uses this via `spambot_form_user_register_form_alter()`. The validate callback
is `spambot_user_register_form_validate()`.

## Where state lives

- `spambot.settings` — all configuration (see configure/settings.md).
- `State: spambot_last_checked_uid` — cron scan cursor.
- DB table `node_spambot` (nid, uid, hostname) — author IPs, populated by `spambot_node_insert()`.
- `spambot` cache bin — SFS response cache.

## The per-user Spam tab

`SpambotUserspamForm` (route `spambot.user_spam`, requires `administer users`) offers: **Check**
(live SFS lookup for the account's email/username/IPs), **report** selected nodes/comments to SFS
(disabled unless an API key is set), and **actions** to unpublish/delete the user's content (batched)
and block/delete the account (uid 1 is protected).
