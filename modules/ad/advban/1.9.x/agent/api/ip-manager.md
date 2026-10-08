<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `advban.ip_manager` service, middleware and cron

Service id **`advban.ip_manager`** → `Drupal\advban\AdvbanIpManager` implements
`AdvbanIpManagerInterface`. Tagged `backend_overridable`, so it can be swapped per backend.
Constructor args: `@database`, `@config.factory`, `@datetime.time`.

## Methods you will actually call

```php
$m = \Drupal::service('advban.ip_manager');

// Ban. $ip_end '' = single ban; both given = IPv4 range (stored as ip2long integers).
// $expiry_date is a UNIX timestamp; NULL falls back to advban.settings.default_expiry_duration.
$m->banIp('203.0.113.45', '', 'scraping /node/*', strtotime('+1 day'));
$m->banIp('203.0.113.0', '203.0.113.255', 'bad subnet', NULL);

$m->unbanIp('203.0.113.45');                 // single
$m->unbanIp('203.0.113.0', '203.0.113.255'); // range (both args must match the row)
$m->unbanIpAll(['range' => 'range', 'expire' => 'expired']); // bulk; returns deleted count
                 // range: all|simple|range     expire: all|expired|not_expired

$m->isBanned('203.0.113.45');                       // bool
$m->isBanned($ip, ['expiry_check' => TRUE, 'info_output' => TRUE, 'no_limit' => FALSE]);
      // info_output ⇒ ['iid' => …, 'expiry_date' => …, 'is_banned' => bool]
$m->isProtected('203.0.113.9');                     // bool, consults advban_protected_ips
$m->isBannedByReason('case-4711');                  // LIKE %reason% ⇒ ['iid','expiry_date','is_banned']
$m->findAll(50);                                    // StatementInterface; >0 adds a pager
$m->findById($iid);                                 // array of row objects
$m->formatIp($ip, $ip_end);                         // '203.0.113.0 ... 203.0.113.255'
$m->expiryDurations();                              // array of duration strings from config
$m->expiryDurations($index);                        // one item; out of range ⇒ 'never'
$m->expiryDurationIndex($durations, $default);      // index or 'never'
$m->unblockExpiredIp();                             // deletes expired rows, returns count
$m->banText(['ip' => $ip, 'expiry_date' => $ts]);   // rendered 403 body
$m->getEntryStatus($row);                           // 'Protected' | 'Expired' | 'Active'
$m->setMetadata(['reporter' => 'my_module', 'id' => 42]);  // used as the reason when $reason is empty
$m->getMetadata();
```

`AdvbanHelper::ADVBAN_NEVER` is the string constant `'never'`.

## Storage details that matter

- `banIp()` does a `merge()` keyed on `ip`, so re-banning the same `ip` updates the row.
- For a **range**, both addresses are converted with `sprintf('%u', ip2long($ip))` before
  storage — the `ip`/`ip_end` columns then hold **numeric strings**, not dotted quads.
  Matching is `WHERE ip_end <> '' AND ip <= $ip_long AND ip_end >= $ip_long`, i.e. IPv4 only.
- `expiry_date = 0` means "never expires".
- `unblockExpiredIp()` deletes rows with `0 < expiry_date < now`.

## Middleware

`advban.middleware` (`Drupal\advban\AdvbanMiddleware`) is tagged
`http_middleware, priority: 250` — deliberately **before page caching** so a banned client
can never receive a cached page. Per request it does:

1. `isProtected($clientIp)` → if TRUE, pass through (protected always wins);
2. `isBanned($clientIp, ['expiry_check' => TRUE, 'info_output' => TRUE])`;
3. if banned, return a plain `Response($banText, 403)`.

## Cron & install

- `advban_cron()` calls `unblockExpiredIp()` and logs
  `Unbanned expired IP count: %count` to the `advanced ban` channel when > 0.
- `advban_install()` copies every distinct `ip` from core's `ban_ip` table (if present) into
  `advban_ip` with the reason "Migrated from Ban", inside a transaction.
- `advban_schema()` defines the `advban_ip` table; `advban_update_8102()` added `reason`.
- `hook_theme()` registers `ip_ban_view` (`templates/ip-ban-view.html.twig`) with variables
  `ip`, `ip_end`, `expiry_duration`, `status`.
