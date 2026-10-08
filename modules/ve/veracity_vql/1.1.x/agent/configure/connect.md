<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Connecting to Veracity

## Settings
`/admin/config/services/veracity` (`VeracityConfigForm`, config `veracity_vql.settings`):
- **Veracity URL** — the xAPI/LRS endpoint.
- **Access Key** (`access_key_id`) — username of an access key with *Advanced Queries* enabled.
- **Access Key Secret** (`access_key_secret`) — password. On save the form calls
  `VeracityApi::testConnection()` which runs a `$limit:1` `/analyze` query.

## How queries run
`VeracityApi::executeVql($query)`:
1. dispatches `VqlPreExecuteEvent` — pre-process plugins mutate the query
   (timezone, date range, context activity filters);
2. `VeracityClient::analyze()` JSON-encodes and POSTs to `<endpoint>/analyze`
   with `RequestOptions::AUTH => [id, secret]` (HTTP basic);
3. dispatches `VqlPostExecuteEvent` — post-process plugins reshape the result.

## Rendering
`getVqlRenderer()` returns `https://<endpoint-host>/integrations/public/vqlUtils/renderer.js`.
Blocks `VeracityChartBlock` / `VeracityEmbeddableChartBlock` render charts; viewing needs
`access veracity charts`.

## Operational notes
- TLS verification uses Guzzle defaults (on). No `verify => false`.
- Credentials live in plain config; treat exported config as sensitive.
