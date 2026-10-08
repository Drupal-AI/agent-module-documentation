# Expose menus

No dedicated settings form. Enable menus through the GraphQL Compose schema config; optionally
turn on per-item route resolution.

## Enable a menu (and route resolution)

Config object `graphql_compose.settings.graphql_compose_server`:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.menu.main.enabled", TRUE);            // expose the "main" menu
  $c->set("entity_config.menu.main.menu_route_enabled", TRUE); // also resolve each item's target entity
  $c->save();
'
drush cget graphql_compose.settings.graphql_compose_server entity_config.menu.main
```

`menu` is a config-entity type, so the GraphQL Compose schema form lists the site's menus.
The **Enable Route on menu** checkbox is added by this submodule's
`hook_graphql_compose_entity_type_form_alter`, stored at `menu_route_enabled` and registered
into the config schema via `hook_config_schema_info_alter`. Warning: enabling routes loads all
entities in the menu on query, so use only on small menus.

## What it adds

- EntityTypes: `Menu`, `MenuLinkContent`.
- SchemaTypes: `MenuItem` (nested link tree), `MenuItemAttributes`, `MenuAvailable`.
- `MenusSchemaExtension` + DataProducers: `MenuLinkEntity`, `MenuLinkId`, `MenuLinkIsContent`,
  `MenuLinkRouteEnabled`, `MenuLinkUrlOverride`; wrapper `MenuLinkContentWrapper`.
- Menu-link URLs resolve through routes — hence the dependency on `graphql_compose_routes`.
- If `menu_item_extras` is installed, menu-link fields are added to the form/schema.
- `graphql_compose_menus_menu_access()` grants view access to an enabled menu inside a GraphQL request.
