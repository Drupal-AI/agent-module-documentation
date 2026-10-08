# Permissions

Defined in `simple_megamenu.permissions.yml`. The content entity's `admin_permission` is
`administer simple mega menu entities`.

| Permission | Gates |
|---|---|
| `administer simple mega menu entities` | Full admin of mega-menu entities (restricted). |
| `add simple mega menu entities` | Create new mega-menu entities. |
| `edit simple mega menu entities` | Edit mega-menu entities. |
| `delete simple mega menu entities` | Delete mega-menu entities. |
| `access simple mega menu overview` | See the admin overview/list page. |
| `view published simple mega menu entities` | View published entities. |
| `view unpublished simple mega menu entities` | View unpublished entities. |
| `access simple mega menu entities canonical page` | Access an entity's canonical page (enforced by `SimpleMegaMenuAccessCanonicalPageSubscriber`). |
| `view all simple mega menu revisions` | View any revision. |
| `revert all simple mega menu revisions` | Revert revisions (also needs view + edit rights). |
| `delete all simple mega menu revisions` | Delete revisions (also needs view + delete rights). |

Notes:
- Bundle (`simple_mega_menu_type`) administration uses core `administer site configuration`
  (the config bundle entity's `admin_permission`), not a module permission.
- Attaching a mega menu to a menu link is governed by core menu-link permissions
  (`administer menu`), since the autocomplete lives on the menu link content form.
