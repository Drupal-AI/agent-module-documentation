# Configuration

Setting up the harvester is: point it at your OAI-PMH provider, choose how much it
harvests per run, then let cron do the work (or trigger a run yourself). All screens
live under `admin/config/services/oai_pmh_harvester/` and require the **Administer
OAI-PMH Harvester** permission.

## Open the settings form

1. Log in as a user with the **Administer OAI-PMH Harvester** permission (an
   administrator by default).
2. Go to **Configuration → Web services → OAI-PMH Harvester → Settings**, or
   navigate to `admin/config/services/oai_pmh_harvester/settings_form`.

## Settings

- **OAI-PMH provider URL** — the endpoint to harvest from. For a Koha catalog this
  is typically something like `https://example.com/cgi-bin/koha/oai.pl`. This URL is
  admin‑set and drives a server‑side fetch, so restrict who can change it and be
  deliberate about where it points (avoid internal hosts).
- **Metadata prefix** — the OAI-PMH metadata format to request (MARC XML is what the
  harvester decodes).
- **Harvest interval** — the date window advanced per run (a `DateInterval`, default
  `P1M`, one month). Because OAI-PMH serves records in the order they were added,
  this roughly determines how many records each cron run attempts. Choose a smaller
  window to harvest more gradually, a larger one to catch up faster.
- **Cron harvesting** — enable this so harvesting runs automatically on cron. Make
  sure cron runs regularly.

Save the configuration when done.

## Run a harvest

- **On cron** — with cron harvesting enabled and cron running regularly, each run
  advances the harvest window and pulls the next batch of records.
- **On demand** — trigger a run from the **Status** / **Actions** forms
  (`admin/config/services/oai_pmh_harvester/status_form`). Batch operations also let
  you harvest a specific date range or specific record IDs.

## What you get

A database table called **`oai_pmh_harvester_bib_records`** is created and filled
with the harvested bibliographic records (decoded to CSL JSON, keyed by record id;
records the provider marks as deleted are removed, and oversized MARC 505 fields are
stripped to fit the column). The table's column comments offer further guidance.
Use the **Inspect** form to review harvested records, and the **Status** page to see
the last run and record counts.

This module deliberately does **not** provide field types, widgets or formatters for
the cached data — building those (or otherwise consuming the table) is left to you
or a separate module that depends on this one.

## Egress

Because harvesting makes outbound requests to the provider, ensure the Drupal server
can reach it. In hosting that filters outbound traffic, allow egress to your OAI-PMH
provider's host.
