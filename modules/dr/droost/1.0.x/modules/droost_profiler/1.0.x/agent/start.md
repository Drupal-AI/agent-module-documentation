<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Profiler (droost_profiler) — agent index

Self-contained per-request profiler for Droost: records DB queries, timing, memory and response cacheability,
and exposes them as **read-only MCP tools**. No external dependency. Depends only on `droost`.
Version **1.0.0-rc1** (dir 1.0.x). Core `^10.3 || ^11 || ^12`. **Local development only.**

## What it provides
- **2 MCP tools** (read-only; gated by mcp_server `access mcp server`; `{success, message, data}` envelope):
  `droost_profile_list`, `droost_profile`. See [tools/profiler-tools.md](tools/profiler-tools.md).
- **1 stack middleware**: `droost_profiler.middleware` (`StackMiddleware\Profiler`, `http_middleware` priority 210).
- **1 service**: `droost_profiler.storage` (`ProfileStorage`).
- **1 table**: `droost_profile` (`hook_schema`) — per-request profiles; JSON query log in `data`.
- **1 permission**: `administer droost profiler` (`restrict access: true`).
- **1 route/settings form**: `droost_profiler.settings` -> `/admin/config/development/droost-profiler`
  (`SettingsForm`). Config `droost_profiler.settings` (`enabled`, `max_profiles`) with schema. `configure` route.
- **hook_help** (`DroostProfilerHooks`) at `help.page.droost_profiler`.

## Mechanism (source)
- `Profiler::handle()` runs only when `enabled` and `profilable()` (skips `/_mcp` and static assets); starts
  `Database::startLog()`, times the request, and `record()`s a profile; drains the log on throw; a storage failure
  is logged, never fatal.
- `record()` stores the path only (query string dropped) and `redactPath()`s password-reset / account-cancel token
  segments; `formatQueries()` caps at 1000 queries and truncates each SQL at 2000 chars.
- `ProfileStorage` inserts + `prune()`s to `max_profiles`; `list()` / `load()` / `latest()` read back.

## Docs
- The two tools and the settings/config → [tools/profiler-tools.md](tools/profiler-tools.md), [config/settings.md](config/settings.md).
