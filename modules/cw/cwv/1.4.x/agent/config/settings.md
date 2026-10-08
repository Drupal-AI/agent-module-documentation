<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CWV settings (config object `cwv.settings`)

Install/enable: `drush en cwv -y`. **Capture is OFF after install** (`enabled: false`) — nothing is
tracked until an operator turns it on. Config object: `cwv.settings` (defaults
`config/install/cwv.settings.yml`, schema `config/schema/cwv.schema.yml`). Admin form
`Drupal\cwv\Form\CwvSettingsForm` at `/admin/config/development/performance/cwv`
(route `cwv.settings`, permission `administer cwv`).

Most keys use `#config_target`. The two sequence fields (`upstream_id_headers`, `probe_targets`) are
textareas saved manually in `CwvSettingsForm::submitForm()` via `splitLines()`.

## Keys (all in `cwv.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | `false` | Master switch; attaches beacon JS and accepts writes. |
| `sampling_rate` | float | `0.1` | Fraction of pageviews beaconed (0.0–1.0). Applied client- AND server-side. |
| `url_storage` | string | `path` | `none` (md5 hash only), `path` (path, no query), `full` (path+query). |
| `retention_days` | int | `30` | Cron prunes `cwv_beacons`/`cwv_probes` older than this. 0 = keep forever. |
| `gtm_datalayer_enabled` | bool | `false` | Push page/dynamic cache state to `window.dataLayer`. |
| `flood_threshold` | int | `60` | Accepted beacons per IP per window; 0 disables in-module rate limit. |
| `flood_window_seconds` | int | `60` | Flood window. |
| `max_rows` | int | `0` | Hard FIFO ceiling on `cwv_beacons` rows; 0 = unlimited. |
| `outlier_filter_enabled` | bool | `true` | Drop beacons above per-metric threshold at ingest. |
| `outlier_thresholds` | mapping | LCP 30000, INP 5000, CLS 5, FCP 30000, TTFB 60000 | Per-metric drop thresholds. |
| `sampling_overrides` | mapping | `{}` | Per-metric sampling rate overriding the global rate. |
| `adaptive_sampling_enabled` | bool | `false` | Bump effective rate to 1.0 when metric throughput < floor. |
| `adaptive_throughput_floor` | int | `10` | Beacons/min/metric below which adaptive bumping fires. |
| `adaptive_window_seconds` | int | `60` | Throughput measurement window. |
| `events_enabled` | bool | `true` | Show the deploy-events admin surface + menu link. |
| `backend_cache_instrumentation_enabled` | bool | `false` | Per-request backend cache hit/miss/timing collector. |
| `render_tree_instrumentation_enabled` | bool | `false` | Per-response cache-tag/context count collector. |
| `database_instrumentation_enabled` | bool | `false` | Per-request query count/time/slow-query collector. |
| `database_slow_query_threshold_ms` | int | `100` | Query duration counted as "slow". |
| `upstream_id_headers` | sequence | `[]` | Header names (priority order) read for upstream request-ID correlation. |
| `probe_enabled` | bool | `false` | Master switch for cron-driven probes. |
| `probe_targets` | sequence | `[]` | http(s) URLs the edge-cache probe HEAD-requests on cron. |
| `probe_timeout_seconds` | int | `10` | Per-probe wall-clock budget. |
| `opcache_probe_enabled` | bool | `false` | Cron snapshot of `opcache_get_status()`. |
| `apcu_probe_enabled` | bool | `false` | Cron snapshot of `apcu_cache_info()`/`apcu_sma_info()`. |

## Notes grounded in source

- **`sampling_overrides` / `outlier_thresholds`** share the LCP/INP/CLS/FCP/TTFB key set; the form
  renders each under a `#tree => TRUE` fieldset to avoid the pre-1.4.1 cross-corruption bug.
- **Validation** (`CwvSettingsForm::validateForm`): both sequence fields cap at
  `MAX_SEQUENCE_ENTRIES = 32`; `upstream_id_headers` must match an RFC-7230 header-name token;
  `probe_targets` must be `http`/`https` only (mirrors the runtime scheme check in the probe).
- **`hook_requirements`** (runtime): warns on `/admin/reports/status` when `flood_threshold > 0` but
  no `reverse_proxy_addresses` is set (flood buckets collapse behind a CDN), and an info note when
  `max_rows = 0`.
- **`hook_update_N`** (10001–10036) backfill every key above for upgraders with safe defaults; each
  is idempotent. `enabled` and all instrumentation/probe toggles default off so an upgrade never
  starts new capture, outbound HTTP, or per-request overhead without opt-in.
- **Probe caveats** surfaced in the form: OPcache/APCu probes need **HTTP-context cron**
  (drush/CLI cron reads the CLI worker's runtime, not FPM/LSWS); edge-cache targets behind a CDN
  measure the CDN's response to a server request unless origin-direct URLs are used.
