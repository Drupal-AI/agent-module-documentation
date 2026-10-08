<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAI-PMH Harvester (oai_pmh_harvester) — agent index

**Harvests MARC/bibliographic records from an OAI-PMH provider (e.g. Koha) on cron and caches them in `oai_pmh_harvester_bib_records`.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Dependencies:** auto_config_form (config UI); Composer brings `caseyamcl/phpoaipmh`, `scriptotek/marc`.
- **Routes (all `_permission: 'administer oai_pmh_harvester'`, admin):** `.../status`, `.../settings_form`, `.../actions_form`, `.../inspect_form`.
- **Permission:** `administer oai_pmh_harvester` (`restrict access: TRUE`).
- **Services:** `oai_pmh_harvester.harvester` (HarvesterService), `oai_pmh_harvester.decoder` (DecoderService).
- **Event:** `HarvestPreMergeEvent` (alter decoded record before DB merge).
- **Settings:** `oai_url`, `oai_prefix`, `harvest_interval` (default `P1M`), `cron_enabled`.

**Security:** All routes admin-permission-gated. The server-side OAI-PMH fetch URL (`oai_url`) is **admin-config-supplied, not request-driven** — outbound-URL/SSRF surface is limited to an admin pointing it at an internal host; TLS verification is **not** disabled. Record ids cast to int; DB merge/delete use parameterized builders (no raw SQL). No anonymous or mutating public endpoints.

See [configure/harvesting.md](configure/harvesting.md) and [api/events.md](api/events.md)
