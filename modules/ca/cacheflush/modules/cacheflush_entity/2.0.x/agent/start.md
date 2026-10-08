# Cacheflush Entity — agent index

Defines the **`cacheflush` content entity** (base table `cacheflush`) that stores CacheFlush
presets, plus procedural CRUD helpers. Required by the base `cacheflush` module. No UI, no routes,
no permissions, no config — those come from `cacheflush_ui`.

Core facts:
- Entity type id **`cacheflush`**, `base_table = "cacheflush"`, keys `id` / `title` (label) / `uuid`.
- Base fields: `id`, `uuid`, `title`, `uid` (author, defaults to current user), `status`
  (1 = enabled), `data` (map — the selected clear functions), `created`, `changed`.
  `menu` and `cron` fields are added by the `cacheflush_ui` / `cacheflush_cron` submodules.
- `getData()` / `setData()` (de)serialise the preset's `data` map.

Docs:
- **Entity fields, getData/setData, and the `cacheflush_*` helper functions** →
  [api/entity.md](api/entity.md)
