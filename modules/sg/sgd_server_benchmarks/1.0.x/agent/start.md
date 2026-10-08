<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Guardian Server Benchmarks (sgd_server_benchmarks) — agent index

**Runs PHP / database / file-IO benchmarks on demand from a report page and surfaces the last results on the Status report and (optionally) the Site Guardian API.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Route:** `sgd_server_benchmarks.report` → `/admin/reports/server-benchmarks` (`ServerBenchmarksForm`)
- **Permission:** `administer site configuration`
- **Hooks:** `hook_requirements()` (adds PHP/DB/IO lines to the Status report), `hook_site_guardian_status()` (returns results to the Site Guardian API)
- **Config:** results stored in `sgd_server_benchmarks.config`; no user-facing settings
- **Security:** the only route (which runs the benchmarks) is permission-gated with `administer site configuration`; benchmarks run solely on manual form submit, never during a status-report render or API call; the `iterations` input is an admin-supplied multiplier with `set_time_limit(120)` (heavy runs are possible but admin-only). No anonymous or mutating public endpoints.