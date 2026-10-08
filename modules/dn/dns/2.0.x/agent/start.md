<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DNS (dns) — agent index

Manage **DNS zones and records as content entities** with a pluggable record-type architecture. Package `DNS`. Version `2.0.0-alpha3` (docs dir `2.0.x`). Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Configure route `dns.settings`.

Data-only: this release **stores and validates** DNS data — no live provider sync and no outbound DNS/HTTP lookups (planned roadmap).

## Dependencies

- Core `options`, core `views`, and contrib **`field_ipaddress`** (`^2.0`, provides the `ipaddress` field type). Composer also requires PHP ext `intl` (used for IDN Punycode).
- Optional submodule **`dns_extras`** — specialty record types. Documented separately at `modules/dns_extras/2.0.x/`.

## What it provides

- **Three content entities** (`src/Entity/`): `dns_zone`, `dns_record`, `dns_zone_grant`. See [api/entities.md](api/entities.md).
- **A plugin type** `dns_record_type` (manager `RecordTypeManager`, service `plugin.manager.dns_record_type`, attribute `#[RecordType]`). 11 core record plugins in `src/Plugin/RecordType/`. See [plugins/record-types.md](plugins/record-types.md).
- **An access policy** `DnsZoneGrantPolicy` (service `dns.access_policy.zone_grant`, `dns_zone` scope) + three access-control handlers. Access model in [api/entities.md](api/entities.md).
- **Settings form** `SettingsForm` writing config `dns.settings`, a `dns_records` view, a `dns_record_rdata_value` Views field, and D7 Migrate plugins. See [config/settings.md](config/settings.md).
- **Permissions** (`dns.permissions.yml`): `administer dns`, `create dns zones`, `view any dns zone`, `view own dns zones`, `edit own dns zones`, `delete own dns zones`.

## Solution docs

- [config/settings.md](config/settings.md) — install/enable, settings + config schema, routes, permissions, menu/action/task links, Views integration, D7 migration.
- [api/entities.md](api/entities.md) — the three entities, their fields, the two-layer access model, and the grant/collaborator system.
- [plugins/record-types.md](plugins/record-types.md) — the `RecordType` plugin system, the shipped types, the `rdata` JSON storage model, and how to add a type.

## Key routes / URLs

- `dns.settings` → `/admin/config/content/dns` (perm `administer dns`).
- `dns.admin_content` → `/admin/content/dns` (perm `administer dns`).
- `dns.record_add` → `/dns/records/add` (zone-less add, perm `administer dns`).
- Zone entity routes: `/dns/{dns_zone}` (canonical), `/dns/zones/add`, `/dns/{dns_zone}/edit|delete`, collection `/admin/content/dns/zones`.
- Record entity routes (no canonical): `/dns/{dns_zone}/records/add|{dns_record}/edit|{dns_record}/delete`.
- Grant entity routes: `/dns/{dns_zone}/collaborators[/add|/{dns_zone_grant}/edit|/delete]`.
- Records view: page `/admin/content/dns/records` (`view.dns_records.page_records`), embed display `embed_zone`.
