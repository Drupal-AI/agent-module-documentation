<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Core Ban manager (`CoreBanAbuseipdbBanManager`)

## Install & enable

```bash
drush en abuseipdb_core_ban -y
# then set Ban Manager = "Ban (Core)" at /admin/config/services/abuseipdb
```

Requires `abuseipdb` and core `ban`.

## The class

`src/CoreBanAbuseipdbBanManager.php`, service `abuseipdb_core_ban.ban_manager`
(tag `abuseipdb_ban_manager`), implements the parent's `AbuseipdbBanManagerInterface`. Constructor
injects `@ban.ip_manager` (`Drupal\ban\BanIpManager`).

| Method | Behaviour |
|---|---|
| `banIp($ip)` | `ban.ip_manager->banIp($ip)` — adds the IP to core's ban list. |
| `isBanned($ip)` | `ban.ip_manager->isBanned($ip)` — passthrough bool. |
| `getId()` | `'abuseipdb_core_ban.ban_manager'` (matches the service id — required by the collector). |
| `getModuleName()` | `'Ban (Core)'` (the label in the Ban Manager dropdown). |

## Wiring

The parent's `AbuseipdbBanManagerCollector` collects this tagged service; `ReporterFactory::doCreate()`
returns it when `abuseipdb.settings:abuseipdb.ban_manager === 'abuseipdb_core_ban.ban_manager'`. From
then on `Reporter::ban()` / `Reporter::isBanned()` call the methods above, and bans appear in core's
Ban UI at `/admin/config/people/ban`. See the parent client doc
[../../../../3.x/agent/api/client.md](../../../../3.x/agent/api/client.md).

## Uninstall

`abuseipdb_core_ban_uninstall()` resets the parent `ban_manager` to `abuseipdb.empty_ban_manager`
(and messages the admin) when this backend was active — so removing the submodule never leaves a
dangling manager reference.
