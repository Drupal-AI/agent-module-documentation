<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AbuseIPDB Advanced ban (abuseipdb_advban) — agent index

Submodule of **abuseipdb**. Adds an AbuseIPDB **ban backend** that delegates to the **Advanced ban**
(`advban`) module. Package `Other`. Core `^10 || ^11`. License GPL-2.0-or-later.

- **Integration detail (the ban manager)** → [api/ban-manager.md](api/ban-manager.md)

## What it provides

- **Dependencies** (`abuseipdb_advban.info.yml`): `abuseipdb:abuseipdb`, `advban:advban`.
- **One service** (`abuseipdb_advban.services.yml`): `abuseipdb_advban.ban_manager` →
  `Drupal\abuseipdb_advban\AdvbanAbuseipdbBanManager`, tag `abuseipdb_ban_manager`, argument
  `@advban.ip_manager`.
- **No** routes, permissions, config, schema, or Drush.
- `hook_uninstall` (`abuseipdb_advban.install`): if `abuseipdb.settings:abuseipdb.ban_manager` is
  `abuseipdb_advban.ban_manager`, reset it to `abuseipdb.empty_ban_manager` (`- None -`).

## How to use

Enable it, then on `/admin/config/services/abuseipdb` set **Ban Manager** to *Advanced ban*. All
AbuseIPDB bans then route through Advanced ban's `advban.ip_manager`.

See the parent index: [../../../../3.x/agent/start.md](../../../../3.x/agent/start.md).
