<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View mode page — agent index

Exposes an entity at extra paths that render it in a chosen **view mode** (e.g. teaser at
`/{alias}/summary`). Driven by `view_mode_page_pattern` config entities and an inbound/outbound
path processor. Admin UI: `/admin/config/search/view-mode-page`
(route `entity.view_mode_page_pattern.collection`, permission `administer view_mode_page`).

- **Create/read patterns: config entity fields, drush, the internal route** →
  [configure/patterns.md](configure/patterns.md)
- **The AliasType plugin type (`canonical_entities`) and how to add one** →
  [plugins/alias-type.md](plugins/alias-type.md)
- **Path processor & repository services** → [api/services.md](api/services.md)

Key facts:
- Config entity: `view_mode_page.pattern.<id>`; exported keys: `id`, `label`, `type`, `pattern`,
  `view_mode`, `selection_criteria`, `selection_logic`, `weight`, `relationships`.
- `pattern` MUST contain `%` (placeholder for the entity's normal URL/alias), e.g. `/%/summary`.
- `type` is an AliasType plugin id, e.g. `canonical_entities:node`. `view_mode` e.g. `teaser`, `full`.
- Requests are rewritten to `/view_mode_page/{view_mode}/{entity_type}/{entity_id}` (a sub-request,
  not a redirect). No Drush commands.
