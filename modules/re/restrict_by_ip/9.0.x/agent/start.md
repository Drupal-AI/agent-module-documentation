# Restrict By IP — agent index

Limits **login** and **role availability** to allowed IP ranges (CIDR). Three layers: global login list,
per-user list (user base field), per-role list. Fails closed. No dependencies beyond core. One permission
(`administer restrict by ip`, `restrict access: true`). Config UI at `/admin/config/people/restrict_by_ip`
(`configure: restrict_by_ip.general_settings`).

- **Settings pages, config keys, per-user field, IP detection / reverse proxies, the permission** →
  [configure/settings.md](configure/settings.md)
- **`restrict_by_ip:status` / `restrict_by_ip:allow` Drush commands (incl. lockout recovery)** →
  [drush/commands.md](drush/commands.md)
- **`hook_restrict_by_ip_ranges_alter()` and its type-specific variants** → [hooks/alter.md](hooks/alter.md)

Key facts:
- Enforcement: `src/LoginFirewall.php` (login) + `src/EventSubscriber/FirewallSubscriber.php`;
  `src/RoleFirewall.php` (roles) + `src/EventSubscriber/RoleRestrictionSubscriber.php`; login-form
  validator in `src/Hook/RestrictByIpHooks.php::validateIpRestriction`.
- Client IP = `Request::getClientIp()` (`src/IPTools.php`) → uses the real socket IP; honours Drupal
  trusted-proxy config, does NOT trust raw `X-Forwarded-For` by default.
- Config `restrict_by_ip.settings`: `login_range` (seq), `role` (map role→seq), `error_page`,
  `login_denied_message`, `role_ip_behavior`, `role_removed_message`. Per-user ranges live in the user
  entity field `restrict_by_ip_ranges`.
- Malformed CIDR never matches (fails toward restriction). `authenticated`/`anonymous` never role-restricted.
