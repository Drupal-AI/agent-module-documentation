# The dashboard, its permission, panes & views

Total Control has **no settings form**. Setup is: enable it (with `page_manager`, `panels`,
`ctools`), grant the permission, and visit `/admin/dashboard`. Customisation is done through
Page Manager (the page/variant) and Views (the listings).

## The page & route

- Page Manager page config entity: `page_manager.page.total_control_dashboard`, path
  **`/admin/dashboard`**, one Panels variant
  (`page_manager.page_variant.total_control_dashboard-http_status_code-0`).
- Route name:
  `page_manager.page_view_total_control_dashboard_total_control_dashboard-http_status_code-0`.
  `Drupal\total_control\Routing\RouteSubscriber` (runs after Page Manager's route alter, prio
  -170) stamps `_permission: have total control` onto it.
- Adds a "Dashboard" menu link (`system.total_control_dashboard` menu) and dynamic local-task
  tabs (Dashboards / Comments / Categories) via derivatives.

## Permission

| Permission | Gates |
|---|---|
| `have total control` | seeing `/admin/dashboard` **and** the control view pages |

Grant it to a role: `drush role:perm:add <role> 'have total control'` (or People → Permissions).

## Pane block plugins (Dashboard category)

Placed on the Panels variant; each is a normal Block plugin you can also drop anywhere via
Block layout:

| Plugin id | Pane |
|---|---|
| `total_control_dashboard` | intro / "Take Total Control" block |
| `content_overview` | content counts / overview |
| `create_content` | quick "add content" links per type |
| `administer_content_types` | links to manage content types |
| `administer_menus` | links to manage menus |
| `administer_taxonomy` | links to manage vocabularies |
| `administer_panel_pages` | links to manage Page Manager pages |

Place one as a block in code:

```php
use Drupal\block\Entity\Block;
$theme = \Drupal::config('system.theme')->get('default');
Block::create([
  'id' => 'my_content_overview', 'theme' => $theme, 'region' => 'content',
  'plugin' => 'content_overview',
  'settings' => ['id' => 'content_overview', 'label' => 'Content overview', 'provider' => 'total_control'],
])->save();
```

## Views (the listings)

| View | Page path | Notes |
|---|---|---|
| `control_content` | `/admin/dashboard/content/all` | full content admin + bulk operations |
| `control_users` | `/admin/dashboard/users` | user admin |
| `control_content_panes`, `control_users_panes` | — | embedded pane variants on the dashboard |
| `control_terms` | `/admin/dashboard/categories` | installed when Taxonomy is enabled |
| `control_comments` | — | installed when the Comment module is enabled |

The `control_comments` / `control_terms` (and standard comment) configs are copied into place
by `hook_install()` / `hook_modules_installed()` when comment/taxonomy are on.

## Customising

- **Panes:** cog wheel on the dashboard, or *Structure → Pages* → the Total Control dashboard
  page → edit the variant/panes.
- **Listings:** *Structure → Views* → override `control_content` / `control_users` /
  `control_terms` / `control_comments`.
- There is no `configure` route; nothing lives in a module settings config object.
