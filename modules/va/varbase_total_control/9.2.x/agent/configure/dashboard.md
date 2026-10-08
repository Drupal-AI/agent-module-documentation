# Varbase Total Control — dashboard, blocks, access

No settings form. You configure it through the Page Manager dashboard page, block instance
settings, and permissions.

## Access

- The dashboard is a Page Manager page `total_control_dashboard`. `RouteSubscriber::alterRoutes()`
  (priority -170, after Page Manager) sets `_permission: 'have total control'` on both variant
  routes:
  `page_manager.page_view_total_control_dashboard_total_control_dashboard-panels_variant-0` and
  `…-panels_variant-1`. That permission is provided by the **Total Control** module, not this one.
- Shipped recipe `recipes/default/recipe.yml` grants `have total control` to `editor`,
  `content_admin`, `seo_admin`, `site_admin` roles. Apply it, or grant the permission manually at
  `/admin/people/permissions`.

## Block plugins (`src/Plugin/Block`)

| id | Label | Configurable settings |
|---|---|---|
| `varbase_dashboard_user` | Varbase Dashboard User | current user summary |
| `varbase_quick_links` | Quick Links | — |
| `varbase_create_content` | Create New Content | which content types to show as create links (`blockForm`) |
| `varbase_content_overview` | My Site Overview | `varbase_total_control_types_overview` (types to count), `varbase_total_control_comments_overview` (comment counts per type), `varbase_total_control_spam_overview` (bool) |

These are standard core block plugins — place them on any Panels/Layout/block region, or edit the
instances already placed on the dashboard variant (see below). Configure per-instance via the
block's gear/settings form.

## Dashboard layout config

`config/optional/page_manager.page_variant.total_control_dashboard-panels_variant-0.yml` defines
the two-column (`layout_twocol`) variant and the placed panes: `varbase_dashboard_user`,
`varbase_create_content` (default types `landing_page`, `page`), the Views block
`views_block:control_content_panes-pane_tc_new`, `varbase_quick_links`, and
`varbase_content_overview`. Edit this variant at *Structure → Pages* (Page Manager) or via the cog
on each pane to change what shows.

## Condition plugin

`module_enabled` (`@Condition`, `src/Plugin/Condition/ModuleEnabled.php`) — a visibility condition
taking a `module` machine name; use it on a block/pane so it only renders when that module is
enabled.

## Charts / CSS

- `info.yml` `install:` pulls in `charts`, `charts_c3`; `config/optional/charts.settings.yml` sets
  c3/area defaults. Dashboard widgets can render charts through the Charts module.
- `pageAttachments()` attaches library `varbase_total_control/vtc` only on the two dashboard
  variant routes.
