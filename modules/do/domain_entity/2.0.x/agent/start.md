<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Access Entity — agent index

Extends Domain's per-domain access from nodes to **any fieldable entity type**. Enabling an
entity type adds a multi-value `domain_access` entity-reference field (target `domain`) and the
module filters access + queries so an entity is only visible on the domain(s) it references.

- **Enable domain access per entity type / per-bundle behavior, the settings form, config** →
  [configure/enable-and-behavior.md](configure/enable-and-behavior.md)
- **The `domain_entity.mapper` service, the `domain_access` field, runtime hooks, domain source** →
  [api/mapper-and-access.md](api/mapper-and-access.md)
- **Static + dynamic per-bundle permissions** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `configure` route: `domain_entity.ui` at `/admin/config/domain/entities` (permission
  `administer domains`). Per-type settings: `domain_entity.settings` at
  `/admin/config/domain/entities/{entity_type_id}`.
- Field: name `domain_access` (constant `DomainEntityMapper::FIELD_NAME`), type
  `entity_reference` → `domain`, cardinality unlimited. "Enabled" = that field storage exists.
- Behaviors: `auto` (silent affiliation to current domain) / `user` (widget). Stored in the
  field's `third_party_settings.domain_entity` (`domains`, `behavior`, `exclude_routes`).
- Global config `domain_entity.settings` → `bypass_access_conditions` (default `false`) disables
  the access query alter.
- Submodule: `domain_menu_access` (documented separately, nested under this project).
