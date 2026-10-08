# Domain Path — agent index

Per-domain URL aliases for content in a multi-domain (Domain module) site. Each alias is a
core `path_alias` entity tagged with a `domain_id`. Requires the **domain** module. The
optional **domain_path_pathauto** submodule adds automatic per-domain aliases.

- **Settings (config object/keys), the settings form, permission, entity types & label
  options** → [configure/settings.md](configure/settings.md)
- **How aliases are stored/resolved (the `domain_id` field on path_alias, the `domain_path`
  entity field, decorators & path processor, Domain Access/Source integration)** →
  [api/aliases.md](api/aliases.md)

Key facts: settings config object `domain_path.settings` (keys `entity_types`,
`alias_title`, `hide_path_alias_ui`, `use_advanced_group`, `language_method`); settings route
`entity.domain_path_settings` → `/admin/config/domain/domain_path`; permission
`administer domain paths`. Aliases = `path_alias` entities with a `domain_id` base field
(load them via `loadByProperties(['domain_id' => $id])`). Default enabled entity type: `node`.
