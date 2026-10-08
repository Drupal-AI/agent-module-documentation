<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Advanced ban manager (`AdvbanAbuseipdbBanManager`)

## Install & enable

```bash
drush en abuseipdb_advban -y
# then set Ban Manager = "Advanced ban" at /admin/config/services/abuseipdb
```

Requires `abuseipdb` and the contrib `advban` (Advanced ban) module.

## The class

`src/AdvbanAbuseipdbBanManager.php`, service `abuseipdb_advban.ban_manager`
(tag `abuseipdb_ban_manager`), implements the parent's `AbuseipdbBanManagerInterface`. Constructor
injects `@advban.ip_manager` (`Drupal\advban\AdvbanIpManager`).

| Method | Behaviour |
|---|---|
| `banIp($ip)` | `advban->banIp($ip, '', NULL)` — empty reason, no expiry (uses advban defaults). |
| `isBanned($ip)` | `advban->isBanned($ip, [])`; returns the bool as-is, or `count() > 0` if advban returns an array, else FALSE. |
| `getId()` | `'abuseipdb_advban.ban_manager'` (matches the service id — required by the collector). |
| `getModuleName()` | `'Advanced ban'` (the label in the Ban Manager dropdown). |

## Wiring

The parent's `AbuseipdbBanManagerCollector` collects this tagged service; `ReporterFactory::doCreate()`
returns it when `abuseipdb.settings:abuseipdb.ban_manager === 'abuseipdb_advban.ban_manager'`. From
then on `Reporter::ban()` / `Reporter::isBanned()` call the methods above. See the parent client doc
[../../../../3.x/agent/api/client.md](../../../../3.x/agent/api/client.md).

## Uninstall

`abuseipdb_advban_uninstall()` resets the parent `ban_manager` to `abuseipdb.empty_ban_manager` (and
messages the admin) when this backend was active — so removing the submodule never leaves a dangling
manager reference.
