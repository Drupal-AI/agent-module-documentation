# Drush commands

Registered via `drush.services.yml` →
`Drupal\menu_item_extras\Commands\MenuItemExtrasCommands` (Drush >= 12).

## menu-item-extras-clear-extra-data {menu}
`MenuItemExtrasCommands::clearExtraData($menu)` — clears the extra field/body data stored on
the given menu's links (the `view_mode` and attached field values). Useful before
uninstalling or when resetting a menu to plain core behaviour.

```bash
drush menu-item-extras-clear-extra-data main
```
Argument `{menu}` is the menu machine name. Backed by
`menu_item_extras.menu_link_content_helper` (`MenuLinkContentService`). The equivalent UI
action lives at `/admin/modules/uninstall/extra_data/menu_item_extras`.
