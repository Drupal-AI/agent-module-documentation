# OAI-PMH Harvester — manual setup guide

**OAI-PMH Harvester** (`oai_pmh_harvester`) pulls bibliographic **MARC** records
from an **OAI-PMH** provider — such as a **Koha** library catalog — and caches them
in a local database table (`oai_pmh_harvester_bib_records`) so your site can refer
to them from fields. It is the harvesting engine only: it fetches and stores the
records, and leaves it to you (or a separate module) to build field types, widgets
or formatters on top of the cached data.

The problem it solves is getting a library catalog's records into Drupal
efficiently and incrementally. On each cron run the harvester walks the provider's
records in date‑range windows — starting from the provider's earliest datestamp,
then advancing by a configurable interval (default one month per run) — fetches
records in MARC XML, decodes each into CSL JSON, and merges it into the local table
keyed by record id. Records the provider marks as deleted are removed. A
`HarvestPreMergeEvent` lets other modules alter decoded data before it is stored.

Harvesting runs on cron when you enable it, and batch operations let you harvest a
specific date range or specific record IDs on demand. Admin screens cover settings,
status (last run, counts), actions (trigger a run), and inspecting harvested
records. All admin routes require the **Administer OAI-PMH Harvester** permission.
It depends on the **Auto Config Form** module and wraps the `phpoaipmh` client.

> **Security note.** The harvest URL is admin‑configured (not supplied by site
> visitors) and drives a server‑side HTTP fetch. Treat it like any admin‑set
> outbound URL — restrict who can set it, since an admin could point it at an
> internal host.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the OAI-PMH endpoint, metadata
   prefix and harvest interval, and run a harvest.

## Where it lives in the admin menu

All screens live under **Configuration → Web services → OAI-PMH Harvester**
(`admin/config/services/oai_pmh_harvester/*`): the **Settings** form, a **Status**
page, an **Actions** form to trigger harvesting, and an **Inspect** form for
harvested records. See [Configuration](configuration/index.md).
