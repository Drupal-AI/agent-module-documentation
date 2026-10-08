<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multisite Status Dashboard — monitored sites

Each remote site is a `monitored_site` config entity (config_prefix `monitored_site`) with exported properties: `id`, `label`, `base_url`, `key_id`, `secret`, `enabled`. Manage them at `/admin/config/services/multisite-status-dashboard/sites` (permission `administer multisite status dashboard`, restricted).

The remote site must run the companion **Multisite Status Report** module and expose `/multisite-status-report/summary`, sharing the same `key_id`/`secret`. `StatusFetcher::fetch()`:

- builds `GET <base_url>/multisite-status-report/summary`
- computes `signature = hash_hmac('sha256', "GET\n<path>\n<timestamp>\n<nonce>\n"+sha256(''), secret)`
- sends headers `X-MSR-Key`, `X-MSR-Timestamp`, `X-MSR-Nonce`, `X-MSR-Signature` (secret itself never sent), `timeout: 15`, `connect_timeout: 8`
- stores the JSON result (or an error) via `StatusAggregator` (keyvalue).

Refresh: on demand `POST /admin/reports/multisite-status/refresh` (CSRF token required, `view multisite status dashboard`), or in the background via the `SiteStatusFetchWorker` queue worker on cron.
