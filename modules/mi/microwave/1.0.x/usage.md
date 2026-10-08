<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Microwave regenerates ("warms") your page cache after a release so the first real visitor does not pay the cold-cache cost. You choose which content types, taxonomy vocabularies and custom URLs to warm, queue their URLs, then let queue workers request each page.

Configure targets at `/admin/config/system/microwave` (`MicrowaveSettingsForm`, permission `configure microwave`, restricted): select content types (with an optional date field + period to warm only recent nodes), vocabularies, and a newline-separated list of custom URLs. Drush commands populate per-target queues: `microwave:process_custom_urls` (`mpcu`), `microwave:process_nodes_urls` (`mpnu`), `microwave:process_terms_urls` (`mptu`), and — via the `microwave_commerce` submodule — `microwave:process_commerce_product_urls` (`mpcpu`). Queue workers (`microwave_custom_cron`, `microwave_node_cron`, `microwave_term_cron`, `microwave_commerce_product_cron`) run on cron or on demand, each item warmed by the `microwave.warmer_requests` service with a plain GET.

Security/operational notes: the warmer validates every queued URL before requesting it — the scheme must be http/https and the host must equal the current site host, otherwise the request is refused and logged (`WarmerRequests::warmUrlByGet`), which blocks SSRF to arbitrary hosts. Node URLs are built from path aliases; term URLs from the canonical route. Queue-clearing uses fixed `DELETE FROM queue WHERE name='...'` statements. Commands are designed to be called from CI after a delivery.
---
Warm page caches after a deployment by queueing and requesting node, term, custom and commerce product URLs.
---
- Select content types to warm at `/admin/config/system/microwave`.
- Restrict node warming to recent items via a date field and period.
- Choose taxonomy vocabularies whose term pages should be warmed.
- Enter custom URLs (one per line) to warm arbitrary pages.
- Grant `configure microwave` to the role that manages warming.
- Queue custom URLs with `drush microwave:process_custom_urls` (`mpcu`).
- Queue node URLs with `drush microwave:process_nodes_urls` (`mpnu`).
- Queue term URLs with `drush microwave:process_terms_urls` (`mptu`).
- Enable `microwave_commerce` to warm commerce product pages.
- Queue product URLs with `drush microwave:process_commerce_product_urls` (`mpcpu`).
- Run the warming queues on cron to process queued URLs.
- Trigger a queue immediately with `drush queue:run microwave_node_cron`.
- Call the Drush commands from a CI pipeline after each release.
- Clear a stale queue automatically before re-queueing (built in).
- Warm only published nodes/terms (queries filter `status = 1`).
- Batch large sets 100 items at a time to avoid memory spikes.
- Rely on host validation to prevent warming external URLs (SSRF guard).
- Review warmer failures in the `microwave` logger channel.
