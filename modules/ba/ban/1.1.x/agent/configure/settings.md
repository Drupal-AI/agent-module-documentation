# Configure Ban (admin UI, storage, allowlist)

Ban has **no configuration object** — banned IPs live in a database table, and the allowlist lives
only in `settings.php`.

## Admin UI

**Configuration → People → IP address bans** — `/admin/config/people/ban` (route `ban.admin_page`,
form `BanAdmin`, permission `ban IP addresses`). The page shows:

- **IP allowlist** (read-only details) — the addresses defined in `settings.php` (see below).
- **Banned IP addresses** — a tableselect list with an "Unban selected IPs" button.
- **Ban IP address** — a textfield + "Add to ban". Validation rejects: an already-banned IP, your
  own client IP, an invalid IP, or an IP that is on the allowlist. Enter a single valid IPv4 or
  IPv6 address — **subnet ranges are not accepted** here.

Routes: `ban.admin_page` (list/add; optional `{default_ip}` prefills the field),
`ban.delete/{ban_id}` (unban one), `ban.delete.multiple` (unban selected).

## Storage: the `ban_ip` table

`ban_ip` has `iid` (serial PK) and `ip` (varchar 40). There is no config export of bans; they are
content-like data. Query it via the service (preferred) or SQL:

```bash
drush sqlq "SELECT iid, ip FROM ban_ip"
```

## Allowlist (settings.php only)

```php
$settings['ban_allowlist'] = [
  '192.168.1.100',       // single IPv4
  '10.0.0.0/24',         // IPv4 subnet range
  '2001:db8::100',       // single IPv6
  '2001:db8:abcd::/48',  // IPv6 subnet range
];
```

Addresses matching `ban_allowlist` (checked with Symfony `IpUtils::checkIp`) can never be banned —
the admin form and the `ban:ban` CLI command both refuse them. This is the only place the allowlist
can be set; there is no UI or config for it. (The former core `ban.settings` allowlist config was
removed by update `ban_update_11002`.)

## Enforcement

`ban.middleware` (`BanMiddleware`, tagged `http_middleware` priority 250) runs before page caching
and returns a `403` for any request whose client IP is in `ban_ip`.
