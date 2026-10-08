# Restrict IP — agent index

Locks the whole site to an allowlist of IP addresses; non-allowed visitors get an Access Denied
page. Blocking runs from an `kernel.request` event subscriber (`restrict_ip.service`). Config UI
at `/admin/config/people/restrict_ip` (route `restrict_ip.admin_page`, permission
"administer restricted ip addresses"). Depends on `block` and `user`. Optional `ip2country`
adds country allow/deny.

- **Settings, config keys, the allowed IP list, page white/blacklist, settings.php overrides** →
  [configure/settings.md](configure/settings.md)
- **Drush `restrict_ip:disable` / `ripd` (enable & disable the restriction)** →
  [drush/commands.md](drush/commands.md)
- **Permissions ("administer…" + the dynamic role-bypass permission)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Alter hooks (whitelist regions/JS, alter the Access Denied page)** →
  [hooks/alter.md](hooks/alter.md)
- **The `restrict_ip.service` API (read/write allowed IPs & paths, block tests)** →
  [api/service.md](api/service.md)

Key facts:
- Behavioural settings live in config `restrict_ip.settings` (`enable`, `mail_address`, `dblog`,
  `allow_role_bypass`, `bypass_action`, `white_black_list`, `country_white_black_list`,
  `country_list`).
- The **allowed IP list**, whitelisted pages, and blacklisted pages are stored in the module's
  **database tables** (via `RestrictIpMapper`), NOT in that config object — except the
  `settings.php`-only override `$config['restrict_ip.settings']['ip_whitelist']`.
- Country options only appear when `ip2country` is enabled.
