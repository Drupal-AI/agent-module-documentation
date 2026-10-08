<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AbuseIPDB Core Ban (abuseipdb_core_ban) — agent index

Submodule of **abuseipdb**. Adds an AbuseIPDB **ban backend** that delegates to Drupal **core Ban**
(`ban`). Package `Other`. Core `^10 || ^11`. License GPL-2.0-or-later.

- **Integration detail (the ban manager)** → [api/ban-manager.md](api/ban-manager.md)

## What it provides

- **Dependencies** (`abuseipdb_core_ban.info.yml`): `drupal:ban`, `abuseipdb:abuseipdb`.
- **One service** (`abuseipdb_core_ban.services.yml`): `abuseipdb_core_ban.ban_manager` →
  `Drupal\abuseipdb_core_ban\CoreBanAbuseipdbBanManager`, tag `abuseipdb_ban_manager`, argument
  `@ban.ip_manager`.
- **No** routes, permissions, config, schema, or Drush.
- `hook_uninstall` (`abuseipdb_core_ban.install`): if `abuseipdb.settings:abuseipdb.ban_manager` is
  `abuseipdb_core_ban.ban_manager`, reset it to `abuseipdb.empty_ban_manager` (`- None -`).

## How to use

Enable it, then on `/admin/config/services/abuseipdb` set **Ban Manager** to *Ban (Core)*. All
AbuseIPDB bans then route through core's `ban.ip_manager`; manage them at
`/admin/config/people/ban`.

See the parent index: [../../../../3.x/agent/start.md](../../../../3.x/agent/start.md).
