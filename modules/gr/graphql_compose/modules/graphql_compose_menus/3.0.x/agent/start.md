# GraphQL Compose: Menus — agent index

Adds Drupal menus to the schema: query a menu by name and get its nested link tree. Depends on
`graphql_compose`, `graphql_compose_routes` and core `menu_link_content`. No settings form of its own.

- **Expose a menu, the per-menu route toggle, the schema types/producers** →
  [configure/menus.md](configure/menus.md)

Key facts:
- Enable a menu: `entity_config.menu.<menu>.enabled: true` (menu is a config entity).
- Resolve each item's target entity: `entity_config.menu.<menu>.menu_route_enabled: true`
  (load-heavy on large menus).
- EntityTypes: `Menu`, `MenuLinkContent`; SchemaTypes: `MenuItem`, `MenuItemAttributes`, `MenuAvailable`.
- DataProducers: `MenuLinkEntity`, `MenuLinkId`, `MenuLinkIsContent`, `MenuLinkRouteEnabled`, `MenuLinkUrlOverride`.
