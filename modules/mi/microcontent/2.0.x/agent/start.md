# Micro-content — agent index

A lightweight, fieldable, revisionable, translatable **reusable content entity** (`microcontent`) with a
config bundle entity (`microcontent_type`). Managed through the standard entity UI; no global settings
form (`configure` null). Depends on `user`, `system`. Provides permissions and config schema; defines
**no plugin types of its own** (it does implement a `backfill_formatter` `BackFillQuery` plugin).

- **Types, fields, routes, config entities, Entity Browser/Views config** → [configure/types.md](configure/types.md)
- **Permission model** (static + dynamic per-bundle perms, access handler logic) →
  [permissions/permissions.md](permissions/permissions.md)
- **Creating/loading micro-content programmatically** (entity keys, storage, ownership) →
  [api/entity.md](api/entity.md)

Key facts:
- Entity id `microcontent`, bundle entity `microcontent_type` (bundle key `type`,
  `permission_granularity = bundle`, `admin_permission = administer microcontent`).
- Items: `/admin/content/microcontent`; types: `/admin/structure/microcontent-types`
  (`field_ui_base_route`, so Field UI attaches fields per type).
- Editorial base: owner, `status` (published), revisions (`show_revision_ui = TRUE`), translation,
  optional content moderation via `MicrocontentModerationHandler`.
