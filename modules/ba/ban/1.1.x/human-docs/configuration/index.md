# Configuration

Ban has **no settings object**. "Configuration" here means managing the list of
banned addresses on the admin page, and defining the allowlist in `settings.php`.

## Open the IP-bans page

1. Log in as a user with the **Ban IP addresses** permission.
2. Go to **Configuration → People → IP address bans**, or navigate directly to
   `/admin/config/people/ban`.

The page has three parts:

- **IP allowlist** — a read‑only display of the addresses protected in
  `settings.php` (see below). These can never be banned.
- **Banned IP addresses** — the current ban list, with a checkbox per row and an
  **Unban selected IPs** button so you can remove one or several at once.
- **Ban IP address** — a text field plus an **Add to ban** button.

## Banning an address

Type a single **IPv4 or IPv6** address into the field and click **Add to ban**.
The form validates your input and refuses to add an address that is:

- already banned,
- your own current client IP (so you can't lock yourself out from the UI),
- not a valid IP address, or
- on the `settings.php` allowlist.

**Subnet ranges are not accepted here** — the ban list holds single addresses
only, by design, so the per‑request check stays fast. (Ranges are supported in the
allowlist below.)

## Unbanning

Tick one or more rows in the **Banned IP addresses** list and click **Unban
selected IPs**. To clear the entire list from the command line, use
`drush ban:flush`.

## The allowlist (settings.php only)

The allowlist is the one thing you set outside the UI. Add it to `settings.php`:

```php
$settings['ban_allowlist'] = [
  '192.168.1.100',       // single IPv4
  '10.0.0.0/24',         // IPv4 subnet range
  '2001:db8::100',       // single IPv6
  '2001:db8:abcd::/48',  // IPv6 subnet range
];
```

Any address that matches `ban_allowlist` can never be banned — both the admin form
and the `ban:ban` command refuse to ban it. This is the right place to protect your
office or a trusted subnet. There is no UI or configuration for the allowlist; it
lives only in `settings.php`.

## How enforcement works

Bans are stored in the `ban_ip` database table (not exported configuration, since
they are content‑like data). A high‑priority HTTP middleware checks the client IP
on every request, before the page cache, and returns a **403** for any banned
address. You can inspect the raw table with:

```bash
drush sqlq "SELECT iid, ip FROM ban_ip"
```
