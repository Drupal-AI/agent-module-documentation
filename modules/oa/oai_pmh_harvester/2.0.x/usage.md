<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OAI-PMH Harvester pulls bibliographic MARC records from an OAI-PMH provider such as a Koha library catalog and caches them locally so they can be referenced from Drupal fields.

---

The module wraps the `phpoaipmh` client (`Phpoaipmh\Endpoint`) in a `Harvester` that walks the provider's records in date-range windows. On each run it computes the next window (starting from the provider's `earliestDatestamp` on the first run, then advancing by a configurable `DateInterval`, default `P1M`), calls `listRecords` in `marcxml`, and for each record `HarvesterService::harvestOne()` strips the bulky MARC 505 field, decodes the record to CSL JSON via `DecoderService` (dispatching a `HarvestPreMergeEvent`), and MERGEs it into the `oai_pmh_harvester_bib_records` table keyed by record id — deleting records the provider marks as `status="deleted"`. A `HarvestPreMergeEvent` lets other modules alter decoded data before it is stored. Harvesting runs on cron when `cron_enabled` is set, and batch classes support harvesting a date range or specific records on demand.

All admin routes live under `admin/config/services/oai_pmh_harvester/*` (status, settings, actions, inspect) and require the `administer oai_pmh_harvester` permission (`restrict access: TRUE`). Security-relevant note for operators: the harvest URL (`oai_url`) is admin-configured, not request-supplied, and drives a server-side HTTP fetch — treat it like any admin-set outbound URL (an admin could point it at an internal host). The code does not disable TLS verification. Record ids are cast to int and all DB writes use the parameterized MERGE/delete builders. Typical setup: enable the module, set the OAI-PMH endpoint URL, metadata prefix and interval on the settings form, then let cron harvest or trigger a run from the actions form.
---
- Harvest MARC records from a Koha or other OAI-PMH provider
- Cache bibliographic records locally for fast field reference
- Schedule incremental harvesting on cron by date window
- Configure the OAI-PMH endpoint URL and metadata prefix
- Set the harvest interval (e.g. monthly P1M) per run
- Harvest a specific date range on demand via batch
- Harvest specific record IDs via batch
- Automatically delete records the provider marks as deleted
- Decode MARC XML into CSL JSON for reuse
- Strip oversized MARC 505 fields to fit the storage column
- Alter decoded records before storage via HarvestPreMergeEvent
- Inspect harvested records through the admin inspect form
- View harvester status (last run, counts) on the status page
- Reference cached bibliographic data from custom fields
- Restrict harvesting configuration to trusted admins
- Audit the configured OAI-PMH URL for internal-host/SSRF concerns
- Advance the harvest cursor only on fully successful runs
- Log per-run counts of updated and deleted records
- Integrate a library catalog feed into a Drupal site
