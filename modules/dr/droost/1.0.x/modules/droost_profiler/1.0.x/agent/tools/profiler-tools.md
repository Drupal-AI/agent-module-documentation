<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Profiler — MCP tools

Both tools extend `DroostToolBase`, are read-only, enabled by default, gated behind mcp_server's
`access mcp server` permission, and return the `{success, message, data}` envelope. They read the `droost_profile`
table via `ProfileStorage`; they return "no profiles yet" until profiling is enabled and a page is loaded.

## `droost_profile_list` — `src/Plugin/Tool/ProfileList.php`
Lists recently profiled requests, newest first (summary only). Inputs:
- `limit` — max rows (default 20, clamped 1..200).
- `url` — case-insensitive URL substring filter.
- `method` — HTTP method filter, e.g. `GET`.
- `min_duration_ms` — only requests at least this many ms.

Returns `{count, profiles}` where each profile is the summary columns (token, url, route, status, duration_ms,
query_count, peak_memory, ...). Use the returned `token` with `droost_profile`.

## `droost_profile` — `src/Plugin/Tool/Profile.php`
Returns one profile with query analysis. Input: `token` (from `droost_profile_list`; omit for the most recent).
On a miss it fails with a hint to enable `droost_profiler.settings.enabled`. Data returned:
- summary: `token, method, url, route, status, duration_ms, peak_memory_mb, query_count, query_time_ms`.
- `cache`: `page_cache` / `dynamic_cache` HIT/MISS, `content_type`, `max_age`, tag/context counts + lists.
- `slowest_queries`: the 10 slowest (`slowest()`).
- `duplicate_queries`: identical queries that ran more than once, top 10 by count (`duplicates()`) — the N+1 finder.
- `queries_by_table`: per-table `{table, count, time_ms}`, busiest first, top 15 (`queriesByTable()` / `tableOf()`
  parse the table after FROM/JOIN/INTO/UPDATE).

Stored SQL is already query-string-free and path-token-redacted by the middleware, and carries no bindings — only
the SQL text, time and caller.
