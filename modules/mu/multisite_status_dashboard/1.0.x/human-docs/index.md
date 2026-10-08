# Multisite Status Dashboard — manual setup guide

**Multisite Status Dashboard** (`multisite_status_dashboard`) aggregates the
health of many Drupal sites onto **one screen**. It polls remote sites that run
the companion **Multisite Status Report** module and shows, in a single table,
each site's status badge (green / amber / red), Drupal core version and update
status, number of security and available updates, PHP version, last cron run, and
when the data was last checked. If you run or maintain a fleet of sites, it gives
you an always‑current picture of which ones are out of date or insecure without
logging in to each one.

Each remote site you want to watch is stored as a **monitored site**
configuration entity — a label, an HTTPS base URL, a key identifier, and a shared
secret. When it fetches a site's status, the module signs the request locally
with that site's shared secret using **HMAC‑SHA256**; the secret itself is never
sent over the wire, matching the verification the Multisite Status Report module
performs on the other end. Fetching happens in the background on cron through a
queue (and results are cached in the key/value store, keeping the dashboard
fast), or on demand via a **Refresh now** button that uses the Batch API.
Unreachable sites are highlighted with their last error preserved.

The module is deliberately lightweight — it is built only on core (Guzzle, the
key/value store, the queue and Batch APIs) and talks to no external services. Two
permissions separate the two audiences: one to **view** the dashboard and one
(restricted) to **manage** the list of monitored sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add monitored sites, handle the
   shared secrets safely, and understand who can see what.

## Where it lives in the admin menu

- The **dashboard** itself is at **Reports → Multisite status**
  (`/admin/reports/multisite-status`), for users with **view multisite status
  dashboard**.
- The **monitored sites** list is at **Configuration → Web services → Multisite
  Status Dashboard → Monitored sites**
  (`/admin/config/services/multisite-status-dashboard/sites`), for users with the
  restricted **administer multisite status dashboard** permission.
