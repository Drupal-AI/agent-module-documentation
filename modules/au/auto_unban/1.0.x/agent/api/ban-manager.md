# Auto Unban API — the BanIpManager override

## Service override
`Drupal\auto_unban\AutoUnbanServiceProvider::alter()` swaps the class of the core
`ban.ip_manager` service to `Drupal\auto_unban\BanIpManager` and appends `@datetime.time` and
`@config.factory` as constructor args. So `\Drupal::service('ban.ip_manager')` (and anything that
injects `ban.ip_manager`, including core's Ban middleware and admin form) transparently uses the
time-aware manager. It extends `Drupal\ban\BanIpManager`.

## Methods (all keyed on the core `ban_ip` table, now with `expires` + `attempts`)
- `isBanned($ip): bool` — `SELECT … WHERE ip = :ip AND expires > :now`. An IP is banned only
  while its window is open; lapsed bans read as not-banned with no cleanup step.
- `banIp($ip, $attempts = NULL, $expires = NULL)` — upserts (`merge`) the ban row. Logic:
  - reads current `{attempts, expires}` for the IP;
  - `$attempts` defaults to the stored value (or 0);
  - `$growth = (no prior row OR prior ban already expired) ? $attempts++ : $attempts`
    (a fresh/lapsed ban increments the counter; re-banning inside an active window does not);
  - `$seconds = config('auto_unban.settings').seconds ?: 3600`;
  - `$expires = $expires ?? now + $seconds * pow(2, $growth)` — exponential back-off.
  - Pass an explicit `$expires` to set an exact expiry (used by "Add indefinitely" →
    `banIp($ip, NULL, 2147483647)`), or an explicit high `$attempts` (Drush `--permanent` passes
    16, making the computed window astronomically large).
- `unbanIp($ip)` — sets `expires = 0` (used only by the UI unban action; time-based expiry
  handles the rest).

## Ban admin form alter (auto_unban.module)
`hook_form_ban_ip_form_alter` rebuilds core's ban table: columns become IP / Ban count / Expires /
Operations, sortable via `TableSort`, paginated 50/page, and `Expires` is rendered as `expired`
or a `long`-formatted date. It also injects an **Add indefinitely** submit
(`auto_unban_add_indifenitely_submit`) that calls `banIp($ip, NULL, 2147483647)` and redirects to
`ban.admin_page`.

## Programmatic examples
```php
$m = \Drupal::service('ban.ip_manager');
$m->banIp('203.0.113.5');                 // time-limited ban (base window * 2^attempts)
$m->banIp('203.0.113.5', NULL, 2147483647); // effectively permanent
$m->isBanned('203.0.113.5');              // bool, honouring expiry
$m->unbanIp('203.0.113.5');               // clear now
```
