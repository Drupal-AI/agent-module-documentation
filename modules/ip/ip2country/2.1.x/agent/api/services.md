# ip2country services & data

## `ip2country.lookup` (Ip2CountryLookupInterface)

```php
$code = \Drupal::service('ip2country.lookup')->getCountry($ip_address);
// $ip_address: dotted-quad string OR 32-bit long OR NULL (=> current request client IP)
// returns: ISO 3166-1 alpha-2 code (string) or FALSE if not found
```

Implementation: `ip2long($ip)` then a single range query
`SELECT country FROM {ip2country} WHERE :ip >= ip_range_first AND :ip <= ip_range_last` (limit 1).
Autowired; also available by the interface id `Drupal\ip2country\Ip2CountryLookupInterface`.

## `ip2country.manager` (Ip2CountryManagerInterface)

```php
$m = \Drupal::service('ip2country.manager');
$rows = $m->updateDatabase(string $registry = 'all', bool $md5_checksum = FALSE, int $batch_size = 200);
//   truncates {ip2country} and reloads from the RIR(s) in a transaction; returns row count or FALSE
$m->emptyDatabase();        // empties {ip2country}
$count = $m->getRowCount(); // number of IP ranges currently loaded
```

`updateDatabase()` runs inside a transaction (no data loss on failure), updates the
`ip2country_last_update` / `ip2country_last_update_rir` State keys, and dispatches a
**`DbUpdatedEvent`** on the event dispatcher — subscribe to it to react to a completed refresh.

## Where a user's country is stored

On `hook_user_login` the module calls `getCountry()` and stores the result in the core
**`user.data`** service:

```php
\Drupal::service('user.data')->get('ip2country', $uid, 'country_iso_code_2'); // => 'US', etc.
```

`hook_user_load` copies it onto `$account->country_iso_code_2`. So to read a user's detected
country, read that `user.data` key rather than re-running a lookup.

## The `{ip2country}` table

Custom schema (see `ip2country.install`): columns include `ip_range_first`, `ip_range_last`
(unsigned longs) and `country` (2-char code). It is populated only by `updateDatabase()` /
cron / the Drush update command — a freshly enabled site has an **empty** table until then, so
`getCountry()` returns FALSE for every IP until a load runs.

## Cron

`hook_cron` (in `src/Hook/Ip2CountryCronHooks.php`) calls `updateDatabase($rir, $md5_checksum,
$batch_size)` when `update_interval` is non-zero and `now - last_update >= update_interval`.
Setting `update_interval` to `0` disables automatic updates.
