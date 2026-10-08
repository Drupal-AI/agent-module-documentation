# TacJS Log — agent index

Submodule of TacJS. Records "proof of consent" to the `tacjslog` DB table and shows an admin
overview report. No config, no config schema; its only state is the `tacjslog` table.

- **Routes, the `tacjslog` table schema, controller behaviour** →
  [api/overview.md](api/overview.md)

Key facts:
- Front-end JS POSTs to `tacjs_log.report` → `/reports/tacjslog/{service}` (perm `access content`);
  `LogController::report()` inserts `{timestamp, ip_address, services_allowed}` into `tacjslog`.
- Admin report at `tacjs_log.overview` → `/admin/config/system/tacjs/overview`
  (perm `administer tacjs`), a paged sortable table.
- Table `tacjslog` columns: `uid` (serial PK), `timestamp` (int), `ip_address` (varchar 255),
  `services_allowed` (text).
