# Ban — agent index

Blocks visits from individual IP addresses (contrib continuation of core Ban; project
`drupal/ban`, machine name `ban`). Banned IPs are stored in the `ban_ip` DB table and enforced by
an HTTP middleware that returns 403. Admin UI at `/admin/config/people/ban`
(route `ban.admin_page`, permission `ban IP addresses`). No config object of its own.

- **Admin UI, the `ban_ip` table, and the settings.php allowlist** →
  [configure/settings.md](configure/settings.md)
- **`ban.ip_manager` service API (`banIp`/`unbanIp`/`isBanned`/…)** → [api/manager.md](api/manager.md)
- **CLI commands `ban:ban` / `ban:unban` / `ban:list` / `ban:flush`** → [drush/commands.md](drush/commands.md)
- **Permission `ban IP addresses`** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Only single IPv4/IPv6 addresses are bannable; **subnet ranges are not supported** in the ban
  list (they are only for the allowlist).
- The **allowlist** is defined ONLY in `settings.php` as `$settings['ban_allowlist']` (IPs or CIDR
  ranges); allowlisted addresses can never be banned. There is no `ban.settings` config anymore.
- Enforcement: `ban.middleware` (http_middleware, priority 250) → 403 before page cache.
