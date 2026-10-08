# Services

## menu_item_extras.menu_link_tree_handler (`MenuLinkTreeHandler`)
Args: `@entity_type.manager`, `@entity.repository`. Builds/augments the menu link tree with
each link's rendered field content and view mode — use it to render enriched menus in custom
code or a custom menu block. See `MenuLinkTreeHandlerInterface`.

## menu_item_extras.menu_link_content_helper (`MenuLinkContentService`)
Manages the fieldable `menu_link_content` entity definition (installing/updating field
storage) and clears extra data. Backs the Drush command and clear-data controllers. See
`MenuLinkContentServiceInterface`.

## Other services
- `menu_item_extras.utility` (`Utility`) — machine-name sanitising / theme suggestion helpers.
- `menu_item_extras.update` (`UpdateHelper`) — update-hook helper.
- `menu_item_extras.uninstall_validator` — blocks uninstall while extra data remains.
- `cache_context.menu_item_extras_link_item_content_active_trails` — active-trail cache context.

## Entity & plugins (for reference)
- Entity class: `MenuItemExtrasMenuLinkContent` (extends core `MenuLinkContent`, adds
  `body` + `view_mode` fields).
- Views: `MenuLinkContentViewsData` and argument-default plugin
  `MenuLinkContentId` expose menu link content to Views.
