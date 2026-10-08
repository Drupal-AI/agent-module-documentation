# Auto Unban — agent index

Decorates core Ban's `ban.ip_manager` so IP bans expire automatically after a time window
(default 1h) with exponential back-off per repeat ban. Adds `expires` + `attempts` columns to
core's `ban_ip` table. Depends on core `ban`. One config value; no module-specific permissions
(settings form uses core `administer site configuration`). Provides Drush commands.

- **The single `seconds` setting, the service override, expiry/back-off logic, install/uninstall
  behaviour** → [configure/settings.md](configure/settings.md)
- **The `BanIpManager` subclass API (`isBanned`/`banIp`/`unbanIp`), the ban-form alter, indefinite
  ban** → [api/ban-manager.md](api/ban-manager.md)
- **Drush `ban` / `unban` / `banned` commands** → [drush/commands.md](drush/commands.md)

Key facts:
- Settings route `auto_unban.settings` → `/admin/config/system/auto-unban`.
- Config `auto_unban.settings:seconds` (int, default 3600). Ban length = `seconds * 2^attempts`.
- Ban expiry is checked live in `isBanned()` (`expires > now`); no cron.
- "Add indefinitely" / `drush ban --permanent` = ban until 2147483647 (~year 2038).
- Behaviour change: with this enabled, ordinary bans become time-limited by default.
