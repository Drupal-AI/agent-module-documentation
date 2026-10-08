# Ban — the `ban.ip_manager` service

Service id **`ban.ip_manager`** → `Drupal\ban\BanIpManager` (interface `BanIpManagerInterface`,
also autowirable by the interface). Tagged `backend_overridable`, so you can swap the storage
backend. It reads/writes the `ban_ip` table.

```php
$mgr = \Drupal::service('ban.ip_manager');
```

## Methods

| Method | Behaviour |
|---|---|
| `banIp($ip)` | Insert (MERGE) the IP into `ban_ip`. No allowlist/validation check — the UI/CLI do that first. |
| `unbanIp($id)` | Delete by IP string (`condition('ip', $id)`). |
| `unbanAllIps(): int` | Delete all rows; returns the count removed. |
| `isBanned($ip): bool` | TRUE if the IP has a row in `ban_ip`. |
| `findAll()` | `StatementInterface` over all rows (each has `->iid`, `->ip`). |
| `findById($ban_id)` | The IP string for a given `iid`, or FALSE. |

## Examples

```php
$mgr = \Drupal::service('ban.ip_manager');
$mgr->banIp('203.0.113.5');
$banned = $mgr->isBanned('203.0.113.5');          // true
foreach ($mgr->findAll() as $row) {                // list
  printf("%d => %s\n", $row->iid, $row->ip);
}
$mgr->unbanIp('203.0.113.5');
$removed = $mgr->unbanAllIps();                     // flush, returns int
```

## Notes

- `banIp()` does not enforce the `ban_allowlist` or validate the IP — validation happens in the
  admin form (`BanAdmin`) and the `ban:ban` CLI command. If you call the service directly, check
  the allowlist / validity yourself.
- Enforcement of bans is done by `ban.middleware` (`BanMiddleware`), which consumes this service.
