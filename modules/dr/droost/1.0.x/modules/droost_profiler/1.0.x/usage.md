<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Profiler is a self-contained per-request profiler that records database queries, timing, memory and response cacheability, then exposes them to AI agents as read-only MCP tools.

---

Droost Profiler records a profile for each profilable HTTP request and serves those profiles to AI agents over MCP, without any dependency on Webprofiler or the Devel suite. A stack middleware (`StackMiddleware\Profiler`, registered at priority 210 — just outside page_cache so it can measure total time, profile cache HITs, and read the X-Drupal-Cache header) wraps the kernel: when profiling is enabled it calls `Database::startLog()`, times the request, then via `ProfileStorage::save()` persists a row to the `droost_profile` table with the HTTP method, path, matched route, status, wall-clock duration, peak memory, query count, total query time, and a JSON payload of the (capped) query log plus a cacheability summary. Collection is OFF by default (`droost_profiler.settings.enabled`) and adds overhead, so it is a local-development tool; the settings form at `/admin/config/development/droost-profiler` (permission `administer droost profiler`, `restrict access: true`) toggles it and sets how many profiles to retain (`max_profiles`, clamped 1..10000, older profiles pruned as new ones land). Two read-only MCP tools read the data: `droost_profile_list` lists recent profiles (with `url`, `method`, `min_duration_ms` filters) and `droost_profile` returns one profile (by `token`, or the most recent) with its timing, memory, cache HIT/MISS and tags, the ten slowest queries, duplicate-query groups, and queries aggregated by table. Both are gated behind mcp_server's `access mcp server` permission. Stored URLs drop the query string and redact secret path segments (password-reset/account-cancel token/hash); the per-query detail is capped at 1000 queries and each SQL string truncated at 2000 chars to bound the row size; a storage failure never turns a good response into a 500. Depends only on `droost`. Local development only.

---

- Record database queries, timing, memory and cacheability per request without Webprofiler or Devel.
- Toggle profiling on/off from `/admin/config/development/droost-profiler` (`administer droost profiler`).
- Cap how many profiles are retained (`max_profiles`, 1..10000); older profiles auto-prune.
- List recently profiled requests newest-first with `droost_profile_list`.
- Filter the list by URL substring, HTTP method, or minimum duration.
- Inspect one request with `droost_profile` (by token, or the most recent).
- See the ten slowest queries on a page to target optimization.
- Find duplicate (N+1) queries via the duplicate-query groups.
- See queries aggregated by table to find which table a slow page hammers.
- Read response cacheability: page-cache / dynamic-cache HIT/MISS, tags, contexts, max-age.
- Let an AI agent debug a slow page from structured JSON instead of parsing Devel output.
- Measure total request time and cache HITs (middleware sits just outside page_cache).
- Keep secrets out of stored profiles (query strings dropped; reset/cancel path tokens redacted).
- Bound storage overhead (query detail capped at 1000, SQL truncated at 2000 chars).
- Avoid breaking requests: a profiling/storage failure is logged and the response returned untouched.
- Skip profiling the MCP endpoint and static assets automatically.
