<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Profiler — settings, collection & storage

## Enable & configure
```bash
drush en droost_profiler -y   # depends only on droost; no external library
```
Collection is **OFF by default**. Turn it on at **`/admin/config/development/droost-profiler`**
(`SettingsForm`, route `droost_profiler.settings`, permission **`administer droost profiler`** — `restrict access:
true`; the module's `configure` route).

## Config object `droost_profiler.settings`
Install default (`config/install/droost_profiler.settings.yml`): `enabled: false`, `max_profiles: 50`. Schema
(`config/schema/droost_profiler.schema.yml`): `enabled` (boolean), `max_profiles` (integer). `SettingsForm::submitForm()`
clamps `max_profiles` server-side to 1..10000 (so a programmatic `droost_config_set` cannot persist an out-of-range value).

## Collection (`StackMiddleware\Profiler`, priority 210)
Registered as `http_middleware` at priority 210 — just outside page_cache (200), inside CORS/content-negotiation — so
it wraps the page cache and can measure total time, profile cache HITs, and read `X-Drupal-Cache`. `handle()` returns
early unless it is the main request, `enabled` is true, and `profilable()` is true (`profilable()` skips `/_mcp[/…]`
and static assets by extension). Otherwise it calls `Database::startLog('droost_profiler')`, times the request, and
`record()`s a profile. On a thrown request it drains the query log (so it doesn't bleed into the next profile) and
rethrows; a `record()`/storage failure is logged (`droost_profiler` channel) and the response returned untouched —
profiling never causes a 500.

## What is stored (and what is NOT)
`record()` writes: `token` (random 10 bytes hex), `created`, `method`, `url`, `route`, `status`, `duration_ms`,
`peak_memory`, `query_count`, `query_time_ms`, and a JSON `data` payload (`queries` + `cache`).
- **`url` is the path only** — the query string is dropped (it can carry API keys) and `redactPath()` replaces the
  secret segments of `/user/reset/…` and `/user/{uid}/cancel/confirm/…` links with placeholders.
- **Query detail is bounded**: `formatQueries()` caps stored queries at 1000 and truncates each SQL string at 2000
  chars; `query_count` still reflects the true total. Query **bindings/arguments are not stored** — only the SQL text,
  time, and caller.
- **Cacheability** (`cache()`): page-cache/dynamic-cache HIT/MISS + content-type from response headers, and
  tags/contexts/max-age from the response's cacheability metadata when available.

## Storage (`ProfileStorage`, table `droost_profile`)
`save()` inserts then `prune()`s to keep the newest `max_profiles`. `list()` returns summary columns only (no `data`
blob) with optional URL LIKE (escaped) / method / min-duration filters; `load()` decodes the JSON payload;
`latest()` loads the most recent. `hook_uninstall` is implicit via core (schema table dropped on uninstall).

## Known limits (accepted; opt-in dev tool)
BigPipe under-reports queries/memory used inside a StreamedResponse callback; persistent runtimes
(FrankenPHP/RoadRunner) keep statement logging on for the worker's life while profiling is enabled.
