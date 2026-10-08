# Gatsby JSON:API Extras — agent index

Submodule of `gatsby`. Adds a JSON:API Extras field enhancer for internal link fields and config to
expose Drupal menus to JSON:API for a Gatsby front end. Depends on `gatsby` and core `jsonapi`. No
config UI (`configure` null), no permissions, no Drush, no config schema.

- **The `alias_link` field enhancer (UUID + alias transforms) and the menu_link_content setup** →
  [api/enhancer.md](api/enhancer.md)

Key facts:
- Plugin: `AliasLinkEnhancer` (`@ResourceFieldEnhancer id="alias_link"`) — apply it to a link field in a
  JSON:API Extras resource config.
- Ships `config/optional/jsonapi_extras.jsonapi_resource_config.menu_link_content--menu_link_content.yml`.
- Requires the Gatsby account to have "Administer menus and menu items" to read the menu endpoint.
- Parent module docs: [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md)
