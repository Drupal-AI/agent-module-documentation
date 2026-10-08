<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings — `api_orchestrator.settings`

Route `api_orchestrator.settings` → `/admin/config/services/api-orchestrator/settings` (`ApiOrchestratorSettingsForm`, `ConfigFormBase`), permission `administer api orchestrator`. Dashboard is `api_orchestrator.dashboard` (`DashboardController`).

## Config object keys
Schema in `config/schema/api_orchestrator.schema.yml` (`api_orchestrator.settings`); defaults in `config/install/api_orchestrator.settings.yml`:

- `request_timeout` (int, default 30) — per-request timeout in seconds when a service uses global settings.
- `max_retries` (int, 3), `retry_interval` (int, 300) — retry policy for services with `use_global_settings = TRUE`.
- `queue_processing_interval` (int, 2) — min seconds between queue items (rate limiting; 0 disables).
- `queue_batch_size` (int, 10).
- `cleanup_enabled` (bool, false) + `retention_days` (int, 30) — `hook_cron` deletes completed/failed requests older than the window (100 per run) via `ApiOrchestratorHooks::cron()`.
- `response_storage_path` (string, default `private://api_orchestrator/responses`) — where oversized responses are written (`ResponseStorageService`).
- `public_api_enabled` (bool), `public_api_token` (string), `public_api_rate_limit` (int, per-minute per-IP) — see `../api/public-health-api.md`.
- `log_level` (string, `info`), `log_request_body` (bool), `log_response_body` (bool), `default_timeout` (int).

Notes:
- The settings **form** exposes request/retry/queue/cleanup/storage and the Public API fields. The form validates that a public API token ≥16 chars is set when the API is enabled and suggests `bin2hex(random_bytes(32))`.
- `HttpExecutorService::buildRequestOptions()` reads two keys not present in the shipped schema/form: `ssl_verify` (Guzzle `verify`, defaults **TRUE** when unset) and `max_response_size` (default 1048576 bytes; larger responses are offloaded to files). Set them via config override if needed.

## Uninstall / requirements
- `hook_uninstall` deletes `api_orchestrator.settings`, all `api_orchestrator.api_service.*` / `api_endpoint.*` / `api_alert.*` config, and state keys `queue_last_processed` / `last_alert_check`.
- `hook_requirements` (runtime) reports queue depth (warn >1000) and failed-request count (warn >100).
