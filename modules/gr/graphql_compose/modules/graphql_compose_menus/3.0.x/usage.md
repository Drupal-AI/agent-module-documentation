GraphQL Compose: Menus adds Drupal menus to the schema so a decoupled front end can query a menu by name and receive its full tree of links (title, url, attributes, children).

---

This submodule exposes menus through GraphQL Compose. It registers `Menu` and `MenuLinkContent` EntityType plugins and SchemaType plugins `MenuItem`, `MenuItemAttributes` and `MenuAvailable`, plus a `MenusSchemaExtension` and DataProducers (`MenuLinkEntity`, `MenuLinkId`, `MenuLinkIsContent`, `MenuLinkRouteEnabled`, `MenuLinkUrlOverride`) and a `MenuLinkContentWrapper`. Enabling a menu (as a config entity in the GraphQL Compose schema config) exposes it; querying a menu returns its nested `MenuItem` tree. A per-menu toggle `menu_route_enabled` (config key `entity_config.menu.<menu>.menu_route_enabled`) additionally resolves each item's `route.entity` — the underlying content entity for the link — which is powerful but can be load-heavy for large menus (hence the warning in the UI). Because menu links resolve their URLs through routes, it **depends on `graphql_compose_routes`** (and core `menu_link_content`). It integrates with `menu_item_extras` when present to expose menu-link fields. A `hook_menu_access` grants view access to menu entities within a GraphQL request when the menu is enabled.

---

- Query a site menu (e.g. `main`) by name and render its links in a decoupled nav.
- Return a nested menu tree with titles, URLs and child items.
- Expose menu link attributes (classes, target, rel) via `MenuItemAttributes`.
- Enable a menu for GraphQL as a config entity in the schema settings.
- Resolve each menu item's target content entity with `menu_route_enabled` (small menus only).
- Build a header/footer navigation from Drupal-managed menus.
- Keep menu editing in Drupal while consuming structure over GraphQL.
- Expose custom `menu_link_content` links to the client.
- Support multilingual menus (link titles per language).
- Query which menus are available (`MenuAvailable`).
- Surface menu-link fields when `menu_item_extras` is installed.
- Drive breadcrumbs/side navs from menu data (with the Routes submodule).
- Distinguish content links from route links (`MenuLinkIsContent`).
- Apply URL overrides on menu links (`MenuLinkUrlOverride`).
- Render megamenus from a nested menu query.
- Provide stable menu structure to a static-site generator at build time.
- Expose account/user menus to an authenticated client.
- Localize navigation for a headless multilingual site.
- Avoid hard-coding navigation in the front end by sourcing it from Drupal.
- Combine menu links with resolved route data for internal linking.
