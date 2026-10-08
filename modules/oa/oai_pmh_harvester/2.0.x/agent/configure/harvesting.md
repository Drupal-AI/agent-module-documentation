<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring OAI-PMH harvesting

## Settings (`oai_pmh_harvester.settings`, via auto_config_form)
At `admin/config/services/oai_pmh_harvester/settings_form`:
- `oai_url` — the OAI-PMH base URL (default sample `https://example.com/cgi-bin/koha/oai.pl`). Admin-set; drives a server-side fetch, so restrict to trusted operators and avoid internal hosts.
- `oai_prefix` — metadata prefix filtering (optional).
- `harvest_interval` — ISO-8601 `DateInterval` string, default `P1M` (one month per run window).
- `cron_enabled` — when true, harvesting runs on cron.

## Admin surfaces
- `.../status` — `StatusPageController::status`, shows harvester status.
- `.../actions_form` — trigger harvest runs.
- `.../inspect_form` — inspect harvested records.
All require `administer oai_pmh_harvester`.

## Run mechanics
`Harvester::run()` computes `[from, until]` via `getHarvestRange()` (first run uses provider `earliestDatestamp`; window clamped to now), calls `endpoint->listRecords('marcxml', from, until)`, and merges each record. The harvest cursor (`last`) only advances if the whole run completes without an unhandled exception (`noRecordsMatch` is safely ignored). `format` is fixed to `marcxml`.

## Batches
- `HarvestRecordsInDateRangeBatch` — harvest a chosen date range.
- `HarvestSpecificRecordsBatch` — harvest specific record IDs.
- `DecodeBatch` — (re)decode stored records.
