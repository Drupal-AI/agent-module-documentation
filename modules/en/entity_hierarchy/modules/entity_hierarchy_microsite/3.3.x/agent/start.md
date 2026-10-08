# Entity Hierarchy Microsites — agent index

Turns a subtree of an Entity Hierarchy into a branded "microsite": a
`entity_hierarchy_microsite` content entity points at a home node and optionally auto-builds
a section menu, plus branding and a block visibility condition scoped to that subtree.

- **The Microsite entity (fields, admin UI, permission, menu generation, overrides)** →
  [configure/microsites.md](configure/microsites.md)
- **Blocks, block condition, cache context, and the lookup service / alter hooks (code)** →
  [api/blocks-and-lookup.md](api/blocks-and-lookup.md)

Key facts:
- Content entity id `entity_hierarchy_microsite`, base table `entity_hierarchy_microsite`,
  collection/config route `entity.entity_hierarchy_microsite.collection`
  (`/admin/structure/entity-hierarchy-microsites`).
- Fields: `name`, `home` (entity_reference to the landing node), `generate_menu` (bool),
  `logo` (media reference). Permission: `administer entity hierarchy microsites`.
- Auto menu goes into the `entity-hierarchy-microsite` menu; per-item overrides are
  `eh_microsite_menu_override` entities.
- Plugins: block `entity_hierarchy_microsite_menu`, block
  `entity_hierarchy_microsite_branding`, condition `entity_hierarchy_microsite_child`.
- Depends on `entity_hierarchy`, `media`, `node`, `menu_ui`, `system`.
