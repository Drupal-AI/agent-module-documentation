<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Profiler Sync (convivial_profiler_sync) — agent index

Submodule of **convivial_profiler**. Adds admin JSON **export / import** of the profiler pipeline
definitions. No schema, no plugins, no services (only a `hook_help`). Package `Convivial`.
Depends on `convivial_profiler`. Core `^10.2 || ^11 || ^12`. GPL-2.0-or-later.

## Routes (both `_permission: administer convivial profiler sync`)

- `convivial_profiler_sync.export` — `/admin/config/convivial/profiler/export` —
  `ProfilerExportForm` (`src/Form/ProfilerExportForm.php`). Reads `profilers` from
  `convivial_profiler.settings`, shows `Json::encode($profilers)` in a read-only textarea; no real
  submit.
- `convivial_profiler_sync.import` — `/admin/config/convivial/profiler/import` —
  `ProfilerImportForm` (`src/Form/ProfilerImportForm.php`). `Json::decode()`s the pasted textarea
  and saves it via `$config->set('profilers', …)->save()`, then redirects to
  `convivial_profiler.list`. Both are `FormBase`, `@internal`, standard CSRF-protected admin forms.

## Permission / links

- One permission: **`administer convivial profiler sync`** (`*.permissions.yml`).
- Local task link `Import` (`*.links.task.yml`); `info.yml` declares `configure:
  convivial_profiler_sync.settings` (no such route is defined by this submodule).

## Notes

- The data moved here is **pipeline configuration**, not collected visitor data.
- The import handler saves to the config object read back by the parent module's list form; a
  mismatch between the config name it writes and the one the list reads would simply mean an import
  does not appear — a functional detail, not an access boundary. Both routes are admin-gated.
