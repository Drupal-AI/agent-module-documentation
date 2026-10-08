# Flags UI — agent index

Admin CRUD for the base module's flag-mapping config entities. Depends on `flags`. Adds no
permissions of its own (reuses `administer flag mapping`), no schema, no plugin types.

- **The admin routes/paths, entities managed, and access** → [configure/admin.md](configure/admin.md)

Key facts:
- Config/menu root `flags.menu` → `/admin/config/regional/flags` (the `configure` route).
- Manages `country_flag_mapping` (`/admin/config/regional/flags/countries…`) and
  `language_flag_mapping` (`/admin/config/regional/flags/languages…`) — each maps `source` code →
  `flag` code (entities defined by the base `flags` module).
- All routes gated by `administer flag mapping` (list via `_permission`; add/edit/delete via entity
  access → `FlagMappingAccessController`).
