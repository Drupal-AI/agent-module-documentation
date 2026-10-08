# Configure Menu Breadcrumb

Settings form `/admin/config/user-interface/menu-breadcrumb` (route `menu_breadcrumb.settings`,
form `SettingsForm`, permission `administer site configuration`). Config object
`menu_breadcrumb.settings` (schema `config/schema/menu_breadcrumb.schema.yml`, install defaults
in `config/install/`).

## Global options (booleans unless noted)
| Key | Effect |
|---|---|
| `determine_menu` | Use the menu (or taxonomy) the page belongs to for the breadcrumb. |
| `disable_admin_page` | Do not build menu breadcrumbs on admin pages (default TRUE). |
| `append_current_page` | Include the current page as the final crumb if it is in the menu. |
| `current_page_as_link` | Render that final current-page crumb as a link. |
| `stop_on_first_match` | End the trail at the first matching menu item. |
| `append_member_page` | Append a trail when the page is a member of a taxonomy term whose menu link has "Taxonomy Attachment". |
| `member_page_as_link` | Show that attached final crumb as a link. |
| `remove_home` | Remove the Home link. |
| `add_home` | Ensure the first crumb is the `<front>` link. |
| `front_title` (int) | How to render the Home title (site name / "Home" / etc.). |
| `exclude_empty_url` | Drop menu items with empty URLs. |
| `exclude_disabled_menu_items` | Drop disabled menu items. |
| `derived_active_trail` | Derive the MenuActiveTrail from the RouteMatch. |

## Per-menu configuration
`menu_breadcrumb_menus` — a sequence keyed by menu machine name, each a mapping:
- `enabled` (int) — include this menu.
- `weight` (int) — order menus; lower weight is tried first (e.g. `main` = `-10`).
- `taxattach` (int) — enable "Taxonomy Attachment" for this menu.
- `langhandle` (int) — language handling mode for multilingual sites.

Only enabled menus are consulted, in weight order, until a trail is found (respecting
`stop_on_first_match`). All exportable as config.

## Extending
The active builder is the service `menu_breadcrumb.breadcrumb.default`
(`MenuBasedBreadcrumbBuilder`, tag `breadcrumb_builder` priority 1010). To further customize,
register your own higher-priority `breadcrumb_builder` or decorate this service.
